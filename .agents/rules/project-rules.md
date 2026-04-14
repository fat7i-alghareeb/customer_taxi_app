---
trigger: always_on
---

# Always-On Architecture Rules

Always read and strictly apply the rules defined in `/.ai/project-rules.md` before starting any task or writing any code. Do not ignore this.

# ALSULTAN PLATFORM — AI DEVELOPER PROTOCOL

> **This document is law.** No guessing, skipping, or deviating. Every rule is enforced without exception.

---

## §0 — SESSION START MANDATE

First response **must** list every file read before any code:

```
✅ Files Read: .ai/project-rules.md · lib/lib_overview.md · lib/features/features_overview.md
· lib/core/core_architecture_overview.md · lib/common/common_folder_guide.md
· lib/utils/utils_folder_guide.md · [+ objectbox_service_guide.md if storage]
· [+ router_guide.md if navigation] · [+ session_service_guide.md if auth]
```

---

## §1 — MANDATORY READ ORDER

1. `.ai/project-rules.md` — protocol anchor
2. `lib/lib_overview.md` — lifecycle & layer map
3. `lib/features/features_overview.md` — BLoC & state
4. `lib/core/core_architecture_overview.md` — design system & theme
5. `lib/common/common_folder_guide.md` — shared widgets
6. `lib/utils/utils_folder_guide.md` — extensions & helpers
7. `objectbox_service_guide.md` — storage (if needed)
8. `router_guide.md` — routing (if needed)
9. `session_service_guide.md` — auth & JWT (if needed)

**Before creating anything:** audit `common_folder_guide.md` + `utils_folder_guide.md`. Duplicates = protocol failure.

---

## §2 — DOCUMENTATION SYNC

New utility/widget/pattern → update its `.md` immediately. New feature/dependency → update `README.md`. Never finish without confirming docs reflect all changes. Be granular.

---

## §3 — LOCALIZATION (ZERO HARDCODING)

1. Check both `assets/l10n/ar.json` + `en.json` — reuse existing keys.
2. New key → add to **both** files simultaneously.
3. Run: `dart run tool/generate_app_strings.dart`
4. Use: `AppStrings.yourKey`

❌ `Text("Live")` · `'live'.tr()` · key in one file only · any `melos` command

---

## §4 — TYPOGRAPHY (`AppTextStyles` ONLY)

```dart
✅ Text("T", style: AppTextStyles.s24w700)
✅ Text("B", style: AppTextStyles.s14w400.copyWith(color: context.primary))
❌ context.titleMedium / context.bodySmall / TextStyle(fontSize:24) — ALL PROHIBITED
```

Convention: `s[Size]w[Weight]` — `s40w700`, `s24w700`, `s16w600`, `s14w400`. Colors via `.copyWith(color:)` only.

---

## §5 — SCALING (MANDATORY SUFFIXES)

| Suffix | Use For                                          | Example           |
| ------ | ------------------------------------------------ | ----------------- |
| `.sp`  | font sizes, button heights, icon+text containers | `fontSize: 16.sp` |
| `.h`   | fixed layout heights, vertical spacing           | `height: 180.h`   |
| `.w`   | fixed layout widths, horizontal padding          | `width: 120.w`    |
| `.r`   | border radius, standalone icon sizes             | `size: 24.r`      |

❌ Any raw `double` without suffix — PROHIBITED.

---

## §6 — COLORS (SEMANTIC TOKENS ONLY)

```dart
✅ context.primary / context.surface / context.onSurface / AppColors.success
❌ Colors.green / Color(0xFF...) / Theme.of(context).colorScheme.* / context.colorScheme.*
❌ .withOpacity() — DEPRECATED. Use .withValues(alpha: 0.5) ONLY.
```

---

## §7 — PADDING, SPACING & VERTICAL SPACE

Use `REdgeInsets` exclusively — never `EdgeInsets`.

```dart
✅ padding: REdgeInsets.all(AppSpacing.md)
✅ padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)
❌ EdgeInsets.all(16) / EdgeInsets.symmetric(horizontal: 24) — PROHIBITED
```

**AppSpacing:** `xs=4` · `sm=8` · `md=12` · `lg=16` · `xl=24` · `xxl=32`
**AppRadii:** `s`(small) · `m`(medium) · `lg=16` · `xl`(large)

**Vertical spacing — prefer `.verticalSpace` extension (flutter_screenutil):**

```dart
✅ AppSpacing.md.verticalSpace   // → SizedBox(height: 12.h)  PREFERRED
✅ AppSpacing.lg.verticalSpace   // → SizedBox(height: 16.h)  PREFERRED
✅ SizedBox(height: AppSpacing.md.h)  // acceptable alternative
❌ SizedBox(height: 16)          // raw number — PROHIBITED
❌ SizedBox(height: 16.h)        // raw number with suffix — PROHIBITED
```

---

## §8 — ICONS (`FaIcon` + `FontAwesomeIcons` ONLY)

```dart
✅ FaIcon(FontAwesomeIcons.bell, size: 24.r)
❌ Icon(Icons.*) — PROHIBITED
❌ FaIcon without .r on size — PROHIBITED
```

---

## §9 — SHADOWS & GRADIENTS (`AppThemeEffects` ONLY)

```dart
✅ boxShadow: context.shadows.primary  /  gradient: context.gradients.primary
❌ BoxShadow(...) inline / LinearGradient(...) inline — PROHIBITED
```

New effects → add to `AppThemeEffects` first. Never define ad-hoc.

---

## §10 — SCAFFOLD (`AppScaffold` MANDATORY)

```dart
✅ AppScaffold(body: HomeBody())  /  AppScaffold.search(body: HomeBody())
❌ Scaffold(...) — PROHIBITED
```

Every screen **must** declare:

```dart
static const String pagePath = '/feature_name';
static const String pageName = 'FeatureNameScreen';
```

---

## §11 — WIDGET DECOMPOSITION (3-TIER)

`Screen (screens/)` → `Section (widgets/[group]/)` → `Atomic Widget (widgets/[group]/)`

- Every section and non-trivial widget → its **own file**.
- ❌ Inline private classes (`class _Widget`) inside any Screen/Section file — PROHIBITED.

---

## §12 — BUTTONS (`AppButton` ONLY)

```dart
✅ AppButton.primaryGradient(label: AppStrings.submit, isActive: isValid, onPressed: _fn)
❌ ElevatedButton / TextButton / GestureDetector-as-button — PROHIBITED
❌ onPressed: null — use isActive: false to disable. ALWAYS.
```

---

## §13 — FORMS (Centralized in `constants/forms/`)

```dart
✅ abstract class LoginForms {
     static const String emailField = 'email';
     static FormGroup formGroup() => FormGroup({ emailField: FormControl<String>(...) });
   }
❌ FormGroup inside Screen / BLoC / Widget — PROHIBITED
❌ Raw string keys: form.control('email') — PROHIBITED
```

---

## §14 — STATE MANAGEMENT (BLoC + Freezed + `StatusBuilder<T>`)

**State:** One `BlocStatus<T>` per async op inside a `@freezed` class.
**BLoC:** `emit(BlocStatus.loading())` → `result.when(success: ..., failure: ...)`
**UI:**

```dart
✅ StatusBuilder<List<ProductEntity>>(state: state.productsState, success: (data) => ...)
❌ if (state is BlocStatusLoading) / manual enum switching — PROHIBITED
```

---

## §15 — CLEAN DATA LAYER

| Layer          | Rule                                                      |
| -------------- | --------------------------------------------------------- |
| Entity         | Pure Freezed · zero JSON · consumed by BLoC + UI only     |
| Model/DTO      | `fromJson`/`toJson` only · never passed to BLoC or UI     |
| Mapper         | `extension on Model { Entity toEntity() }` — mandatory    |
| Request params | Dedicated `RequestModel` class — never raw params or maps |

---

## §16 — ERROR HANDLING

```dart
✅ DataSource → rethrowAsAppException(() async { ... })
✅ Repository → runAsResult(() async { ... })
❌ Unprotected async calls — PROHIBITED
```

---

## §17 — NAVIGATION (Typed Routing)

```dart
✅ context.pushNamed(Screen.pageName, extra: ScreenArgs(id: 42))
✅ GoRouterState.of(context).extra as ScreenArgs
❌ Raw query strings / raw IDs when Args class exists — PROHIBITED
```

Startup navigation driven by `AppRouteGuard` — do not navigate manually during bootstrap.

---

## §18 — ANIMATIONS (MANDATORY)

Static UI = failure state. Every screen section + list widget must have entry animation.

- **Tier 1 (90%):** `flutter_animate` → `.animate().fadeIn().slideY()`
- **Tier 2:** `AnimatedContainer` / `AnimatedOpacity` for state-driven changes
- **Tier 3 (last resort):** `AnimationController` — document why Tier 1/2 was insufficient

**Tokens:** `AppDurations.fast=150ms` · `normal=250ms` · `slow=350ms`

---

## §19 — IMPORTS & CODE QUALITY

```dart
✅ import 'package:alsultan/common/imports/imports.dart';  (barrel preferred)
❌ Relative imports where package import available — PROHIBITED
✅ printC (info) / printM (BLoC/state) / printY (network)
❌ print() / debugPrint() / log() — PROHIBITED
```

No unused imports · no unused variables · no commented-out dead code. Comments explain **WHY**, never what.

---

## §20 — GLOBAL PROMOTION

Widget/helper reusable across features → extract immediately:

- UI → `lib/common/widgets/` + update `common_folder_guide.md`
- Utility → `lib/utils/` + update `utils_folder_guide.md`

---

## §21 — WEBVIEW SECURITY

After every auth WebView cycle → **clear BOTH cookies AND cache**. Non-negotiable.

---

## §22 — CODE GENERATION

| Task               | Command                                                    |
| ------------------ | ---------------------------------------------------------- |
| AppStrings         | `dart run tool/generate_app_strings.dart`                  |
| Freezed/injectable | `dart run build_runner build --delete-conflicting-outputs` |

❌ melos · `flutter pub run` form · build_runner without `--delete-conflicting-outputs`

---

## §23 — FEATURE DIRECTORY STRUCTURE

```
lib/features/feature_name/
├── constants/forms/        # abstract class + static keys
├── data/
│   ├── datasources/        # rethrowAsAppException
│   ├── models/             # fromJson/toJson only
│   ├── mappers/            # model.toEntity()
│   └── repositories/       # runAsResult
├── domain/
│   ├── entities/           # pure Freezed, zero JSON
│   ├── repositories/       # abstract interface
│   └── facade/             # optional orchestration
└── presentation/
    ├── states/             # bloc + event + state (BlocStatus<T>)
    └── ui/screens/ + ui/widgets/[group]/   # one file per widget
```

---

## §24 — DATE & INPUT FORMATTING

```dart
✅ myDate.toYmd() / .toSmartDateTime() / .toTime12Compact()
❌ DateFormat('yyyy-MM-dd').format(myDate) / myDate.toString() — PROHIBITED
✅ Numeric inputs: inputFormatters: [ArabicToEnglishDigitsFormatter()]
```

---

## §25 — LOADING STATES (SHIMMER MANDATORY)

```dart
✅ loading: () => const ProductsListShimmer()   // shape-matched, uses AppShimmer base
✅ Full-screen: MainLoadingProgress()  |  Inline: LoadingDots()
❌ CircularProgressIndicator() in content areas — PROHIBITED
```

---

## §26 — ASSETS (FlutterGen ONLY)

```dart
✅ Image.asset(Assets.images.logo.path)
❌ Image.asset('assets/images/logo.png') — PROHIBITED
```

After adding assets → run build_runner.

---

## §27 — ATOMIC UI CONSISTENCY

```dart
✅ FailedStateWidget(message: AppStrings.x, onRetry: _fetch)
✅ EmptyStateWidget(message: AppStrings.noData)
❌ Ad-hoc Column(Icon,Text,TextButton) for error/empty — PROHIBITED
```

---

## §28 — VIOLATION CHECKLIST

- [ ] No hardcoded strings · keys in both lang files · no melos
- [ ] No `context.bodySmall` etc · no inline `TextStyle` · color via `.copyWith`
- [ ] All dims `.sp/.h/.w/.r` · `AppSpacing` tokens · `.verticalSpace` preferred
- [ ] No `Colors.*` · no hex · `.withValues(alpha:)` not `.withOpacity()`
- [ ] `REdgeInsets`+`AppSpacing` · `AppRadii.*.r` for radius
- [ ] `FaIcon(FontAwesomeIcons.*)` + `.r` on every size
- [ ] `context.shadows/gradients` — no inline BoxShadow/LinearGradient
- [ ] `AppScaffold` · `pagePath`+`pageName` · no `_Widget` inline · `AppButton`+`isActive`
- [ ] `FormGroup` in `constants/forms/` · `StatusBuilder<T>` in UI
- [ ] `rethrowAsAppException` on DataSource · `runAsResult` on Repository · Mapper for Model→Entity
- [ ] `printC/M/Y` only · no unused imports · package imports · docs updated
- [ ] Date extensions · `ArabicToEnglishDigitsFormatter` on numeric inputs
- [ ] `Assets` class · shimmer/`MainLoadingProgress`/`LoadingDots` for loading
- [ ] `FailedStateWidget`/`EmptyStateWidget` · WebView cleared · entry animations

---

## §29 — FINAL COMPLETION CHECKLIST

All §28 violations clear? Plus: mandatory files listed · docs updated · `generate_app_strings` run · `build_runner` run · `printC/M/Y` used · date extensions · `ArabicToEnglishDigitsFormatter` · `Assets` class · shimmer/loaders · `FailedStateWidget`/`EmptyStateWidget` · WebView cleared · entry animations everywhere · `.withValues(alpha:)` not `.withOpacity()`

---

_This file supersedes all previous documentation. In any conflict, this file wins._
