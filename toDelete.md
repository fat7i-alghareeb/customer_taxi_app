# Stripe Setup — Flutter App (customertaxi)

Delete this file after setup is complete.

---

## Short answer: you barely need to do anything

The Flutter app does **not** store any Stripe keys itself. Everything comes from the backend:

1. The backend reads `Stripe:PublishableKey` from its own config.
2. The Flutter app calls `GET /api/config` at startup via `ClientConfigService`.
3. The response includes `stripeEnabled` and `stripePublishableKey`.
4. `bootstrap.dart` uses those values to call `Stripe.publishableKey = ...` and `Stripe.instance.applySettings()`.

So as long as the **backend** is configured correctly (see [TAXI_SERVER/toDelete.md](../TAXI_SERVER/toDelete.md)), the Flutter app works with no extra changes.

---

## What is already set up in this project

### Android — URL scheme for Stripe redirects

[android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml) already contains:

```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="customertaxi" android:host="stripe-redirect"/>
</intent-filter>
```

This handles the `customertaxi://stripe-redirect` return URL that `booking_handlers.dart` passes to `SetupPaymentSheetParameters`. **Nothing to change.**

### iOS — URL scheme for Stripe redirects

[ios/Runner/Info.plist](ios/Runner/Info.plist) already contains:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLName</key>
    <string>dev.fat7i.customertaxi.stripe</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>customertaxi</string>
    </array>
  </dict>
</array>
```

**Nothing to change.**

### bootstrap.dart — Stripe initialization

`_initializeClientConfig()` in [lib/bootstrap.dart](lib/bootstrap.dart) already does:

```dart
if (config.stripeEnabled && config.stripePublishableKey.isNotEmpty) {
  Stripe.publishableKey = config.stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.dev.fat7i.customertaxi';
  Stripe.urlScheme = 'customertaxi';
  await Stripe.instance.applySettings();
}
```

**Nothing to change.**

---

## The only Flutter-side thing to know: Apple Pay (iOS only, optional)

`Stripe.merchantIdentifier = 'merchant.dev.fat7i.customertaxi'` enables Apple Pay on the Payment Sheet when running on iOS.

If you want Apple Pay to appear:

1. In your Apple Developer account → **Certificates, IDs & Profiles → Identifiers**, find your App ID and enable the **Apple Pay Payment Processing** capability.
2. Create a **Merchant ID** with the value `merchant.dev.fat7i.customertaxi`.
3. In Xcode → project target → **Signing & Capabilities**, add the **Apple Pay** capability and select `merchant.dev.fat7i.customertaxi`.
4. In the Stripe dashboard → **Settings → Payment methods**, enable **Apple Pay** and upload your Apple Pay certificate.

**If you skip this**, the Payment Sheet still works with regular cards. Apple Pay just will not appear as an option on iOS. This is fine for development.

---

## Testing the Payment Sheet

Test card numbers (use these when the Payment Sheet opens):

| Scenario | Card number | Expiry | CVC |
|----------|------------|--------|-----|
| Payment succeeds | `4242 4242 4242 4242` | Any future date | Any 3 digits |
| 3D Secure required | `4000 0025 0000 3155` | Any future date | Any 3 digits |
| Card declined | `4000 0000 0000 9995` | Any future date | Any 3 digits |

For the billing address, any values work in test mode.

---

## Checklist

- [ ] Backend is running with `FeatureFlags:StripeEnabled = true` and a valid `Stripe:PublishableKey`
- [ ] `GET /api/config` returns `{ "stripeEnabled": true, "stripePublishableKey": "pk_test_..." }`
- [ ] App starts and console shows `[Bootstrap] Stripe initialized publishableKey=pk_test_…`
- [ ] Complete a booking and tap "Confirm & Pay" — the Stripe Payment Sheet appears
- [ ] Enter card `4242 4242 4242 4242` and pay — booking succeeds and sheet collapses
- [ ] (Optional) Register Apple Pay merchant if you need Apple Pay on iOS
