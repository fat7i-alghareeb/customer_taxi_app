# customertaxi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Current feature highlights

- Order flow is map-overlay based on the Root screen.
- From/To location confirmation now fetches and renders a Google Directions route.
- From/To suggestions now persist in ObjectBox with recents + pin support.
- Before typing, saved locations are shown; while typing, remote search suggestions are shown.
- Saved suggestions are capped at 10 total with overflow removing oldest unpinned first.
- Approximate trip time is shown from Google duration text.
- Vehicle selection step includes 3 ride categories (Standard, Comfort, 8-passenger bus).
- Vehicle prices are fetched in one mocked datasource response, with price-only loading in cards.
