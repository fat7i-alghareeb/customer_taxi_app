# customertaxi — System Architecture & Data Model

> **Document purpose:** This document describes the complete system design for the customertaxi platform.
> It covers what the system is, who uses it, how it is structured, what data it stores, and how the core
> business flows work. It is the reference for building the ERD and understanding every domain in the system.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [System Architecture](#2-system-architecture)
3. [Actors](#3-actors)
4. [Backend Services](#4-backend-services)
5. [Data Model — ERD Source](#5-data-model--erd-source)
6. [Business Logic & Flows](#6-business-logic--flows)
7. [Real-Time Layer](#7-real-time-layer)
8. [Notifications](#8-notifications)
9. [Payment System](#9-payment-system)
10. [Promo & Discount System](#10-promo--discount-system)
11. [Client vs. Server Responsibility](#11-client-vs-server-responsibility)
12. [Security Design](#12-security-design)
13. [Edge Cases & Failure Handling](#13-edge-cases--failure-handling)
14. [Open Decisions](#14-open-decisions)

---

## 1. Project Overview

### 1.1 What the System Is

customertaxi is a ride-hailing platform with a Flutter passenger app (existing codebase) and a Flutter driver app (to be built). The system is geography-agnostic — it does not restrict service to a specific country or city. The service zone is a single global configurable area defined by a center point and a maximum radius in kilometers.

The existing Flutter app has a complete UI booking flow but no real backend. All pricing is mocked on the client, no bookings are actually submitted, authentication is faked with hardcoded tokens, and saved locations exist only on-device. This document defines the complete backend system needed to make the platform production-ready.

### 1.2 Confirmed Design Decisions

| Topic                           | Decision                                                                                                 |
| ------------------------------- | -------------------------------------------------------------------------------------------------------- |
| Geography                       | Europe-targeted, geography-agnostic architecture, single global service area                      |
| Currency                        | Multi-currency — configurable globally in app_config                                                     |
| Passengers                      | B2C only — any individual with a phone                                                                   |
| Auth                            | Phone + 4-digit OTP only                                                                                 |
| Driver onboarding               | Admin creates all driver accounts manually with offline verification                                     |
| Driver vehicle type             | Admin-assigned, admin-changeable only                                                                    |
| Driver documents                | None in v1 (verified manually by admin offline)                                                          |
| Rating system                   | None in v1                                                                                               |
| Pricing                         | Distance × rate + Duration × rate per vehicle type; minimum fare per vehicle type; flat rates (no surge) |
| Cancellation fees               | None — always free                                                                                       |
| Payment                         | Card on file only (Stripe-style token), no cash, no wallet                                               |
| Multiple cards                  | Yes — passengers can save multiple cards                                                                 |
| Card storage                    | Gateway token only (PCI-safe), store last 4 digits + brand for display                                   |
| Charge timing                   | Card charged at trip completion, not at booking                                                          |
| Refunds                         | Automatic refund to original card on cancellation                                                        |
| Promo codes                     | Percentage-off, global usage cap, v1                                                                     |
| Multi-stop limit                | Configurable by admin (default 5)                                                                        |
| Stop editing mid-trip           | Locked at booking time                                                                                   |
| Scheduled trip advance          | Up to 7 days ahead                                                                                       |
| Driver assignment for scheduled | Matching begins 30 minutes before scheduled_at                                                           |
| Quote validity window           | 5 minutes                                                                                                |
| Trip history                    | Last 12 months visible in-app                                                                            |
| Passenger notifications         | Driver assigned (push), Driver arrived (push + SMS)                                                      |
| Scheduled reminder              | Push notification 30 minutes before scheduled_at                                                         |
| Driver notifications            | Push notification per trip request, in-app accept                                                        |
| Driver location updates         | HTTP PATCH polling every 10 seconds (no WebSockets for driver-to-server)                                 |
| Driver matching algorithm       | TBD                                                                                                      |
| Driver decline behavior         | TBD                                                                                                      |
| Driver earnings / commission    | Not in v1 (managed offline)                                                                              |
| Driver payouts                  | Not in v1 (managed offline)                                                                              |
| Service zone                    | Single global circular zone (center + radius)                                                            |
| Push notifications              | Firebase FCM                                                                                             |
| SMS provider                    | Provider-agnostic (plugged via config)                                                                   |
| Audit log                       | Basic: action type + actor + timestamp                                                                   |
| API versioning                  | URL versioning: /api/v1/...                                                                              |
| Multi-device                    | Single FCM token per user (replaced on each login)                                                       |
| User blocking                   | Not in v1                                                                                                |
| Trip reference code             | Yes — short alphanumeric (e.g. TRP-4821)                                                                 |
| Trip receipt                    | None in v1                                                                                               |
| Dispute / support               | Not in v1                                                                                                |
| Soft delete                     | Yes — all user-facing tables have deleted_at                                                             |
| OTP length                      | 4 digits                                                                                                 |
| Localization                    | Backend returns translated strings for all 3 languages (ar, en, nl)                                      |

---

## 2. System Architecture

### 2.1 High-Level Diagram

```
┌───────────────────────────────────────────────────────────────────┐
│                          CLIENT LAYER                             │
│                                                                   │
│   Flutter Passenger App (existing)   Flutter Driver App (future)  │
│   ├─ Auth (phone + OTP)              ├─ Auth (phone + OTP)        │
│   ├─ Trip booking (4-step flow)      ├─ Trip acceptance            │
│   ├─ Multi-stop selection            ├─ External Map Navigation    │
│   ├─ Scheduled trips                 ├─ Status trigger buttons     │
│   ├─ Saved locations                 └─ HTTP Location Polling (10s)│
│   ├─ Payment card management                                       │
│   └─ Active trip tracking (WebSocket)                             │
│              │                              │                     │
│              └──────────────┬───────────────┘                     │
│                             │ HTTPS + WebSocket (wss://)          │
│                             │ (WebSockets: Passenger ONLY)        │
└─────────────────────────────┼─────────────────────────────────────┘
                              │
┌─────────────────────────────▼─────────────────────────────────────┐
│                           API GATEWAY                             │
│  - Route all /api/v1/* requests                                   │
│  - JWT verification (RS256 public key)                            │
│  - Per-endpoint rate limiting (per user ID + per IP)              │
│  - Payload size enforcement                                       │
│  - CORS policy                                                    │
│  - WebSocket upgrade routing (/ws/*)                              │
│  - Request / response logging                                     │
└────────┬──────────────────────────────────────────────────────────┘
         │
         ├──────────────────────────────────────────────────┐
         │                                                  │
┌────────▼─────────┐  ┌───────────────┐  ┌──────────────┐  ┌──────────────────┐
│   AUTH SERVICE   │  │ TRIP SERVICE  │  │   PRICING    │  │  DRIVER SERVICE  │
│                  │  │               │  │   SERVICE    │  │                  │
│ - OTP generation │  │ - Lifecycle   │  │              │  │ - Driver state   │
│ - OTP verify     │  │ - Multi-stop  │  │ - Fare quote │  │ - Location mgmt  │
│ - JWT issuance   │  │ - Scheduling  │  │ - Base fare  │  │ - Trip matching  │
│ - Token refresh  │  │ - Status FSM  │  │ - Min fare   │  │ - Availability   │
│ - User mgmt      │  │ - Cancellation│  │ - Currency   │  │ - Push dispatch  │
│ - Phone registry │  │ - History     │  │ - Quote lock │  │                  │
└────────┬─────────┘  └───────┬───────┘  └──────┬───────┘  └──────┬───────────┘
         │                    │                  │                 │
         └────────────────────┴──────────────────┴─────────────────┘
                                       │
              ┌────────────────────────▼──────────────────────────┐
              │                  SHARED DATA LAYER                │
              │                                                   │
              │  ┌─────────────┐  ┌──────────────┐  ┌─────────┐  │
              │  │ Primary DB  │  │ Cache Layer   │  │ Message │  │
              │  │ (Relational)│  │ (Key-Value)   │  │ Queue   │  │
              │  │ All tables  │  │ OTP sessions  │  │ Events  │  │
              │  │ in Section 5│  │ Quote TTL     │  │ Notifs  │  │
              │  └─────────────┘  └──────────────┘  └─────────┘  │
              └───────────────────────────────────────────────────┘
                                       │
              ┌────────────────────────▼──────────────────────────┐
              │                 EXTERNAL SERVICES                 │
              │                                                   │
              │  ┌────────────┐  ┌─────────────┐  ┌───────────┐  │
              │  │ SMS Gateway│  │ Mapping APIs│  │ Payment   │  │
              │  │ (OTP SMS)  │  │ Geocoding   │  │ Gateway   │  │
              │  │ TBD        │  │ Directions  │  │ (Stripe)  │  │
              │  └────────────┘  │ Places      │  └───────────┘  │
              │                  └─────────────┘                  │
              │  ┌────────────┐                                   │
              │  │ Firebase   │                                   │
              │  │ FCM        │                                   │
              │  └────────────┘                                   │
              └───────────────────────────────────────────────────┘
```

### 2.2 Architecture Style

The system follows a **modular monolith** approach for v1. All communication is performed via a standard **REST API** with JSON payloads exclusively (No GraphQL, No gRPC). The Auth, Trip, Pricing, and Driver domains are internally isolated modules sharing a single database. Each domain can be extracted into an independent microservice later without breaking any client contract.

---

## 3. Actors

| Actor                | Description                                                          | Auth Method                                          |
| -------------------- | -------------------------------------------------------------------- | ---------------------------------------------------- |
| **Passenger**        | End user who books rides via the Flutter app                         | Phone + 4-digit OTP → JWT                            |
| **Driver**           | Registered driver who accepts and completes trips via the driver app | Phone + 4-digit OTP → JWT (account created by admin) |
| **Admin / Operator** | Internal staff managing the platform via a back-office panel         | Separate credentials (email + password or SSO)       |
| **System**           | Automated background jobs (scheduler, event processor)               | Internal service-to-service tokens                   |

---

## 4. Backend Services

### 4.1 Auth Service

**Responsibility:** Everything related to identity verification and session management for both passengers and drivers.

#### OTP Component

The OTP component handles the phone-based login flow. When a user submits their phone number, the service validates the format (E.164 international), enforces rate limits (max 3 OTP sends per phone per 60 minutes; max 20 OTP sends per IP per minute), generates a 4-digit code, stores it in the cache with a 5-minute TTL, and sends it via SMS.

The cache key is a random `session_token` (UUID) issued back to the client — not the phone number directly. This means each OTP send creates a fresh session, and old sessions cannot be reused.

When the user submits their code, the service retrieves the session from cache, increments the attempt counter (max 5 attempts before lockout), compares the code, marks the session as consumed on success, and proceeds to token issuance. A consumed session cannot be used again even if the code was correct.

First-time registration is seamless: if the phone number has never been seen before, a user record is created automatically at OTP verification time. No separate registration step exists.

#### Token Component

On successful OTP verification, the service issues two tokens:

- **Access token**: RS256-signed JWT with a 15-minute TTL. Contains the user's UUID, role, and a token version integer.
- **Refresh token**: An opaque random string with a 30-day TTL, stored hashed in the `refresh_tokens` table.

On refresh, the stored refresh token is validated and then replaced with a newly rotated one. On logout, the refresh token record is deleted.

#### Token Version Invalidation

Each user record carries an integer `token_version` column (default 0). The JWT access token includes this value as a claim. Every authenticated endpoint checks that the JWT's `token_version` matches the database value. To invalidate all active sessions for a user — for example after an account compromise — an admin increments `token_version` by 1. All existing JWTs become invalid immediately on the next request.

#### FCM Token Management

When a passenger or driver logs in or the app starts, the client sends its current Firebase FCM device token. The server stores the single most recent FCM token per user, replacing the old one. One user = one active FCM token at any time.

---

### 4.2 Trip Service

**Responsibility:** The complete lifecycle of a trip from quote request through completion.

#### Trip Status Machine

A trip progresses through a well-defined set of statuses. All status transitions are driven by the backend — either by driver actions relayed through the driver app, or by system events.

```
[SCHEDULED] ─────────────────────────────────────► scheduled trips only
      │  (matching begins 30 min before scheduled_at)
      │
[PENDING_DRIVER] ◄─────────────────────────────────────────────────
      │                                                             │
      │  (driver accepts)                            (driver cancels → re-match)
      ▼                                                             │
[DRIVER_ASSIGNED] ────────────────────────────────────────────────►┘
      │
      │  (driver departs toward pickup)
      ▼
[DRIVER_EN_ROUTE_TO_PICKUP]
      │
      │  (driver arrives at pickup)
      ▼
[DRIVER_ARRIVED]
      │
      │  (driver starts trip — passenger boarded)
      ▼
[TRIP_IN_PROGRESS]
      │
      │  (multi-stop: driver arrives at stop N)
      ├──► [AT_STOP_N] ──► [BETWEEN_STOPS] ──► (repeat per stop)
      │
      │  (driver arrives at final destination)
      ▼
[ARRIVED_AT_DESTINATION]
      │
      │  (payment processed, trip finalized)
      ▼
[COMPLETED]  ◄── terminal

Cancellation terminals (reachable from any non-completed state):
  [CANCELLED_BY_PASSENGER]
  [CANCELLED_BY_DRIVER]      → triggers re-matching
  [CANCELLED_BY_SYSTEM]      → no drivers found after timeout
  [CANCELLED_AFTER_START]    → trip force-stopped after beginning
  [PASSENGER_NO_SHOW]        → driver marked passenger absent
```

#### Server-Side Validation Rules

All of the following rules are enforced exclusively on the backend. The client's own validation is for UX only — it is never authoritative.

1. All coordinates must fall within the maximum radius of the system center (defined in `app_config`).
2. Origin-to-destination straight-line distance must be at least 500 meters.
3. Maximum number of intermediate stops is the value of `app_config.max_stops` (admin-configurable, default 5).
4. No two consecutive stops may be within 200 meters of each other (prevents phantom zero-length segments).
5. For scheduled trips, `scheduled_at` must be at least 30 minutes in the future and at most 7 days ahead.
6. For the same passenger, no two trips with overlapping estimated time windows may coexist (conflict window: `[scheduled_at, scheduled_at + estimated_duration + 30 min buffer]`).
7. The `vehicle_type_id` must exist in the `vehicle_types` table and be active.
8. The `payment_method_id` must exist in `passenger_payment_methods` and belong to the requesting passenger.
9. The `quote_id` must exist, not be expired, and not already be consumed by a previous booking.
10. The `vehicle_type_id` in the booking must match the one used when the quote was generated.
11. The refined pickup coordinates must be within 300 meters of the origin coordinates.
12. If a promo code is submitted, it must be active, not expired, not exhausted, and not already used by this passenger.

---

### 4.3 Pricing Service

**Responsibility:** All fare calculation and quote issuance. No other service computes prices.

#### Fare Formula

Given a route with total road-network distance D (kilometers) and estimated driving duration T (minutes):

```
distance_component = D × vehicle_type.rate_per_km
duration_component = T × vehicle_type.rate_per_min
raw_fare           = distance_component + duration_component
final_fare         = MAX(raw_fare, vehicle_type.minimum_fare)

If a promo code is applied:
  discount   = final_fare × (promo_code.discount_percent / 100)
  final_fare = final_fare − discount
```

Distance and duration come from the routing engine (Google Directions API or equivalent), called server-side. The client never computes the route for pricing purposes.

#### Vehicle Type Rates

All rates are stored in the `vehicle_types` table and are editable by an admin without a code deploy.

| Vehicle Type    | Identifier   | Passengers | Rate per km | Rate per min |
| --------------- | ------------ | ---------- | ----------- | ------------ |
| Standard Car    | `standard`   | 4          | €2.80       | €0.20        |
| XL Van / Bus    | `xl`         | 8          | €3.20       | €0.25        |
| Wheelchair Taxi | `wheelchair` | special    | €3.50       | €0.25        |

Minimum fare per type is set by the admin in the database.

#### Quote System

When a passenger requests prices for a route, the Pricing Service computes the fare for all active vehicle types at once and issues a single `quote_id`. The quote is valid for 5 minutes.

When the passenger proceeds to book, the Trip Service validates that the `quote_id` is still valid and has not been consumed. If the quote has expired, the client must request a new one. Once a booking succeeds, the quote is marked as used and cannot be reused.

This design prevents passengers from booking at outdated prices if admin has changed the rates in between, and ensures the price shown to the passenger is the price that will be charged.

#### Route Calculation (Server-Side Only)

The Pricing Service calls the mapping API to obtain the full route data: road-network distance, estimated driving duration, the encoded polyline, and a per-segment breakdown. This data is stored in the `trip_routes` table alongside the trip record.

The Google Maps API key lives exclusively on the server. The client never calls Google APIs directly — all geocoding, reverse geocoding, nearby place search, and route requests are proxied through backend endpoints.

#### Multi-Currency

Each system has a globally configured `currency_code` in `app_config`. All fare amounts are computed and stored in this currency. Both the quote response and the trip record include the `currency_code` field so the client can display the correct symbol.

---

### 4.4 Driver Service

**Responsibility:** Driver state management, location tracking, and trip-to-driver matching.

#### Driver States

```
OFFLINE ──► AVAILABLE ──► ON_TRIP ──► AVAILABLE (after trip completes)
    ▲             │
    └─────────────┘  (driver goes offline)
```

The `on_trip` state is set automatically by the system when a driver accepts a trip. Drivers can only self-transition between `offline` and `available`.

#### Location Management

The driver app sends location updates to the server every 10 seconds via an HTTP PATCH endpoint while the driver is active. The system does NOT use WebSockets for driver-to-server updates to maintain a lean infrastructure.

The server stores the driver's current coordinates and timestamp in the `drivers` table. Whenever a driver's location updates and they are on an active trip, the server forwards the new position to the passenger's WebSocket channel so the passenger sees the driver moving on the map in real time.

If no location update is received for 60 seconds while a driver is `ON_TRIP`, the system generates an internal alert.

#### Trip Assignment

When a new trip needs a driver, the Driver Service is invoked with the trip's origin and required vehicle type. It queries all available drivers with the matching vehicle type within the maximum system radius, applies the matching algorithm (TBD), and sends a push notification to the selected driver with the trip request details.

The driver has a configurable acceptance window (default 60 seconds, stored in `app_config`) to accept or decline. Decline and timeout behavior is TBD, but the data model supports re-offering to other drivers.

For scheduled trips, matching begins 30 minutes before `scheduled_at`.

---

## 5. Data Model — ERD Source

This section defines every table, every column, its type, constraints, and relationships. This is the authoritative source for building the ERD.

### Entity Relationship Overview

```mermaid
users ──────────────────────────────┐
  │                                 │
  ├── refresh_tokens                │
  ├── otp_sessions                  │
  ├── saved_locations               │
  ├── passenger_payment_methods     │
  │     └── payments                │
  │           └── trips ────────────┤
  │                 ├── trip_stops  │
  │                 ├── trip_routes │
  │                 ├── pricing_quotes
  │                 └── promo_code_redemptions
  │                           └── promo_codes
  └── drivers (via user_id)

vehicle_types ──► drivers
              ──► trips
              ──► pricing_quotes
              ──► promo_codes

app_config (global settings)
audit_logs
notifications
```

---

### 5.1 `users`

Stores all human accounts: passengers and admins. Drivers also have a `users` record (linked via `drivers.user_id`).

| Column               | Type         | Constraints                            | Notes                          |
| -------------------- | ------------ | -------------------------------------- | ------------------------------ |
| `id`                 | UUID         | PRIMARY KEY, DEFAULT gen_random_uuid() |                                |
| `phone`              | VARCHAR(20)  | UNIQUE, NOT NULL                       | E.164 format e.g. +31612345678 |
| `email`              | VARCHAR(255) | UNIQUE, NULLABLE                       | Optional                       |
| `name`               | JSONB        | NOT NULL                               | Trilingual LocalizedText (En, Ar, Nl) |
| `profile_photo_url`  | TEXT         | NULLABLE                               | URL to stored image            |
| `role`               | VARCHAR(20)  | NOT NULL                               | 'passenger', 'driver', 'admin' |
| `fcm_token`          | TEXT         | NULLABLE                               | Single active FCM device token |
| `is_active`          | BOOLEAN      | NOT NULL, DEFAULT TRUE                 |                                |
| `deleted_at`         | TIMESTAMPTZ  | NULLABLE                               | Soft delete                    |
| `created_at`         | TIMESTAMPTZ  | NOT NULL, DEFAULT NOW()                |                                |
| `updated_at`         | TIMESTAMPTZ  | NOT NULL, DEFAULT NOW()                |                                |

**Indexes:** `phone`, `email`, `role`

**Relationships:**

- One `users` record → zero or one `drivers` record
- One `users` record → many `refresh_tokens`
- One `users` record → many `saved_locations`
- One `users` record → many `passenger_payment_methods`
- One `users` record (passenger) → many `trips` (as `passenger_id`)

---

### 5.2 `refresh_tokens`

Stores active refresh tokens. When a token is rotated, the old row is deleted and a new one is inserted.

| Column       | Type        | Constraints             | Notes                    |
| ------------ | ----------- | ----------------------- | ------------------------ |
| `id`         | UUID        | PRIMARY KEY             |                          |
| `user_id`    | UUID        | FK → users.id, NOT NULL |                          |
| `token_hash` | VARCHAR(64) | UNIQUE, NOT NULL        | SHA-256 of the raw token |
| `expires_at` | TIMESTAMPTZ | NOT NULL                | NOW() + 30 days          |
| `revoked_at` | TIMESTAMPTZ | NULLABLE                | NULL means still active  |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() |                          |

**Indexes:** `user_id`, `token_hash`

---

### 5.3 `otp_sessions`

Short-lived records mirroring the cache for auditability. The cache is the authoritative source for OTP verification; this table is for logging only.

| Column       | Type        | Constraints             | Notes                               |
| ------------ | ----------- | ----------------------- | ----------------------------------- |
| `id`         | UUID        | PRIMARY KEY             | = the session_token given to client |
| `phone`      | VARCHAR(20) | NOT NULL                |                                     |
| `attempts`   | SMALLINT    | NOT NULL, DEFAULT 0     |                                     |
| `consumed`   | BOOLEAN     | NOT NULL, DEFAULT FALSE |                                     |
| `expires_at` | TIMESTAMPTZ | NOT NULL                | NOW() + 5 min                       |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() |                                     |

---

### 5.4 `drivers`

Driver-specific profile data. Each driver has a linked `users` record for auth purposes.

| Column                  | Type          | Constraints                     | Notes                             |
| ----------------------- | ------------- | ------------------------------- | --------------------------------- |
| `id`                  | UUID          | PRIMARY KEY                     |                                   |
| `user_id`               | UUID          | FK → users.id, UNIQUE, NOT NULL | One-to-one with users             |
| `active_vehicle_id`     | UUID          | FK → vehicles.id, NULLABLE      | The vehicle currently in use      |
| `status`                | VARCHAR(20)   | NOT NULL, DEFAULT 'offline'     | 'offline', 'available', 'on_trip' |
| `current_lat`           | DECIMAL(10,7) | NULLABLE                        | Last known latitude               |
| `current_lng`           | DECIMAL(10,7) | NULLABLE                        | Last known longitude              |
| `location_updated_at`   | TIMESTAMPTZ   | NULLABLE                        |                                   |
| `acceptance_rate`       | DECIMAL(5,4)  | NOT NULL, DEFAULT 1.0000        | Rolling 30-day metric             |
| `completion_rate`       | DECIMAL(5,4)  | NOT NULL, DEFAULT 1.0000        | Rolling 30-day metric             |
| `total_trips_completed` | INTEGER       | NOT NULL, DEFAULT 0             |                                   |
| `deleted_at`            | TIMESTAMPTZ   | NULLABLE                        | Soft delete                       |
| `created_at`            | TIMESTAMPTZ   | NOT NULL                        |                                   |
| `updated_at`            | TIMESTAMPTZ   | NOT NULL                        |                                   |

**Indexes:** `user_id`, `vehicle_type_id`, `status`, `(current_lat, current_lng)`

**Relationships:**

- One `drivers` record → one `users` record
- One `drivers` record → one `vehicle_types` record
- One `drivers` record → many `trips` (as `driver_id`)

---

### 5.5 `vehicles`

Stores physical car details. Vehicles are assigned to a driver but exist as independent entities.

| Column            | Type         | Constraints                     | Notes                            |
| ----------------- | ------------ | ------------------------------- | -------------------------------- |
| `id`              | UUID         | PRIMARY KEY                     |                                  |
| `driver_id`       | UUID         | FK → drivers.id, NOT NULL       | The owner/primary driver         |
| `vehicle_type_id` | VARCHAR(50)  | FK → vehicle_types.id, NOT NULL | e.g. 'standard'                  |
| `make`            | VARCHAR(100) | NOT NULL                        | e.g. "Toyota"                    |
| `model`           | VARCHAR(100) | NOT NULL                        | e.g. "Camry"                     |
| `year`            | SMALLINT     | NOT NULL                        |                                  |
| `color`           | VARCHAR(50)  | NOT NULL                        |                                  |
| `license_plate`   | VARCHAR(20)  | UNIQUE, NOT NULL                |                                  |
| `is_verified`     | BOOLEAN      | NOT NULL, DEFAULT FALSE         | Admin manual check               |
| `deleted_at`      | TIMESTAMPTZ  | NULLABLE                        | Soft delete                      |
| `created_at`      | TIMESTAMPTZ  | NOT NULL                        |                                  |
| `updated_at`      | TIMESTAMPTZ  | NOT NULL                        |                                  |

**Indexes:** `driver_id`, `vehicle_type_id`, `license_plate`

---

### 5.6 `vehicle_types`

Admin-managed catalog of vehicle types with per-type pricing rates. The client fetches this table at startup and never hardcodes vehicle type information.

| Column               | Type          | Constraints             | Notes                                |
| -------------------- | ------------- | ----------------------- | ------------------------------------ |
| `id`                 | VARCHAR(50)   | PRIMARY KEY             | Slug: 'standard', 'xl', 'wheelchair' |
| `name`               | JSONB         | NOT NULL                | Trilingual LocalizedText (En, Ar, Nl) |
| `passenger_capacity` | SMALLINT      | NOT NULL                | 4, 8, etc.                           |
| `rate_per_km`        | DECIMAL(10,4) | NOT NULL                | e.g. 2.80                            |
| `rate_per_min`       | DECIMAL(10,4) | NOT NULL                | e.g. 0.20                            |
| `minimum_fare`       | DECIMAL(10,2) | NOT NULL                | Floor price per trip                 |
| `currency_code`      | VARCHAR(3)    | NOT NULL, DEFAULT 'EUR' | Pricing currency                     |
| `is_active`          | BOOLEAN       | NOT NULL, DEFAULT TRUE  | Admin can deactivate                 |
| `sort_order`         | SMALLINT      | NOT NULL, DEFAULT 0     | Display order in app                 |
| `created_at`         | TIMESTAMPTZ   | NOT NULL                |                                      |
| `updated_at`         | TIMESTAMPTZ   | NOT NULL                |                                      |

**Seed data:**

| id         | display_name_en | capacity | rate_per_km | rate_per_min |
| ---------- | --------------- | -------- | ----------- | ------------ |
| standard   | Standard Car    | 4        | 2.80        | 0.20         |
| xl         | XL Van / Bus    | 8        | 3.20        | 0.25         |
| wheelchair | Wheelchair Taxi | special  | 3.50        | 0.25         |

**Relationships:**

- One `vehicle_types` record → many `drivers`
- One `vehicle_types` record → many `trips`
- One `vehicle_types` record → many `pricing_quotes`

---

### 5.7 `trips`

The central table. One record per trip booking. This is the hub of the ERD — most other tables reference or are referenced by trips.

| Column                       | Type          | Constraints                                 | Notes                                        |
| ---------------------------- | ------------- | ------------------------------------------- | -------------------------------------------- |
| `id`                         | UUID          | PRIMARY KEY                                 |                                              |
| `reference_code`             | VARCHAR(12)   | UNIQUE, NOT NULL                            | Short code e.g. "TRP-4821"                   |
| `passenger_id`               | UUID          | FK → users.id, NOT NULL                     |                                              |
| `driver_id`                  | UUID          | FK → drivers.id, NULLABLE                   | Null until driver assigned                   |
| `vehicle_type_id`            | VARCHAR(50)   | FK → vehicle_types.id, NOT NULL             |                                              |
| `quote_id`                   | UUID          | FK → pricing_quotes.id, NOT NULL            |                                              |
| `trip_type`                  | VARCHAR(20)   | NOT NULL                                    | 'immediate', 'scheduled'                     |
| `status`                     | VARCHAR(40)   | NOT NULL                                    | See status machine in section 4.2            |
| `origin_lat`                 | DECIMAL(10,7) | NOT NULL                                    |                                              |
| `origin_lng`                 | DECIMAL(10,7) | NOT NULL                                    |                                              |
| `origin_label`               | TEXT          | NOT NULL                                    | Human-readable address                       |
| `pickup_lat`                 | DECIMAL(10,7) | NOT NULL                                    | Refined pickup point (within 300m of origin) |
| `pickup_lng`                 | DECIMAL(10,7) | NOT NULL                                    |                                              |
| `pickup_street_name`         | VARCHAR(255)  | NULLABLE                                    | Optional street detail                       |
| `pickup_house_number`        | VARCHAR(20)   | NULLABLE                                    | Optional house number                        |
| `destination_lat`            | DECIMAL(10,7) | NOT NULL                                    |                                              |
| `destination_lng`            | DECIMAL(10,7) | NOT NULL                                    |                                              |
| `destination_label`          | TEXT          | NOT NULL                                    |                                              |
| `has_stops`                  | BOOLEAN       | NOT NULL, DEFAULT FALSE                     | True if any intermediate stops exist         |
| `scheduled_at`               | TIMESTAMPTZ   | NULLABLE                                    | Null for immediate trips                     |
| `scheduled_reminder_sent_at` | TIMESTAMPTZ   | NULLABLE                                    | When 30-min reminder push was sent           |
| `driver_assigned_at`         | TIMESTAMPTZ   | NULLABLE                                    |                                              |
| `driver_arrived_at`          | TIMESTAMPTZ   | NULLABLE                                    |                                              |
| `trip_started_at`            | TIMESTAMPTZ   | NULLABLE                                    |                                              |
| `trip_completed_at`          | TIMESTAMPTZ   | NULLABLE                                    |                                              |
| `cancelled_at`               | TIMESTAMPTZ   | NULLABLE                                    |                                              |
| `cancellation_reason`        | TEXT          | NULLABLE                                    |                                              |
| `quoted_fare`                | DECIMAL(10,2) | NOT NULL                                    | Fare at quote time                           |
| `final_fare`                 | DECIMAL(10,2) | NULLABLE                                    | Actual fare at completion                    |
| `currency_code`              | VARCHAR(3)    | NOT NULL                                    |                                              |
| `payment_method_id`          | UUID          | FK → passenger_payment_methods.id, NOT NULL |                                              |
| `payment_status`             | VARCHAR(20)   | NOT NULL, DEFAULT 'pending'                 | 'pending', 'charged', 'refunded', 'failed'   |
| `payment_intent_id`          | TEXT          | NULLABLE                                    | Payment gateway reference                    |
| `promo_code_id`              | UUID          | FK → promo_codes.id, NULLABLE               |                                              |
| `discount_amount`            | DECIMAL(10,2) | NOT NULL, DEFAULT 0.00                      |                                              |
| `actual_distance_km`         | DECIMAL(10,3) | NULLABLE                                    | Measured at completion                       |
| `actual_duration_min`        | DECIMAL(10,2) | NULLABLE                                    | Measured at completion                       |
| `deleted_at`                 | TIMESTAMPTZ   | NULLABLE                                    | Soft delete                                  |
| `created_at`                 | TIMESTAMPTZ   | NOT NULL                                    |                                              |
| `updated_at`                 | TIMESTAMPTZ   | NOT NULL                                    |                                              |

**Indexes:** `passenger_id`, `driver_id`, `status`, `trip_type`, `scheduled_at`, `reference_code`, `created_at DESC`

**Relationships:**

- Many `trips` → one `users` (passenger_id)
- Many `trips` → one `drivers` (driver_id, nullable)
- Many `trips` → one `vehicle_types`
- One `trips` → one `pricing_quotes` (quote_id)
- One `trips` → one `trip_routes`
- One `trips` → many `trip_stops`
- One `trips` → many `payments`
- One `trips` → zero or one `promo_code_redemptions`

---

### 5.8 `trip_stops`

Intermediate stops for multi-stop trips. Ordered by `sequence_number`. The driver app marks each stop as arrived and then departed during the trip.

| Column            | Type          | Constraints                 | Notes                            |
| ----------------- | ------------- | --------------------------- | -------------------------------- |
| `id`              | UUID          | PRIMARY KEY                 |                                  |
| `trip_id`         | UUID          | FK → trips.id, NOT NULL     |                                  |
| `sequence_number` | SMALLINT      | NOT NULL                    | 1-indexed order of stops         |
| `latitude`        | DECIMAL(10,7) | NOT NULL                    |                                  |
| `longitude`       | DECIMAL(10,7) | NOT NULL                    |                                  |
| `label`           | TEXT          | NOT NULL                    | Human-readable address           |
| `status`          | VARCHAR(20)   | NOT NULL, DEFAULT 'pending' | 'pending', 'arrived', 'departed' |
| `arrived_at`      | TIMESTAMPTZ   | NULLABLE                    |                                  |
| `departed_at`     | TIMESTAMPTZ   | NULLABLE                    |                                  |

**Composite unique index:** `(trip_id, sequence_number)`

---

### 5.9 `trip_routes`

Computed polyline and segment data per trip. Stored separately from `trips` because polyline data can be large. One record per trip.

| Column                   | Type        | Constraints                     | Notes                                             |
| ------------------------ | ----------- | ------------------------------- | ------------------------------------------------- |
| `id`                     | UUID        | PRIMARY KEY                     |                                                   |
| `trip_id`                | UUID        | FK → trips.id, UNIQUE, NOT NULL | One route per trip                                |
| `encoded_polyline`       | TEXT        | NOT NULL                        | Full Google-encoded polyline for the entire route |
| `total_distance_meters`  | INTEGER     | NOT NULL                        |                                                   |
| `total_duration_seconds` | INTEGER     | NOT NULL                        | Estimated at quote time                           |
| `segments`               | JSONB       | NOT NULL                        | Array of per-segment route objects                |
| `computed_at`            | TIMESTAMPTZ | NOT NULL                        |                                                   |

The `segments` JSONB array stores one object per route leg (origin→stop1, stop1→stop2, etc.), each containing the from/to coordinates and labels, the distance and duration for that leg, and the leg's encoded polyline. This allows the client to render the route leg-by-leg and show per-segment travel estimates.

---

### 5.10 `pricing_quotes`

A locked price quote issued before a booking is confirmed. Valid for 5 minutes. Contains the full fare breakdown for one vehicle type and one specific route.

| Column                 | Type          | Constraints                     | Notes                                      |
| ---------------------- | ------------- | ------------------------------- | ------------------------------------------ |
| `id`                   | UUID          | PRIMARY KEY                     | The quote_id returned to the client        |
| `passenger_id`         | UUID          | FK → users.id, NOT NULL         |                                            |
| `vehicle_type_id`      | VARCHAR(50)   | FK → vehicle_types.id, NOT NULL |                                            |
| `origin_lat`           | DECIMAL(10,7) | NOT NULL                        | Route coordinates at quote time            |
| `origin_lng`           | DECIMAL(10,7) | NOT NULL                        |                                            |
| `destination_lat`      | DECIMAL(10,7) | NOT NULL                        |                                            |
| `destination_lng`      | DECIMAL(10,7) | NOT NULL                        |                                            |
| `stops_hash`           | VARCHAR(64)   | NULLABLE                        | SHA-256 of serialized stops array          |
| `total_distance_km`    | DECIMAL(10,3) | NOT NULL                        |                                            |
| `total_duration_min`   | DECIMAL(10,2) | NOT NULL                        |                                            |
| `distance_component`   | DECIMAL(10,2) | NOT NULL                        | D × rate_per_km                            |
| `duration_component`   | DECIMAL(10,2) | NOT NULL                        | T × rate_per_min                           |
| `raw_fare`             | DECIMAL(10,2) | NOT NULL                        | Before minimum fare applied                |
| `final_fare`           | DECIMAL(10,2) | NOT NULL                        | After minimum fare, before discount        |
| `minimum_fare_applied` | BOOLEAN       | NOT NULL, DEFAULT FALSE         |                                            |
| `currency_code`        | VARCHAR(3)    | NOT NULL                        |                                            |
| `valid_until`          | TIMESTAMPTZ   | NOT NULL                        | created_at + 5 minutes                     |
| `used`                 | BOOLEAN       | NOT NULL, DEFAULT FALSE         | True once a trip is booked with this quote |
| `created_at`           | TIMESTAMPTZ   | NOT NULL                        |                                            |

**Indexes:** `passenger_id`, `valid_until`, `used`

---

### 5.11 `passenger_payment_methods`

Saved card-on-file records per passenger. Raw card numbers are never stored — only the gateway-issued token and display metadata.

| Column                      | Type         | Constraints             | Notes                              |
| --------------------------- | ------------ | ----------------------- | ---------------------------------- |
| `id`                        | UUID         | PRIMARY KEY             |                                    |
| `passenger_id`              | UUID         | FK → users.id, NOT NULL |                                    |
| `gateway_payment_method_id` | TEXT         | NOT NULL                | e.g. Stripe `pm_xxxxxxxx`          |
| `card_brand`                | VARCHAR(20)  | NOT NULL                | 'visa', 'mastercard', 'amex', etc. |
| `last_four`                 | VARCHAR(4)   | NOT NULL                | Last 4 digits for display only     |
| `expiry_month`              | SMALLINT     | NOT NULL                |                                    |
| `expiry_year`               | SMALLINT     | NOT NULL                |                                    |
| `cardholder_name`           | VARCHAR(255) | NULLABLE                |                                    |
| `is_default`                | BOOLEAN      | NOT NULL, DEFAULT FALSE | Passenger's chosen default card    |
| `deleted_at`                | TIMESTAMPTZ  | NULLABLE                | Soft delete                        |
| `created_at`                | TIMESTAMPTZ  | NOT NULL                |                                    |

**Indexes:** `passenger_id`

**Rule:** Only one record per `passenger_id` may have `is_default = TRUE`. Enforced via a partial unique index or application logic.

---

### 5.12 `payments`

One record per payment event (charge or refund). A trip that is charged and then refunded has two rows in this table.

| Column                      | Type          | Constraints                                 | Notes                                 |
| --------------------------- | ------------- | ------------------------------------------- | ------------------------------------- |
| `id`                        | UUID          | PRIMARY KEY                                 |                                       |
| `trip_id`                   | UUID          | FK → trips.id, NOT NULL                     |                                       |
| `passenger_id`              | UUID          | FK → users.id, NOT NULL                     |                                       |
| `payment_method_id`         | UUID          | FK → passenger_payment_methods.id, NOT NULL |                                       |
| `type`                      | VARCHAR(20)   | NOT NULL                                    | 'charge', 'refund'                    |
| `amount`                    | DECIMAL(10,2) | NOT NULL                                    | Positive for both charges and refunds |
| `currency_code`             | VARCHAR(3)    | NOT NULL                                    |                                       |
| `status`                    | VARCHAR(20)   | NOT NULL                                    | 'pending', 'succeeded', 'failed'      |
| `gateway_payment_intent_id` | TEXT          | NULLABLE                                    | Payment gateway transaction reference |
| `gateway_charge_id`         | TEXT          | NULLABLE                                    |                                       |
| `gateway_refund_id`         | TEXT          | NULLABLE                                    | For refund type                       |
| `failure_reason`            | TEXT          | NULLABLE                                    | Gateway error message                 |
| `processed_at`              | TIMESTAMPTZ   | NULLABLE                                    | When gateway confirmed                |
| `created_at`                | TIMESTAMPTZ   | NOT NULL                                    |                                       |

**Indexes:** `trip_id`, `passenger_id`, `status`

---

### 5.13 `saved_locations`

Cross-device saved locations per passenger. The server is the source of truth; ObjectBox on the device is a local cache. The `identity_key` is a coordinate string computed identically on both client and server, enabling deterministic upsert without relying on server-generated IDs for sync.

| Column              | Type          | Constraints             | Notes                                         |
| ------------------- | ------------- | ----------------------- | --------------------------------------------- |
| `id`                | UUID          | PRIMARY KEY             |                                               |
| `user_id`           | UUID          | FK → users.id, NOT NULL |                                               |
| `identity_key`      | VARCHAR(50)   | NOT NULL                | `{lat_6dp},{lng_6dp}` — same format as client |
| `latitude`          | DECIMAL(10,7) | NOT NULL                |                                               |
| `longitude`         | DECIMAL(10,7) | NOT NULL                |                                               |
| `label`             | TEXT          | NOT NULL                | Full display label                            |
| `primary_name`      | VARCHAR(255)  | NULLABLE                | POI or street name                            |
| `secondary_address` | VARCHAR(255)  | NULLABLE                | Area / city portion                           |
| `is_pinned`         | BOOLEAN       | NOT NULL, DEFAULT FALSE |                                               |
| `touched_at`        | TIMESTAMPTZ   | NOT NULL                | Last selected/used time                       |
| `deleted_at`        | TIMESTAMPTZ   | NULLABLE                | Soft delete (used as sync tombstone)          |
| `created_at`        | TIMESTAMPTZ   | NOT NULL                |                                               |
| `updated_at`        | TIMESTAMPTZ   | NOT NULL                |                                               |

**Composite unique index:** `(user_id, identity_key)` where `deleted_at IS NULL`

---

### 5.14 `promo_codes`

Discount codes created by admins and redeemable at booking time.

| Column                | Type          | Constraints                     | Notes                                |
| --------------------- | ------------- | ------------------------------- | ------------------------------------ |
| `id`                  | UUID          | PRIMARY KEY                     |                                      |
| `code`                | VARCHAR(30)   | UNIQUE, NOT NULL                | The string passengers type in        |
| `description`         | TEXT          | NULLABLE                        | Admin-facing note                    |
| `discount_type`       | VARCHAR(20)   | NOT NULL                        | 'percentage' only in v1              |
| `discount_percent`    | DECIMAL(5,2)  | NULLABLE                        | e.g. 20.00 for 20% off               |
| `max_uses`            | INTEGER       | NULLABLE                        | Global cap — NULL = unlimited        |
| `times_used`          | INTEGER       | NOT NULL, DEFAULT 0             | Atomically incremented on redemption |
| `minimum_fare`        | DECIMAL(10,2) | NULLABLE                        | Code only valid if fare ≥ this       |
| `vehicle_type_id`     | VARCHAR(50)   | FK → vehicle_types.id, NULLABLE | NULL = applies to all types          |
| `is_active`           | BOOLEAN       | NOT NULL, DEFAULT TRUE          | Admin toggle                         |
| `created_by_admin_id` | UUID          | FK → users.id, NOT NULL         |                                      |
| `expires_at`          | TIMESTAMPTZ   | NULLABLE                        | NULL = never expires                 |
| `created_at`          | TIMESTAMPTZ   | NOT NULL                        |                                      |
| `updated_at`          | TIMESTAMPTZ   | NOT NULL                        |                                      |

**Indexes:** `code`, `is_active`, `expires_at`

---

### 5.15 `promo_code_redemptions`

Records which passenger used which promo code on which trip. The unique constraint on `(promo_code_id, passenger_id)` enforces one-use-per-passenger-per-code at the database level.

| Column            | Type          | Constraints                   | Notes                    |
| ----------------- | ------------- | ----------------------------- | ------------------------ |
| `id`              | UUID          | PRIMARY KEY                   |                          |
| `promo_code_id`   | UUID          | FK → promo_codes.id, NOT NULL |                          |
| `passenger_id`    | UUID          | FK → users.id, NOT NULL       |                          |
| `trip_id`         | UUID          | FK → trips.id, NOT NULL       |                          |
| `discount_amount` | DECIMAL(10,2) | NOT NULL                      | Actual amount discounted |
| `created_at`      | TIMESTAMPTZ   | NOT NULL                      |                          |

**Unique index:** `(promo_code_id, passenger_id)` — one use per passenger per code

---

---

### 5.17 `app_config`

Server-managed configuration that the client fetches at startup. Avoids hardcoding operational values in the app. When an admin changes a value here, all clients pick it up on next launch without an app update.

| Column        | Type         | Constraints | Notes                                 |
| ------------- | ------------ | ----------- | ------------------------------------- |
| `key`         | VARCHAR(100) | PRIMARY KEY | e.g. 'max_stops', 'quote_ttl_seconds' |
| `value`       | TEXT         | NOT NULL    | String representation of the value    |
| `description` | TEXT         | NULLABLE    | Admin-facing note                     |
| `updated_at`  | TIMESTAMPTZ  | NOT NULL    |                                       |

**Default entries:**

| Key                                 | Default Value | Meaning                                              |
| ----------------------------------- | ------------- | ---------------------------------------------------- |
| `max_stops`                         | 5             | Maximum intermediate stops per trip                  |
| `quote_ttl_seconds`                 | 300           | Quote validity window (5 min)                        |
| `pickup_max_distance_meters`        | 300           | Max distance from origin to refined pickup point     |
| `schedule_min_advance_minutes`      | 30            | Minimum advance booking window for scheduled trips   |
| `schedule_max_advance_days`         | 7             | Maximum days ahead a trip can be scheduled           |
| `driver_accept_window_seconds`      | 60            | Time driver has to accept a trip request             |
| `scheduled_matching_minutes_before` | 30            | How early driver matching starts for scheduled trips |
| `scheduled_reminder_minutes_before` | 30            | When to send the scheduled trip reminder push        |
| `otp_ttl_seconds`                   | 300           | OTP validity window                                  |
| `otp_max_attempts`                  | 5             | Max wrong OTP attempts before session is locked      |
| `otp_max_sends_per_hour`            | 3             | Max OTP sends per phone per 60-min window            |
| `system_center_lat`                 | 52.3676       | Latitude of the global service center (e.g. Amsterdam)|
| `system_center_lng`                 | 4.9041        | Longitude of the global service center               |
| `system_max_radius_km`              | 50.0          | Maximum allowed distance from center point           |
| `currency_code`                     | EUR           | Global currency code for the platform                |

---

### 5.18 `audit_logs`

Basic audit trail of sensitive admin actions. Records who did what to which record and when.

| Column        | Type         | Constraints             | Notes                                       |
| ------------- | ------------ | ----------------------- | ------------------------------------------- |
| `id`          | BIGSERIAL    | PRIMARY KEY             |                                             |
| `actor_id`    | UUID         | FK → users.id, NOT NULL | Who performed the action                    |
| `action`      | VARCHAR(100) | NOT NULL                | e.g. 'driver.vehicle_type_changed'          |
| `target_type` | VARCHAR(50)  | NOT NULL                | e.g. 'driver', 'vehicle_type', 'promo_code' |
| `target_id`   | TEXT         | NOT NULL                | UUID or key of the affected record          |
| `created_at`  | TIMESTAMPTZ  | NOT NULL, DEFAULT NOW() |                                             |

**Indexes:** `actor_id`, `(target_type, target_id)`, `created_at DESC`

---

---

### 5.20 `notifications`

Log of all push and SMS notifications sent by the system.

| Column           | Type        | Constraints             | Notes                                                                  |
| ---------------- | ----------- | ----------------------- | ---------------------------------------------------------------------- |
| `id`             | UUID        | PRIMARY KEY             |                                                                        |
| `user_id`        | UUID        | FK → users.id, NOT NULL | Recipient                                                              |
| `type`           | VARCHAR(50) | NOT NULL                | 'driver_assigned', 'driver_arrived', 'scheduled_reminder', 'otp', etc. |
| `channel`        | VARCHAR(10) | NOT NULL                | 'push', 'sms'                                                          |
| `trip_id`        | UUID        | FK → trips.id, NULLABLE | If the notification relates to a trip                                  |
| `title`          | TEXT        | NULLABLE                | Push notification title                                                |
| `body`           | TEXT        | NOT NULL                | Message body                                                           |
| `fcm_message_id` | TEXT        | NULLABLE                | FCM delivery reference                                                 |
| `sent_at`        | TIMESTAMPTZ | NOT NULL                |                                                                        |
| `delivered_at`   | TIMESTAMPTZ | NULLABLE                | If delivery receipt is available                                       |

---

## 6. Business Logic & Flows

### 6.1 Immediate Trip Booking Flow

```
1. Passenger opens the app
   → GPS resolves current position
   → Reverse geocode call to the backend returns a human-readable address for the "From" field

2. Passenger types a destination
   → Text search call to the backend returns location suggestions
   → Passenger selects a suggestion

3. Passenger optionally adds intermediate stops (multi-stop)
   → Each stop is also searched via the backend

4. Client requests a price quote from the backend:
   → Sends: origin coordinates, destination coordinates, stops array
   → Backend routes the request to the Pricing Service
   → Pricing Service calls the mapping API (server-side) to compute road distance + duration
   → Pricing Service calculates fares for all 3 vehicle types
   → Backend inserts a pricing_quotes record (valid 5 minutes) for each vehicle type
   → Returns: quote_id, route data (polyline, distance, duration), fare per vehicle type

5. Client shows the vehicle selection screen with real server-computed prices
   → The route polyline is rendered on the map (client-side rendering)

6. Passenger selects vehicle type

7. Passenger refines pickup point on the map (within 300m of origin)

8. Passenger optionally sets a scheduled time (30 min to 7 days ahead)

9. Passenger selects a saved payment card (or adds a new one)

10. Passenger optionally enters a promo code

11. Client submits the booking to the backend:
    → Sends: quote_id, vehicle_type_id, trip_type, scheduled_at (if applicable),
             origin, pickup_point, destination, stops, payment_method_id, promo_code (if any)

12. Backend validates all fields (see section 4.2 for full list of rules)

13. Backend charges the card via the payment gateway
    → On success: payment record inserted, trip created, card is charged
    → On failure: error returned, trip is NOT created

14. Backend inserts the trips record with:
    → status = PENDING_DRIVER (for immediate)
    → status = SCHEDULED (for future trips)

15. Backend inserts trip_stops records (if stops provided)
    Backend inserts trip_routes record with the route computed at quote time

16. For immediate trips: Driver Service begins matching immediately
    For scheduled trips: A background job will start matching 30 minutes before scheduled_at

17. Backend responds with the trip_id, reference_code, status, and fare summary

18. Client opens a WebSocket connection to receive real-time trip updates
```

### 6.2 Multi-Stop Logic

Stops are provided in the quote request as an ordered array. The route is computed as a single multi-waypoint path: origin → stop 1 → stop 2 → ... → stop N → destination. The fare covers the total route as one amount (not charged per segment).

At booking, each stop is stored in `trip_stops` with a `sequence_number` (1, 2, 3, ...) and an initial status of `pending`. During the trip, the driver app marks each stop as `arrived` and then `departed`. The passenger sees real-time status updates for each stop via the WebSocket connection.

The stop sequence is locked at booking time. Mid-trip stop changes are a future feature.

### 6.3 Scheduled Trip Logic

When `trip_type = 'scheduled'`, the trip is created with status `SCHEDULED`. No driver is assigned at booking time.

A background job runs continuously checking for scheduled trips where `scheduled_at − NOW() ≤ 30 minutes`. When this condition is met, the trip transitions to `PENDING_DRIVER` and driver matching begins (same algorithm as immediate trips). A push notification is sent to the passenger: "Your driver is being assigned."

A separate job sends a 30-minute reminder push notification to the passenger when the reminder has not yet been sent (`scheduled_reminder_sent_at IS NULL`) and the window is reached.

Before creating a new scheduled trip, the backend checks for time window conflicts with the passenger's other active trips. The conflict window is `[scheduled_at, scheduled_at + estimated_duration + 30 min buffer]`.

### 6.4 Promo Code Redemption Logic

When a passenger submits a promo code during booking, the backend checks:

1. The code exists and `is_active = true`
2. `expires_at IS NULL` OR `expires_at > NOW()`
3. `times_used < max_uses` OR `max_uses IS NULL`
4. The passenger has not previously used this code (checked via `promo_code_redemptions`)
5. The quoted fare meets the code's `minimum_fare` (if set)
6. The `vehicle_type_id` matches (if the code is vehicle-specific)

If all conditions pass, the discount is computed and applied atomically:

```sql
UPDATE promo_codes
SET times_used = times_used + 1
WHERE id = :id AND times_used < max_uses
RETURNING times_used;
```

If the row is not updated (0 rows affected), the code was just exhausted by a concurrent redemption. The passenger receives a `promo_code_exhausted` error.

### 6.5 Payment Charge Flow

The card is charged at trip completion, not at booking. When the driver marks arrival at the final destination:

1. The Trip Service notifies the Payment Service with the trip's final fare, currency, and payment method
2. The Payment Service retrieves the `gateway_payment_method_id` from `passenger_payment_methods`
3. It calls the payment gateway to charge the saved card
4. A `payments` record is inserted with `status = pending`
5. On gateway success: `payments.status = succeeded`, `trips.payment_status = charged`
6. On gateway failure: `payments.status = failed`, `trips.payment_status = failed`, push notification sent to passenger

### 6.6 Refund Flow

Refunds are triggered by trip cancellation after a charge has been made. The Payment Service:

1. Locates the original `charge` record in the `payments` table
2. Calls the payment gateway refund API with the `gateway_charge_id`
3. On success: inserts a new `payments` row with `type = refund`, updates `trips.payment_status = refunded`
4. On failure: inserts a failed refund record, flags for manual admin review

### 6.7 Reference Code Generation

Every new trip gets a short human-readable reference code used for support lookups.

Format: `TRP-` followed by 4 uppercase alphanumeric characters (excluding O, 0, I, 1 for visual clarity).
Example: `TRP-4X7K`

Generation: Random string with a uniqueness check against existing codes. Up to 5 retries before expanding to a 6-character suffix to handle unlikely but possible collision scenarios.

### 6.8 Saved Locations Sync

The server is the source of truth. The device's ObjectBox database is a local cache.

**On login:** The client fetches all saved locations from the server and merges them into ObjectBox. Server data wins on conflict (the record with the later `touched_at` timestamp takes precedence).

**On save or pin toggle:** The client writes to ObjectBox immediately (for fast UI response), then makes a background call to the server to sync the change. If the network call fails, the local change is persisted and the sync is retried on next app open.

**On delete:** The server sets `deleted_at` (soft delete / tombstone). On next sync, the client checks for tombstoned records and removes them from ObjectBox.

**Limit enforcement:** Maximum 10 saved locations per user, enforced on the server. When adding an 11th, the oldest unpinned location is removed first. If all are pinned, the add is rejected.

---

## 7. Real-Time Layer

### 7.1 Passenger WebSocket

After a trip is created, the client opens a persistent WebSocket connection authenticated with the JWT access token. The server streams events to the client until the trip reaches a terminal status, at which point the connection is closed gracefully.

**Event types the server sends to the passenger:**

| Event                 | When                                    | What it contains                                                  |
| --------------------- | --------------------------------------- | ----------------------------------------------------------------- |
| `driver_assigned`     | Driver accepts the trip                 | Driver name, vehicle details, current location, estimated arrival |
| `driver_location`     | Every ~5 seconds while driver is active | Latitude, longitude, bearing                                      |
| `trip_status_changed` | Every status transition                 | New status, translated status message in all 3 languages          |
| `stop_status_changed` | Driver arrives at or departs a stop     | Stop sequence number, new stop status                             |
| `trip_completed`      | Trip finalized                          | Final fare, actual distance/duration                              |
| `error`               | Connection or authorization error       | Error code and message                                            |

The client sends only periodic `ping` messages to keep the connection alive.

**Reconnection:** The client implements exponential backoff reconnection (1s, 2s, 4s, 8s cap). On reconnect, the client fetches the current trip state via REST before resubscribing to the WebSocket.

### 7.2 Driver Location Streaming

When the driver's location is updated, the server:

1. Updates `drivers.current_lat`, `drivers.current_lng`, `drivers.location_updated_at`
2. Identifies the active trip assigned to this driver
3. Forwards the location to the passenger's WebSocket channel as a `driver_location` event

The driver location update protocol (WebSocket vs HTTP PATCH) is TBD.

---

## 8. Notifications

### 8.1 Push Notifications (Firebase FCM)

All push notifications are sent via Firebase FCM. The server holds the FCM service account key. Each user has one active FCM token, replaced on each login.

All notification text (titles and bodies) is prepared in all 3 languages. The server selects the language based on `users.preferred_language`.

| Trigger                                 | Recipient | Title              | Body                                                 |
| --------------------------------------- | --------- | ------------------ | ---------------------------------------------------- |
| Driver assigned                         | Passenger | "Driver found!"    | "{driver_name} is on the way. ETA: {N} min."         |
| Driver arrived                          | Passenger | "Driver arrived!"  | "Your driver is waiting at the pickup point."        |
| Scheduled trip reminder (30 min before) | Passenger | "Ride reminder"    | "Your ride starts in 30 minutes. Reference: {code}"  |
| New trip request                        | Driver    | "New trip request" | "Pickup: {origin_label}. Accept within {N} seconds." |

### 8.2 SMS Notifications

| Trigger        | Recipient | Content                                                   |
| -------------- | --------- | --------------------------------------------------------- |
| OTP sent       | User      | "Your customertaxi code is: {code}. Valid for 5 minutes."   |
| Driver arrived | Passenger | "Your customertaxi driver has arrived at the pickup point." |

The SMS provider is plugged via a provider-agnostic interface. Provider is TBD.

---

## 9. Payment System

### 9.1 Card-on-File Architecture

Payment is handled through a card-on-file model using a payment gateway (e.g., Stripe). The server never receives or stores raw card numbers.

The flow for adding a card:

1. The passenger opens the "Add Card" screen in the app
2. The payment gateway's client-side SDK collects the card details and tokenizes them directly — the raw card number never leaves the device
3. The gateway SDK returns a `payment_method_id` token to the client
4. The client sends this token to the backend
5. The backend attaches the token to the passenger's gateway customer account and stores the display metadata (`card_brand`, `last_four`, `expiry_month/year`) in `passenger_payment_methods`

### 9.2 Charge Timing

The card is charged at trip completion, not at booking. This avoids holding pre-authorizations for the duration of the trip and simplifies the payment flow.

### 9.3 Refund Policy

Cancellations that occur after a charge has been made (in v1, cancellation is free so charges only occur at completion — refunds would apply if a trip is cancelled after starting) trigger an automatic refund to the original card. Refund timing is gateway-dependent (typically 5–10 business days).

### 9.4 PCI Compliance

Because the server never handles raw card numbers and only stores gateway tokens, the server is out of scope for PCI DSS Level 1 requirements. Card tokenization happens entirely within the payment gateway's SDK.

---

## 10. Promo & Discount System

### 10.1 Code Structure

In v1, promo codes are percentage-off discounts. Each code has:

- A **global usage cap** (`max_uses`). When `times_used >= max_uses`, the code is exhausted. This cap is enforced atomically to prevent overshooting in concurrent redemptions.
- A **per-passenger limit**: each passenger can use each code exactly once, enforced by the unique constraint on `promo_code_redemptions(promo_code_id, passenger_id)`.
- An optional **expiry date**.
- An optional **minimum fare** requirement (the code only applies if the trip fare reaches a threshold).
- An optional **vehicle type restriction** (the code only applies to a specific vehicle type).

### 10.2 Atomicity of Redemption

Incrementing `times_used` is done atomically with a conditional update that fails if the cap has already been reached. This prevents two passengers from simultaneously redeeming the last use of the same code.

---

## 11. Client vs. Server Responsibility

The existing Flutter app handles nearly everything on the client. The following table describes what must move to the server, why, and what correctly stays client-side.

### 11.1 Must Move to Server

| Concern                      | Current State                                                       | Reason to Move                                                                              |
| ---------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Pricing calculation          | Client-side Haversine formula in `order_remote_datasource.dart`     | Client can forge any price. Revenue integrity requires server control.                      |
| Route computation            | Client calls Google Directions API directly                         | Price derives from the route. If the route comes from the client, price can be manipulated. |
| OTP verification             | Hardcoded `otp == '0000'` check in `auth_bloc.dart`                 | Auth must not be bypassable by anyone who reads the source.                                 |
| Token issuance               | Mocked dummy token in `auth_remote_datasource.dart`                 | Fake tokens currently pass all auth guards.                                                 |
| Geocoding & Places search    | Client calls Google APIs with an embedded API key                   | Embedded keys can be extracted from the APK and abused for quota theft.                     |
| Service zone validation      | None                                                                | Client could submit coordinates outside the service area.                                   |
| Pickup distance check (300m) | Client-side check only in `order_bloc.dart`                         | Client can submit any coordinates regardless of the check.                                  |
| Vehicle type catalog         | Hardcoded strings `'standard'`, `'comfort'`, `'bus_8'` in constants | Adding or renaming vehicle types requires a code deploy if hardcoded.                       |
| Driver availability          | No driver system exists                                             | Client has no knowledge of drivers.                                                         |
| Price quote locking          | No quote system                                                     | Without locking, booking price can differ from shown price if rates change mid-flow.        |
| Saved locations              | Local ObjectBox only                                                | Cross-device sync and data portability require a server record.                             |
| Order confirmation           | Mock overlay emitted, no API call made                              | Trips are never actually created in the current code.                                       |
| Payment processing           | Payment method selected in state but discarded                      | No transactions exist currently.                                                            |

### 11.2 Stays Client-Side

| Concern                                 | Rationale                                                                                         |
| --------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Map rendering                           | Google Maps Flutter SDK is a client-side rendering library.                                       |
| GPS position reading                    | Device GPS is a client capability; the server has no access to it.                                |
| Polyline rendering on map               | Decoding and drawing the server-returned encoded polyline is a rendering operation.               |
| UI state machine (4-step booking flow)  | Pure presentation logic.                                                                          |
| Map camera animations                   | Fitting bounds, centering on driver — UI behavior only.                                           |
| Local ObjectBox cache                   | Used as a fast-access layer. Server is the source of truth; local is a cache.                     |
| Prefetch debouncing and race prevention | The token-based system preventing stale in-flight requests is purely a client networking concern. |

---

## 12. Security Design

### 12.1 JWT Structure

Access tokens use RS256 asymmetric signing. The private key is kept server-side. The public key is used by the API gateway to verify tokens on every request without contacting the Auth Service.

Token claims: user UUID (`sub`), role, token version, issued-at, expiry.

Refresh tokens are opaque random strings, stored hashed (SHA-256) in the `refresh_tokens` table. Raw tokens never touch the database.

### 12.2 Rate Limiting

Rate limits are enforced at the API gateway layer, per user ID and per IP:

| Endpoint                | Limit                                 |
| ----------------------- | ------------------------------------- |
| OTP send                | 3 per phone / 60 min; 20 per IP / min |
| OTP verify              | 5 per session token                   |
| Token refresh           | 30 per user / hour                    |
| Geo search              | 10 per user / 10 sec                  |
| Geo reverse             | 20 per user / min                     |
| Trip quote              | 20 per user / min                     |
| Trip create             | 5 per user / min                      |
| All other authenticated | 60 per user / min                     |

### 12.3 Coordinate Validation

All coordinates submitted by clients are validated server-side:

1. Must fall within the maximum radius of the system center (defined in `app_config`).
2. Origin-to-destination distance must be at least 500 meters.
3. No two consecutive stops within 200 meters of each other.

### 12.4 Soft Delete Policy

All user-facing tables include a `deleted_at` column. Records with `deleted_at IS NOT NULL` are excluded from all normal queries. Data is retained indefinitely for financial and audit compliance. PII fields may be anonymized after a legal retention period.

Affected tables: `users`, `drivers`, `passenger_payment_methods`, `saved_locations`.

---

## 13. Edge Cases & Failure Handling

### 13.1 No Drivers Available

The trip remains in `PENDING_DRIVER` while the matching algorithm retries. After the configured timeout, the trip transitions to `CANCELLED_BY_SYSTEM`. If the card was already charged, a refund is issued automatically. The passenger receives a push notification and a WebSocket event with a translated message. No cancellation fee.

### 13.2 Driver Cancels After Assignment

The trip's `driver_id` is cleared and the status returns to `PENDING_DRIVER`. Re-matching begins immediately. The passenger receives a real-time notification. If re-matching fails after the timeout, the trip becomes `CANCELLED_BY_SYSTEM` and the payment is refunded.

### 13.3 Quote Expires Before Booking

The booking request fails with a `quote_expired` error. The client must request a fresh quote (new `POST /trips/quote` call). The new quote reflects the current pricing rates. The client shows the updated price for the passenger to confirm before retrying the booking.

### 13.4 Multi-Stop Route Not Found

If the routing engine cannot compute a path via one of the stops (e.g., road closure, unreachable location), the quote request fails with a route error identifying the problematic segment. The passenger is shown which stop is the problem and asked to adjust or remove it. The booking is not created.

### 13.5 Scheduled Trip Conflict

If a new scheduled trip's time window overlaps with an existing active trip's time window, the booking is rejected with a conflict error identifying the conflicting trip. The passenger must resolve the conflict (cancel the existing trip or choose a different time) before the new booking can proceed.

### 13.6 Payment Failure at Trip Completion

The trip is still marked `COMPLETED` (the ride happened). The payment record is marked `failed`. A push notification is sent to the passenger to update their payment method. The failure is flagged for manual follow-up. Automatic retry behavior is TBD.

### 13.7 Driver Goes Offline Mid-Trip

- 60 seconds without location update: system alert generated internally
- 5 minutes: push notification sent to driver
- 10 minutes: admin alert for manual review
- 15 minutes: operator may force-complete or force-cancel the trip

The passenger's map shows the last known driver location with a system message indicating connection loss.

### 13.8 Passenger No-Show

The driver marks the passenger as absent from the driver app after a configurable grace period (default 5 minutes). The trip transitions to `PASSENGER_NO_SHOW` (terminal). No charge is applied in v1.

### 13.9 Promo Code Race Condition

Two passengers simultaneously attempt to redeem the last available use of the same code. The atomic conditional SQL update ensures exactly one succeeds. The other receives a `promo_code_exhausted` error and no discount is applied to their booking.

### 13.10 OTP Replay Attack

OTP sessions are one-time use. `consumed = true` is set immediately on the first successful verification. Any subsequent attempt using the same `session_token` returns `otp_already_consumed`. Sessions expire after 5 minutes regardless of consumption state.

---

## 14. Open Decisions

The following design decisions are intentionally deferred. The data model includes all necessary fields so these can be implemented without schema migrations.

| Decision                              | Status | Fields Reserved in Schema                                                       |
| ------------------------------------- | ------ | ------------------------------------------------------------------------------- |
| Driver matching algorithm             | TBD    | `drivers.current_lat/lng`, `drivers.status`, `drivers.acceptance_rate`          |
| Driver decline / no-response behavior | TBD    | `trips.status` machine supports re-matching                                     |
| Driver location update protocol       | DONE   | HTTP PATCH polling every 10 seconds                                             |
| Driver earnings / commission model    | DEFERRED| Managed offline in v1                                                           |
| Driver payout mechanism               | DEFERRED| Managed offline in v1                                                           |
| Dispute / support system              | TBD    | `trips.reference_code` enables support lookups                                  |
| Mid-trip stop editing                 | TBD    | `trip_stops.status` supports re-sequencing                                      |
| Waiting fee for passenger no-show     | TBD    | `trip_stops.arrived_at/departed_at` tracks timing                               |
| SMS provider selection                | TBD    | SMS interface is provider-agnostic                                              |
| Admin back-office full scope          | TBD    | `audit_logs`, `promo_codes` tables ready                                        |
| Payment retry policy on failure       | TBD    | `payments.status`, `trips.payment_status` support it                            |

---

_Document version: 2.0 — Revised 2026-05-03_
_Based on full codebase analysis of `lib/` + stakeholder Q&A session_
