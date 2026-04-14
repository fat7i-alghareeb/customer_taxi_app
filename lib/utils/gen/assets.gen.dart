// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/legacy_logo.png
  AssetGenImage get legacyLogo =>
      const AssetGenImage('assets/images/legacy_logo.png');

  /// File path: assets/images/logo_launcher.png
  AssetGenImage get logoLauncher =>
      const AssetGenImage('assets/images/logo_launcher.png');

  /// File path: assets/images/onboarding_1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.png');

  /// File path: assets/images/onboarding_2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding_2.png');

  /// File path: assets/images/onboarding_3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.png');

  /// File path: assets/images/order_now_car.png
  AssetGenImage get orderNowCar =>
      const AssetGenImage('assets/images/order_now_car.png');

  /// File path: assets/images/splash_dark.png
  AssetGenImage get splashDark =>
      const AssetGenImage('assets/images/splash_dark.png');

  /// File path: assets/images/splash_light.png
  AssetGenImage get splashLight =>
      const AssetGenImage('assets/images/splash_light.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    legacyLogo,
    logoLauncher,
    onboarding1,
    onboarding2,
    onboarding3,
    orderNowCar,
    splashDark,
    splashLight,
  ];
}

class $AssetsL10nGen {
  const $AssetsL10nGen();

  /// File path: assets/l10n/ar.json
  String get ar => 'assets/l10n/ar.json';

  /// File path: assets/l10n/en.json
  String get en => 'assets/l10n/en.json';

  /// File path: assets/l10n/nl.json
  String get nl => 'assets/l10n/nl.json';

  /// List of all assets
  List<String> get values => [ar, en, nl];
}

class $AssetsSvgIconsGen {
  const $AssetsSvgIconsGen();

  /// File path: assets/svgIcons/home.svg
  String get home => 'assets/svgIcons/home.svg';

  /// List of all assets
  List<String> get values => [home];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsL10nGen l10n = $AssetsL10nGen();
  static const $AssetsSvgIconsGen svgIcons = $AssetsSvgIconsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
