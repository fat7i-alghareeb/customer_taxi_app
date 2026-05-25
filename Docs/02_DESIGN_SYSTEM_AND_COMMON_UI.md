# Flutter App - Design System & Common UI Layer

This document details Phase 2.2 of our deep dive into the Flutter customer taxi application (`customertaxi`), focusing on the strict design rules, theming engine, and shared UI components inside `lib/common` and `lib/core/theme`.

## 1. Theming Engine (`lib/core/theme/`)

The application enforces a strictly tokenized design system to avoid hardcoded styles, scaling issues, and inconsistent UI.

- **`AppColors`**: Defines semantic and brand colors independent of theme mode (e.g., `AppColors.brandGold`, `AppColors.primary`).
- **`AppThemeColors`**: An extended palette providing context-aware colors via extensions (`context.grey`, `context.surface`).
- **`AppTypography` & `AppTextStyles`**: 
  - Uses `GoogleFonts.outfit()`.
  - All text must use predefined static getters like `AppTextStyles.s16w600`.
  - The getters explicitly strip the `color` property so that `.copyWith(color: ...)` works seamlessly across light and dark modes without colliding with inherited values.
- **`ThemeController`**: A `ChangeNotifier` singleton persisting the `ThemeMode` in `StorageService`.

## 2. Responsive Sizing & Typography

The codebase enforces strict usage of `flutter_screenutil`. Using a raw `double` like `16` or `EdgeInsets.all(16)` is treated as a protocol violation.
- **`.h`**: Vertical heights, `AppSpacing.md.verticalSpace`.
- **`.w`**: Horizontal widths and padding.
- **`.sp`**: Scalable pixels for fonts.
- **`.r`**: Border radii and icon sizes.
- **`AppSpacing`**: Tokenized sizes (`xs=4`, `sm=8`, `md=12`, `lg=16`, `xl=24`).

## 3. Atomic Common Components (`lib/common/widgets/`)

The application builds screens by composing these core building blocks:

- **`AppButton`**: A highly robust button handling its own loading state (`LoadingDots`), active/inactive toggles, and tap-when-inactive logic (useful for showing toasts when a disabled button is tapped). It manages a low-level `AnimationController` to physically shrink when pressed, combined with `Vibration` for haptic feedback.
- **`AppDialog` & `AppBottomSheet`**: Standardized overlays ensuring a uniform glassy aesthetic, max-widths for tablets, and drag handles.
- **`AppShimmer`**: Global skeleton loading animation.
- **`FailedStateWidget` & `EmptyStateWidget`**: Standardized error and empty states used exclusively for layout consistency across features.
- **`AppIconSource`**: A unified class handling `IconData`, SVG paths, or Asset paths under a single API.

## 4. Application Shell (`custom_scaffold/`)

Every screen in the app MUST be wrapped in `AppScaffold`.
- **`AppScaffold`**: Orchestrates safe areas, a persistent `EndDrawer`, glassy `AppScaffoldAppBar`, and search overlays (`AppScaffoldSearch`).
- **`AppScaffoldTapArea`**: Ensures keyboards are unfocused globally when a user taps empty space.

## 5. Reactive Forms (`widgets/form/`)

The app leverages `reactive_forms` heavily for form validation and data binding.
- All forms are localized.
- `AppReactiveTextField` standardizes the visual appearance (decorations, clear buttons, suffixes).
- Validation messages map directly to the active locale via `AppReactiveValidationMessages`.

## 6. Animation Protocol

The project enforces a 3-Tier animation mandate:
- **Tier 1 (90%)**: `flutter_animate`. All screen sections must have entry animations (e.g., `.fadeIn().slideY()`).
- **Tier 2**: Implicit animations (`AnimatedContainer`, `AnimatedOpacity`) for state changes.
- **Tier 3 (Rare)**: Manual `AnimationController` for complex interactions (used internally by `AppButton`).

## 7. Localization (`assets/l10n/`)

- Localization relies on `EasyLocalization` reading from `en.json`, `ar.json`, etc.
- Keys are strictly mapped using the codegen script `generate_app_strings.dart` which creates `AppStrings.yourKey`.
- String hardcoding in UI code is strictly prohibited.

---
*End of Phase 2.2 Analysis. Next: Phase 2.3 - Feature Domain & Data Layers.*
