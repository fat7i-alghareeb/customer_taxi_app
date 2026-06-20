import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/core/theme/app_colors.dart';
import 'package:customertaxi/utils/extensions/theme_extensions.dart';

import '../../../../utils/helpers/app_strings.dart';

enum TripStatus {
  pendingQuote,
  awaitingAdminAcceptance,
  accepted,
  enRoute,
  arrived,
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
      TripStatus.awaitingAdminAcceptance => AppStrings.tripStatusPendingDriver,
      TripStatus.accepted => AppStrings.tripStatusDriverAssigned,
      TripStatus.enRoute => AppStrings.tripStatusDriverEnRoute,
      TripStatus.arrived => AppStrings.tripStatusDriverArrived,
      TripStatus.inProgress => AppStrings.tripStatusInProgress,
      TripStatus.completed => AppStrings.tripStatusCompleted,
      TripStatus.cancelled => AppStrings.tripStatusCancelled,
      TripStatus.awaitingPayment => AppStrings.tripStatusAwaitingPayment,
      TripStatus.paymentFailed => AppStrings.tripStatusPaymentFailed,
      TripStatus.refunded => AppStrings.tripStatusRefunded,
      TripStatus.unknown => AppStrings.tripStatus,
    };
  }

  Color color(BuildContext context) {
    return switch (this) {
      TripStatus.pendingQuote => AppColors.info,
      TripStatus.awaitingAdminAcceptance => Colors.orange,
      TripStatus.accepted => Colors.teal,
      TripStatus.enRoute => Colors.teal,
      TripStatus.arrived => Colors.green,
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
      TripStatus.awaitingAdminAcceptance => FontAwesomeIcons.calendarDays,
      TripStatus.accepted => FontAwesomeIcons.circleCheck,
      TripStatus.enRoute => FontAwesomeIcons.carSide,
      TripStatus.arrived => FontAwesomeIcons.circleCheck,
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
      this == TripStatus.awaitingPayment ||
      this == TripStatus.awaitingAdminAcceptance ||
      this == TripStatus.accepted ||
      this == TripStatus.enRoute ||
      this == TripStatus.arrived;

  static TripStatus fromString(String? value) {
    final normalized = value
        ?.trim()
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll(' ', '');

    return switch (normalized) {
      'pendingquote' => TripStatus.pendingQuote,
      'awaitingadminacceptance' ||
      'scheduled' ||
      'pendingdriver' ||
      'findingdriver' => TripStatus.awaitingAdminAcceptance,
      'accepted' || 'driverassigned' => TripStatus.accepted,
      'enroute' || 'driverenroute' => TripStatus.enRoute,
      'arrived' ||
      'driverarrived' ||
      'driverassignedarrived' => TripStatus.arrived,
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
