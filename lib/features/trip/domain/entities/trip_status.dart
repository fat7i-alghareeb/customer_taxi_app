import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/core/theme/app_colors.dart';
import 'package:customertaxi/utils/extensions/theme_extensions.dart';

import '../../../../utils/helpers/app_strings.dart';

enum TripStatus {
  pendingQuote,
  scheduled,
  pendingDriver,
  driverAssigned,
  driverEnRoute,
  driverArrived,
  inProgress,
  completed,
  cancelled,
  awaitingPayment,
  paymentFailed,
  refunded,
  unknown;

  String get title {
    return switch (this) {
      TripStatus.pendingQuote => AppStrings.tripStatusPendingQuote,
      TripStatus.scheduled => AppStrings.tripStatusScheduled,
      TripStatus.pendingDriver => AppStrings.tripStatusPendingDriver,
      TripStatus.driverAssigned => AppStrings.tripStatusDriverAssigned,
      TripStatus.driverEnRoute => AppStrings.tripStatusDriverEnRoute,
      TripStatus.driverArrived => AppStrings.tripStatusDriverArrived,
      TripStatus.inProgress => AppStrings.tripStatusInProgress,
      TripStatus.completed => AppStrings.tripStatusCompleted,
      TripStatus.cancelled => AppStrings.tripStatusCancelled,
      TripStatus.awaitingPayment => AppStrings.tripStatusAwaitingPayment,
      TripStatus.paymentFailed => AppStrings.tripStatusPaymentFailed,
      TripStatus.refunded => AppStrings.tripStatusRefunded,
      TripStatus.unknown => 'Unknown',
    };
  }

  Color color(BuildContext context) {
    return switch (this) {
      TripStatus.pendingQuote => AppColors.info,
      TripStatus.scheduled => Colors.orange,
      TripStatus.pendingDriver => Colors.blue,
      TripStatus.driverAssigned => Colors.teal,
      TripStatus.driverEnRoute => Colors.teal,
      TripStatus.driverArrived => Colors.green,
      TripStatus.inProgress => context.primary,
      TripStatus.completed => Colors.green,
      TripStatus.cancelled => context.error,
      TripStatus.awaitingPayment => AppColors.warning,
      TripStatus.paymentFailed => AppColors.error,
      TripStatus.refunded => AppColors.success,
      TripStatus.unknown => Colors.grey,
    };
  }

  FaIconData get icon {
    return switch (this) {
      TripStatus.pendingQuote => FontAwesomeIcons.fileInvoiceDollar,
      TripStatus.scheduled => FontAwesomeIcons.calendarDays,
      TripStatus.pendingDriver => FontAwesomeIcons.magnifyingGlassLocation,
      TripStatus.driverAssigned => FontAwesomeIcons.carSide,
      TripStatus.driverEnRoute => FontAwesomeIcons.carSide,
      TripStatus.driverArrived => FontAwesomeIcons.circleCheck,
      TripStatus.inProgress => FontAwesomeIcons.route,
      TripStatus.completed => FontAwesomeIcons.checkDouble,
      TripStatus.cancelled => FontAwesomeIcons.circleXmark,
      TripStatus.awaitingPayment => FontAwesomeIcons.creditCard,
      TripStatus.paymentFailed => FontAwesomeIcons.triangleExclamation,
      TripStatus.refunded => FontAwesomeIcons.rotateLeft,
      TripStatus.unknown => FontAwesomeIcons.question,
    };
  }

  bool get isTerminal =>
      this == TripStatus.completed ||
      this == TripStatus.cancelled ||
      this == TripStatus.paymentFailed ||
      this == TripStatus.refunded;

  bool get canCancel =>
      this == TripStatus.scheduled ||
      this == TripStatus.awaitingPayment ||
      this == TripStatus.pendingDriver ||
      this == TripStatus.driverAssigned ||
      this == TripStatus.driverEnRoute ||
      this == TripStatus.driverArrived;

  static TripStatus fromString(String? value) {
    final normalized = value
        ?.trim()
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll(' ', '');

    return switch (normalized) {
      'pendingquote' => TripStatus.pendingQuote,
      'scheduled' => TripStatus.scheduled,
      'pendingdriver' || 'findingdriver' => TripStatus.pendingDriver,
      'driverassigned' => TripStatus.driverAssigned,
      'driverenroute' => TripStatus.driverEnRoute,
      'driverarrived' || 'driverassignedarrived' => TripStatus.driverArrived,
      'inprogress' => TripStatus.inProgress,
      'completed' => TripStatus.completed,
      'cancelled' || 'canceled' => TripStatus.cancelled,
      'awaitingpayment' => TripStatus.awaitingPayment,
      'paymentfailed' => TripStatus.paymentFailed,
      'refunded' => TripStatus.refunded,
      _ => TripStatus.unknown,
    };
  }
}
