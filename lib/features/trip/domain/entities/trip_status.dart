import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/utils/extensions/theme_extensions.dart';

import '../../../../utils/helpers/app_strings.dart';

enum TripStatus {
  scheduled,
  pendingDriver,
  driverAssigned,
  driverEnRoute,
  driverArrived,
  inProgress,
  completed,
  cancelled,
  unknown;

  String get title {
    return switch (this) {
      TripStatus.scheduled => AppStrings.tripStatusScheduled,
      TripStatus.pendingDriver => AppStrings.tripStatusPendingDriver,
      TripStatus.driverAssigned => AppStrings.tripStatusDriverAssigned,
      TripStatus.driverEnRoute => AppStrings.tripStatusDriverEnRoute,
      TripStatus.driverArrived => AppStrings.tripStatusDriverArrived,
      TripStatus.inProgress => AppStrings.tripStatusInProgress,
      TripStatus.completed => AppStrings.tripStatusCompleted,
      TripStatus.cancelled => AppStrings.tripStatusCancelled,
      TripStatus.unknown => 'Unknown',
    };
  }

  Color color(BuildContext context) {
    return switch (this) {
      TripStatus.scheduled => Colors.orange,
      TripStatus.pendingDriver => Colors.blue,
      TripStatus.driverAssigned => Colors.teal,
      TripStatus.driverEnRoute => Colors.teal,
      TripStatus.driverArrived => Colors.green,
      TripStatus.inProgress => context.primary,
      TripStatus.completed => Colors.green,
      TripStatus.cancelled => context.error,
      TripStatus.unknown => Colors.grey,
    };
  }

  IconData get icon {
    return switch (this) {
      TripStatus.scheduled => FontAwesomeIcons.calendarDays,
      TripStatus.pendingDriver => FontAwesomeIcons.magnifyingGlassLocation,
      TripStatus.driverAssigned => FontAwesomeIcons.carSide,
      TripStatus.driverEnRoute => FontAwesomeIcons.carSide,
      TripStatus.driverArrived => FontAwesomeIcons.circleCheck,
      TripStatus.inProgress => FontAwesomeIcons.route,
      TripStatus.completed => FontAwesomeIcons.checkDouble,
      TripStatus.cancelled => FontAwesomeIcons.circleXmark,
      TripStatus.unknown => FontAwesomeIcons.question,
    };
  }

  bool get isTerminal =>
      this == TripStatus.completed || this == TripStatus.cancelled;

  bool get canCancel =>
      this == TripStatus.scheduled ||
      this == TripStatus.pendingDriver ||
      this == TripStatus.driverAssigned ||
      this == TripStatus.driverEnRoute ||
      this == TripStatus.driverArrived;

  static TripStatus fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'scheduled' => TripStatus.scheduled,
      'pendingdriver' ||
      'pending_driver' ||
      'findingdriver' => TripStatus.pendingDriver,
      'driverassigned' || 'driver_assigned' => TripStatus.driverAssigned,
      'driverenroute' || 'driver_en_route' => TripStatus.driverEnRoute,
      'driverarrived' || 'driver_assigned_arrived' || 'driver_arrived' => TripStatus.driverArrived,
      'inprogress' || 'in_progress' => TripStatus.inProgress,
      'completed' => TripStatus.completed,
      'cancelled' => TripStatus.cancelled,
      _ => TripStatus.unknown,
    };
  }
}
