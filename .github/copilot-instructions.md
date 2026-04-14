Always read .ai/project-rules.md before starting any task or writing any code.

# ALSULTAN PLATFORM — AI DEVELOPER PROTOCOL

> **This document is law.** No guessing, skipping, or deviating. Every rule is enforced without exception.

---

## §0 — SESSION START MANDATE

**First response MUST list every file read before touching any code:**

✅ Files Read:

- .ai/project-rules.md
- lib/lib_overview.md
- lib/features/features_overview.md
- lib/core/core_architecture_overview.md
- lib/common/common_folder_guide.md
- lib/utils/utils_folder_guide.md
- [+ objectbox_service_guide.md if touching storage]
- [+ router_guide.md if touching navigation]
- [+ session_service_guide.md if touching auth]

---

## §1 — MANDATORY READ ORDER

| #   | File                                                     | Purpose                   |
| --- | -------------------------------------------------------- | ------------------------- |
| 1   | `.ai/project-rules.md`                                   | Protocol anchor           |
| 2   | `lib/lib_overview.md`                                    | App lifecycle & layer map |
| 3   | `lib/features/features_overview.md`                      | BLoC & state management   |
| 4   | `lib/core/core_architecture_overview.md`                 | Design system & theme     |
| 5   | `lib/common/common_folder_guide.md`                      | Shared widgets & UI       |
| 6   | `lib/utils/utils_folder_guide.md`                        | Extensions & helpers      |
| 7   | `lib/core/services/objectbox/objectbox_service_guide.md` | Storage (if needed)       |
| 8   | `lib/core/router/router_guide.md`                        | Routing (if needed)       |
| 9   | `lib/core/services/session/session_service_guide.md`     | Auth & JWT                |

**Before creating ANY utility/widget:** audit `common_folder_guide.md` + `utils_folder_guide.md`. Duplicates = protocol failure.

---

## §2 — DOCUMENTATION SYNC

- Adding utility/widget/pattern → update its `.md` immediately.
- Adding major feature/dependency → update `README.md`.
- Never finish a task without confirming docs reflect all changes. Be granular and detailed.

---

## §3 — LOCALIZATION (ZERO HARDCODING)

1. Check `assets/l10n/ar.json` + `en.json` — reuse existing keys, no duplicates.
2. New keys → add to **both** files.
3. Run: `dart run tool/generate_app_strings.dart`
4. Use: `AppStrings.yourKey`

**❌ PROHIBITED:** `Text("Live")` · `'live'.tr()` · key in one file only · any `melos` command

---

## §4 — TYPOGRAPHY (`AppTextStyles` ONLY)

```dart
// ✅ Text("Title", style: AppTextStyles.s24w700)
// ✅ Text("Body", style: AppTextStyles.s14w400.copyWith(color: context.primary))
// ❌ context.titleMedium / context.bodySmall / TextStyle(fontSize: 24) — ALL PROHIBITED
```

Convention: `s[Size]w[Weight]` — e.g. `s40w700`, `s16w600`, `s14w400`. Colors via `.copyWith(color:)` only.

---

## §5 — SCALING (MANDATORY SUFFIXES)

| Use Case                                                     | Suffix                   | Example                                |
| ------------------------------------------------------------ | ------------------------ | -------------------------------------- |
| Font sizes, button heights, icon containers paired with text | `.sp`                    | `fontSize: 16.sp`                      |
| Fixed layout heights                                         | `.h`                     | `height: 180.h`                        |
| Fixed layout widths                                          | `.w`                     | `width: 120.w`                         |
| Border radius, icon sizes                                    | `.r`                     | `BorderRadius.circular(AppRadii.lg.r)` |
| Vertical spacing between sections                            | `.h` or `.verticalSpace` | see below                              |
| Horizontal margins/padding                                   | `.w`                     | `AppSpacing.xl.w`                      |

**❌ PROHIBITED:** Any raw `double` without a suffix.

---

## §6 — COLORS (SEMANTIC TOKENS ONLY)

```dart
// ✅ context.primary / context.surface / context.onSurface / AppColors.success
// ❌ Colors.green / Color(0xFF...) / Theme.of(context).colorScheme.* / context.colorScheme.*
// ❌ .withOpacity() — DEPRECATED. Use .withValues(alpha: 0.5) ONLY
```

---

## §7 — PADDING, SPACING & VERTICAL SPACE

**Use `REdgeInsets` exclusively. Never `EdgeInsets`.**

```dart
// ✅ padding: REdgeInsets.all(AppSpacing.md)
// ✅ padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)
// ❌ EdgeInsets.all(16) / EdgeInsets.symmetric(horizontal: 24) — PROHIBITED
```

**AppSpacing tokens:** `xs=4` · `sm=8` · `md=12` · `lg=16` · `xl=24` · `xxl=32`

**AppRadii tokens:** `s` (small) · `m` (medium) · `lg=16` · `xl` (large)

### Vertical Spacing Rule

Prefer the `.verticalSpace` extension from `flutter_screen_util` for vertical gaps between widgets.

```dart
// ✅ CORRECT — preferred
AppSpacing.md.verticalSpace       // renders as SizedBox(height: 12.h)
AppSpacing.lg.verticalSpace       // renders as SizedBox(height: 16.h)
AppSpacing.xl.verticalSpace       // renders as SizedBox(height: 24.h)

// ✅ ALSO CORRECT — when verticalSpace reads less clearly
SizedBox(height: AppSpacing.md.h)

// ❌ PROHIBITED
SizedBox(height: 16)              // raw number
SizedBox(height: 16.h)            // raw number even with suffix
```

---

## §8 — ICONS (`FaIcon` + `FontAwesomeIcons` ONLY)

```dart
// ✅ FaIcon(FontAwesomeIcons.bell, size: 24.r)
// ❌ Icon(Icons.*) — PROHIBITED
// ❌ FaIcon without .r on size — PROHIBITED
```

---

## §9 — SHADOWS & GRADIENTS (`AppThemeEffects` ONLY)

```dart
// ✅ boxShadow: context.shadows.primary  /  gradient: context.gradients.primary
// ❌ BoxShadow(...) inline / LinearGradient(...) inline — PROHIBITED
```

New effects must be added to `AppThemeEffects` first — never defined ad-hoc.

---

## §10 — SCAFFOLD (`AppScaffold` MANDATORY)

```dart
// ✅ AppScaffold(body: HomeBody())   or   AppScaffold.search(body: HomeBody())
// ❌ Scaffold(...) — PROHIBITED
```

Every screen **must** define:

```dart
static const String pagePath = '/feature_name';
static const String pageName = 'FeatureNameScreen';
```

---

## §11 — WIDGET DECOMPOSITION (3-TIER HIERARCHY)

Screen (screens/) → Section (widgets/[group]/) → Atomic Widget (widgets/[group]/)

- Every Section and non-trivial widget → its **own file**.
- **❌ Inline private classes** (`class _Widget`) inside Screen/Section files — PROHIBITED.

---

## §12 — BUTTONS (`AppButton` ONLY)

```dart
// ✅ AppButton.primaryGradient(label: AppStrings.submit, isActive: isValid, onPressed: _onSubmit)
// ❌ ElevatedButton / TextButton / GestureDetector-as-button — PROHIBITED
// ❌ onPressed: null to disable — use isActive: false ONLY
```

---

## §13 — FORMS (Centralized in `constants/forms/`)

```dart
// ✅ abstract class LoginForms {
//   static const String emailField = 'email';
//   static FormGroup formGroup() => FormGroup({ emailField: FormControl<String>(...) });
// }
// ❌ FormGroup inside Screen / BLoC / Widget — PROHIBITED
// ❌ Raw string keys: form.control('email') — PROHIBITED
```

---

## §14 — STATE MANAGEMENT (BLoC + Freezed + `StatusBuilder<T>`)

**State:** One `BlocStatus<T>` per async op in a `@freezed` class.

**BLoC handler:**

```dart
emit(state.copyWith(productsState: const BlocStatus.loading()));
result.when(
  success: (data) => emit(state.copyWith(productsState: BlocStatus.success(data))),
  failure: (msg)  => emit(state.copyWith(productsState: BlocStatus.failure(msg))),
);
```

**UI:** Use `StatusBuilder<T>` exclusively — **❌ never** manual `if (state is BlocStatusLoading)` switching.

---

## §15 — CLEAN DATA LAYER

| Layer              | Rule                                                                        |
| ------------------ | --------------------------------------------------------------------------- |
| **Entity**         | Pure Freezed, zero JSON logic, consumed by BLoC + UI                        |
| **Model/DTO**      | `fromJson`/`toJson` only, never passed to BLoC or UI                        |
| **Mapper**         | `extension ProductModelMapper on ProductModel { ProductEntity toEntity() }` |
| **Request params** | Always a dedicated `RequestModel` class — never raw params or maps          |

---

## §16 — ERROR HANDLING

```dart
// DataSource → rethrowAsAppException(() async { ... })
// Repository → runAsResult(() async { ... })
// ❌ Unprotected async calls — PROHIBITED
```

---

## §17 — NAVIGATION (Typed Routing)

```dart
// ✅ Typed Args class + context.pushNamed(Screen.pageName, extra: Args(...))
// ✅ Receive: GoRouterState.of(context).extra as ScreenArgs
// ❌ Raw query strings / raw IDs when Args class exists — PROHIBITED
```

Startup navigation is driven by `AppRouteGuard` — do not manually navigate during bootstrap.

---

## §18 — ANIMATIONS (MANDATORY on all screens)

Static, unanimated UI = failure state.

- **Tier 1 (90%):** `flutter_animate` — staggered `.animate().fadeIn().slideY()`
- **Tier 2:** `AnimatedContainer` / `AnimatedOpacity` / `AnimatedPadding` for state-driven changes
- **Tier 3 (last resort):** `AnimationController` — must document why Tier 1/2 was insufficient

**Timing:** `AppDurations.fast=150ms` · `normal=250ms` · `slow=350ms`

---

## §19 — IMPORTS & CODE QUALITY

```dart
// ✅ import 'package:alsultan/common/imports/imports.dart';   (barrel)
// ❌ Relative imports where package import is available
// ✅ Logging: printC (info) / printM (state/BLoC) / printY (network)
// ❌ print() / debugPrint() / log() — PROHIBITED
```

- No unused imports, variables, or commented-out dead code in final output.
- Comments explain **WHY** — never "returns a widget" or "builds UI".

---

## §20 — GLOBAL PROMOTION RULE

If a widget/helper/logic block could be reused → extract it:

- Reusable UI → `lib/common/widgets/` + update `common_folder_guide.md`
- Pure utility/extension → `lib/utils/` + update `utils_folder_guide.md`

---

## §21 — WEBVIEW SECURITY

After every auth WebView cycle → **clear BOTH cookies AND cache**. Non-negotiable.

---

## §22 — CODE GENERATION COMMANDS

| Task                 | Command                                                    |
| -------------------- | ---------------------------------------------------------- |
| AppStrings from JSON | `dart run tool/generate_app_strings.dart`                  |
| Freezed / injectable | `dart run build_runner build --delete-conflicting-outputs` |

**❌ melos · `flutter pub run` form · build_runner without `--delete-conflicting-outputs`**

---

## §23 — FEATURE DIRECTORY STRUCTURE

lib/features/feature_name/
├── constants/forms/feature_forms.dart
├── data/
│ ├── datasources/ (rethrowAsAppException)
│ ├── models/ (fromJson/toJson only)
│ ├── mappers/ (model.toEntity())
│ └── repositories/ (runAsResult)
├── domain/
│ ├── entities/ (pure Freezed, zero JSON)
│ ├── repositories/ (abstract interface)
│ └── facade/ (optional orchestration)
└── presentation/
├── states/ (bloc + event + state)
└── ui/
├── screens/ (AppScaffold, pagePath, pageName)
└── widgets/[logic_group]/ (one widget per file)

---

## §24 — DATE & INPUT FORMATTING

```dart
// ✅ Dates: myDate.toYmd() / .toSmartDateTime() / .toTime12Compact()
// ❌ DateFormat('yyyy-MM-dd').format(myDate) / myDate.toString() — PROHIBITED
// ✅ Numeric inputs: inputFormatters: [ArabicToEnglishDigitsFormatter()]
```

---

## §25 — LOADING STATES (SHIMMER MANDATORY)

```dart
// ✅ loading: () => const ProductsListShimmer()   (mirrors content shape, uses AppShimmer base)
// ✅ Full-screen block: MainLoadingProgress()  |  Inline: LoadingDots()
// ❌ CircularProgressIndicator() in content areas — PROHIBITED
```

---

## §26 — ASSETS (FlutterGen ONLY)

```dart
// ✅ Image.asset(Assets.images.logo.path)
// ❌ Image.asset('assets/images/logo.png') — PROHIBITED
```

After adding assets → `dart run build_runner build --delete-conflicting-outputs`

---

## §27 — ATOMIC UI CONSISTENCY

```dart
// ✅ Error: FailedStateWidget(message: AppStrings.x, onRetry: _fetch)
// ✅ Empty: EmptyStateWidget(message: AppStrings.noData)
// ❌ Ad-hoc Column(Icon, Text, TextButton) for error/empty — PROHIBITED
```

---

## §28 — VIOLATION CHECKLIST (all must be ✅ before task complete)

**Localization:** no hardcoded strings · no `.tr()` on raw keys · new keys in both files · no melos  
**Typography:** no `context.bodySmall` etc · no inline `TextStyle` · color via `.copyWith` only  
**Scaling:** no raw doubles · `.sp/.h/.w/.r` on all dims · `AppSpacing` tokens for spacing  
**Colors:** no `Colors.*` · no hex `Color(0xFF...)` · no `Theme.of` · `.withValues(alpha:)` not `.withOpacity()`  
**Padding:** `REdgeInsets` only · `AppSpacing` tokens · `AppRadii` + `.r` for radius  
**Icons:** `FaIcon(FontAwesomeIcons.*)` only · `.r` on every size  
**Effects:** `context.shadows/gradients` only · no inline `BoxShadow`/`LinearGradient`  
**Architecture:** `AppScaffold` · `pagePath`+`pageName` · no inline `_Widget` classes · `AppButton` system · `isActive` not null `onPressed` · `FormGroup` in `constants/forms/` · `StatusBuilder<T>` in UI  
**Data layer:** `rethrowAsAppException` on DataSource · `runAsResult` on Repository · Mapper for every Model→Entity · `RequestModel` for params  
**Code quality:** `printC/M/Y` only · no unused imports · package imports · no dead code · docs updated  
**Formatting:** date extensions · `ArabicToEnglishDigitsFormatter` on numeric inputs  
**Assets:** `Assets` class, not raw strings  
**States:** shimmer for loading · `FailedStateWidget` for errors · `EmptyStateWidget` for empty  
**Security:** WebView cookies + cache cleared after auth  
**Animations:** every screen section + list widget has entry animation

---

## §29 — FINAL COMPLETION CHECKLIST

Answer **YES** to all before declaring done:

1. Read all mandatory files in order and listed them?
2. Audited `common_folder_guide` + `utils_folder_guide` before creating anything?
3. All strings via `AppStrings`?
4. All text styles via `AppTextStyles.sXXwXXX.copyWith(color:)`?
5. All dims with `.sp/.h/.w/.r` — zero raw doubles?
6. All colors via `AppColors` / `context.*` tokens?
7. All padding via `REdgeInsets` + `AppSpacing`?
8. All icons via `FaIcon(FontAwesomeIcons.*)` with `.r`?
9. All shadows/gradients via `context.shadows/gradients`?
10. Every screen uses `AppScaffold` with `pagePath`+`pageName`?
11. Every widget in its own file?
12. Every button uses `AppButton` with `isActive`?
13. Every `FormGroup` in `constants/forms/` abstract class?
14. Every async UI state via `StatusBuilder<T>`?
15. Every DataSource call in `rethrowAsAppException`?
16. Every Repository call in `runAsResult`?
17. Every Model→Entity via Mapper?
18. Used `dart run tool/generate_app_strings.dart` (not melos)?
19. Used `dart run build_runner build --delete-conflicting-outputs`?
20. Used `printC/M/Y` for all logging?
21. All `.md` docs updated?
22. Every screen section + list widget has `flutter_animate` entry animation?
23. Used `.withValues(alpha:)` not `.withOpacity()`?
24. WebView cookies + cache cleared after auth?
25. All dates via mandatory date extension methods?
26. All numeric inputs use `ArabicToEnglishDigitsFormatter`?
27. All assets via generated `Assets` class?
28. All loading states use shimmer / `MainLoadingProgress` / `LoadingDots`?
29. All error/empty states use `FailedStateWidget` / `EmptyStateWidget`?

---

_This file supersedes all previous documentation. In any conflict, this file wins._

1. All numeric inputs use `ArabicToEnglishDigitsFormatter`?
2. All assets via generated `Assets` class?
3. All loading states use shimmer / `MainLoadingProgress` / `LoadingDots`?
4. All error/empty states use `FailedStateWidget` / `EmptyStateWidget`?

---

_This file supersedes all previous documentation. In any conflict, this file wins._
_This file supersedes all previous documentation. In any conflict, this file wins.\_\_This file supersedes all previous documentation. In any conflict, this file wins._

_This file supersedes all previous documentation. In any conflict, this file wins.\_\_This file supersedes all previous documentation. In any conflict, this file wins._
