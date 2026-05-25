# Flutter App - Presentation Layer & State Management

This document details Phase 2.4 of our deep dive into the Flutter customer taxi application (`customertaxi`), focusing on BLoC State Management and the 3-Tier UI Decomposition rules enforced across the presentation layer.

## 1. State Management (BLoC + Freezed)

The application strictly utilizes `flutter_bloc` combined with `freezed` for immutable states. It actively discourages generic state enums (e.g., `enum State { loading, loaded, error }`) at the top level of the state object.

### The `BlocStatus<T>` Pattern
Instead of a single global state enum, the app defines independent asynchronous operations using `BlocStatus<T>`.

*Example (`AuthState`):*
```dart
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(BlocStatus<void>.initial()) BlocStatus<void> phoneStatus,
    @Default(BlocStatus<UserEntity>.initial()) BlocStatus<UserEntity> otpStatus,
    @Default(false) bool isOtpSent,
    @Default(true) bool isLanding,
    String? verificationId,
  }) = _AuthState;
}
```
This isolates the "Send OTP" loading state (`phoneStatus`) from the "Verify OTP" loading state (`otpStatus`), allowing complex multi-step UI flows without overriding unrelated states.

### StatusBuilder Integration
To map `BlocStatus<T>` directly to the UI, the app uses `StatusBuilder<T>`. This avoids repetitive `if (state is Loading) return CircularProgressIndicator()`. `StatusBuilder` natively handles success, failure, loading, and empty states.

## 2. 3-Tier UI Decomposition

To prevent massive `build` methods, the UI strictly enforces a 3-tier hierarchy:

### Tier 1: Screens (`ui/screens/`)
- Acts as the top-level route entry point.
- **Responsibility:** Injects the `BlocProvider`, manages routing arguments, and wraps the body in an `AppScaffold`.
- *Example: `LoginScreen` wraps `_LoginScreenBody` in `BlocProvider(create: (_) => getIt<AuthBloc>())`.*

### Tier 2: Sections (`ui/widgets/`)
- Large chunks of the screen logic.
- **Responsibility:** Orchestrating layout and managing forms.
- *Example: `LoginScreen` toggles between `LoginLandingSection`, `LoginPhoneSection`, and `LoginOtpSection` using an `AnimatedSwitcher`.*

### Tier 3: Atomic Widgets (`ui/widgets/`)
- The smallest reusable components specific to the feature.
- **Responsibility:** Rendering specific data cleanly.

## 3. Reactive Forms Integration

Forms are managed inside the StatefulWidget state (usually at the Screen or Section level) using `reactive_forms`.
- *Example:* `LoginScreen` instantiates `AuthForms.loginFormGroup()` and wraps the scaffold body in a `ReactiveForm` widget.
- This allows deep form nesting and validation without needing manual `TextEditingController` management.

## 4. UI Polish & Animations

Every UI transition leverages the mandated 3-Tier animation protocol:
- Screens heavily use `flutter_animate` for staggered load-ins.
- *Example from LoginScreen:* `animate().fadeIn(delay: 200.ms).slideY(begin: 0.2)` applied to text blocks, and `AnimatedSwitcher` used for fading between phone and OTP sections.

---
*End of Phase 2.4 Analysis. Next: Phase 2.5 - System Flows & Orchestration.*
