abstract class OrderConstants {
  static const String featureName = 'order';

  static const String carTypeStandard = 'standard';
  static const String carTypeComfort = 'comfort';
  static const String carTypeBus8 = 'bus_8';

  static const double collapsedHeroHeight = 144;
  static const double collapsedHeroImageSize = 148;
  static const double collapsedSheetVerticalPadding = 12;
  static const double collapsedSheetHeight =
      collapsedHeroHeight + (collapsedSheetVerticalPadding * 2);

  static const double mapPickSheetHeight = 160;
  static const double expandedSheetHeightFactor = 0.6;
  static const double expandedVehicleStepBaseHeight = 308;
  static const double expandedVehicleConfirmButtonExtraHeight = 76;
  static const double expandedPickupStepBaseHeight = 360;
  static const double expandedPickupConfirmButtonExtraHeight = 76;
  static const double expandedRouteFitPaddingFactor = 0.24;
  static const double vehicleCardWidth = 240;
  static const double vehicleCardsViewportHeight = 74;
  static const int pickupPointMaxDistanceMeters = 300;

  static const double expandedHeaderHeight = 72;
  static const double mapContextStripHeight = 48;
}
