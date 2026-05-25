# Flutter App - Domain & Data Layers (Clean Architecture)

This document details Phase 2.3 of our deep dive into the Flutter customer taxi application (`customertaxi`), focusing on the strict boundaries between Domain (business logic) and Data (infrastructure implementation) within the `features/` directory.

## 1. Structural Mandate (`lib/features/`)

Every feature module strictly adheres to a 3-layer architecture. Models and DTOs MUST NEVER leak into the Domain or Presentation layers.

- **`domain/`**: Contains pure business logic.
  - `entities/`: Pure Dart/Freezed classes. No JSON serialization logic.
  - `repositories/`: Abstract interfaces defining data operations.
  - `facade/`: Optional orchestration layer that executes business rules and coordinates multiple repositories.
- **`data/`**: Contains implementation details.
  - `datasources/`: API clients (Dio) or local storage clients (ObjectBox).
  - `models/`: DTOs that handle `fromJson`/`toJson`.
  - `mappers/`: Extension methods (e.g., `toEntity()`) to convert Data Models into Domain Entities.
  - `repositories/`: Concrete implementations of domain interfaces.
  - `params/`: Dedicated `RequestModel` classes for API calls (never raw Maps or primitive lists).

## 2. Error Handling Flow

The application forces developers to handle errors structurally rather than relying on unstructured try-catch blocks.

### `rethrowAsAppException` (Data Source Layer)
Data Sources wrap every single network or local database call in `rethrowAsAppException`.
- This catches native Dio errors, SocketExceptions, or JSON parsing errors and converts them uniformly into an `AppException` (like `NetworkException`, `ServerException`, `AuthException`).

*Example (`AuthRemoteDataSource.dart`):*
```dart
Future<AuthLoginResponseModel> login(LoginParams params) =>
    rethrowAsAppException(() async {
      final res = await _dio.post(ApiEndpoints.login, data: params.toJson());
      return AuthLoginResponseModel.fromJson(res.data);
    });
```

### `runAsResult` (Repository Layer)
Repositories wrap Data Source calls in `runAsResult`.
- This catches any thrown `AppException` and wraps it in a sealed `Result<T>` union (either `success` or `failure`).
- This guarantees that the BLoC (Presentation layer) never has to deal with Try/Catch blocks, only `Result` pattern matching.

*Example (`AuthRepositoryImpl.dart`):*
```dart
@override
Future<Result<UserEntity>> verifyAndLogin(...) {
  return runAsResult(() async {
    final idToken = await _firebase.signInAndGetIdToken(...);
    final response = await _remote.login(...);
    
    // Mappers ensure Domain layer stays pure
    final user = response.toUserEntity();
    await _authManager.login(user: user, token: response.toAuthTokenModel());
    return user;
  });
}
```

## 3. The Facade Pattern

Most features utilize a `Facade` (e.g., `AuthFacade`). 
- While often a simple pass-through to the Repository, it serves as an orchestration layer.
- If a specific UI action requires updating the remote DB, saving to local ObjectBox, and refreshing a global `SessionManager`, the BLoC calls the `Facade`, keeping BLoCs strictly focused on State-to-UI mapping.

## 4. ObjectBox Local Caching Strategy

When offline-first or caching is required (e.g., `ProductEntity`), the Clean Architecture approach merges the Domain Entity with the ObjectBox Entity.
- Domain Entities are annotated with `@Entity()` and `@Id() objId`.
- The API's remote string UUID is kept as an `@Index()` field (e.g., `String id`).
- This avoids needing a separate `LocalModel` and `DomainModel` just to appease the local database, significantly reducing boilerplate while keeping the UI fully unaware of ObjectBox internals.

---
*End of Phase 2.3 Analysis. Next: Phase 2.4 - Presentation Layer & State Management.*
