import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/core/theme/app_colors.dart';

import '../../../../utils/helpers/app_strings.dart';

/// Customer-facing refund outcome for a trip, mapped from the backend's
/// simplified refund status (see TripRefundDtoMapper on the server).
/// Intentionally coarse — success / in-progress / failed — with no reason.
enum TripRefundStatus {
  completed('Completed'),
  processing('Processing'),
  failed('Failed'),
  cancelled('Cancelled'),

  /// Synthesized client-side only (never sent by the backend): a cancellation
  /// with an owed policy amount exists but no refund record has been created
  /// yet. Keeps the customer informed without over-promising an active refund.
  preparing('Preparing'),
  unknown('');

  const TripRefundStatus(this.apiValue);
  final String apiValue;

  String get title => switch (this) {
    TripRefundStatus.completed => AppStrings.tripRefundStatusCompleted,
    TripRefundStatus.processing => AppStrings.tripRefundStatusProcessing,
    TripRefundStatus.failed => AppStrings.tripRefundStatusFailed,
    TripRefundStatus.cancelled => AppStrings.tripRefundStatusCancelled,
    TripRefundStatus.preparing => AppStrings.tripRefundStatusPreparing,
    TripRefundStatus.unknown => AppStrings.notAvailable,
  };

  String get description => switch (this) {
    TripRefundStatus.completed => AppStrings.tripRefundStatusCompletedDesc,
    TripRefundStatus.processing => AppStrings.tripRefundStatusProcessingDesc,
    TripRefundStatus.failed => AppStrings.tripRefundStatusFailedDesc,
    TripRefundStatus.cancelled => AppStrings.tripRefundStatusCancelledDesc,
    TripRefundStatus.preparing => AppStrings.tripRefundStatusPreparingDesc,
    TripRefundStatus.unknown => AppStrings.notAvailable,
  };

  /// The in-flight states share the trip accent: to the rider, "wordt
  /// voorbereid" and "loopt" are one continuous stage — money on its way — and
  /// they already read apart by icon and title. Only the terminal outcomes keep
  /// green and red, which carry meaning no brand colour should overwrite.
  Color get color => switch (this) {
    TripRefundStatus.completed => AppColors.success,
    TripRefundStatus.processing => AppColors.tripOrange,
    TripRefundStatus.failed => AppColors.error,
    TripRefundStatus.cancelled => Colors.grey,
    TripRefundStatus.preparing => AppColors.tripOrange,
    TripRefundStatus.unknown => Colors.grey,
  };

  FaIconData get icon => switch (this) {
    TripRefundStatus.completed => FontAwesomeIcons.solidCircleCheck,
    TripRefundStatus.processing => FontAwesomeIcons.clockRotateLeft,
    TripRefundStatus.failed => FontAwesomeIcons.circleXmark,
    TripRefundStatus.cancelled => FontAwesomeIcons.ban,
    TripRefundStatus.preparing => FontAwesomeIcons.hourglassHalf,
    TripRefundStatus.unknown => FontAwesomeIcons.question,
  };

  static TripRefundStatus fromString(String? value) {
    final normalized = value?.trim().toLowerCase();
    return switch (normalized) {
      'completed' || 'succeeded' => TripRefundStatus.completed,
      'processing' ||
      'pending' ||
      'requested' ||
      'retrying' => TripRefundStatus.processing,
      'failed' || 'permanentlyfailed' => TripRefundStatus.failed,
      'cancelled' || 'canceled' => TripRefundStatus.cancelled,
      _ => TripRefundStatus.unknown,
    };
  }
}
