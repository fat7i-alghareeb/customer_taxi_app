# Location Service Guide

## Purpose

This folder contains geolocator wrappers used by map and taxi location flows.

## Files

- location_service.dart
  - Checks if device location services are enabled.
  - Reads current position.
  - Exposes position stream for live updates.

## Usage

Use PermissionsCoordinator before location operations:

1. Ensure foreground location is granted.
2. Call LocationService APIs.
3. Request background permission only in flows that require continuous tracking.

## Notes

- Keep permission requests outside this folder.
- Permission logic belongs to core/services/permissions.
