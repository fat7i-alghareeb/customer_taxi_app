import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/create_refund_issue_request_model.dart';
import '../../domain/entities/refund_issue_entity.dart';
import '../../domain/entities/refund_issue_request_type.dart';
import '../../domain/facade/refund_issue_facade.dart';

part 'refund_issue_event.dart';
part 'refund_issue_state.dart';
part 'refund_issue_bloc.freezed.dart';

@injectable
class RefundIssueBloc extends Bloc<RefundIssueEvent, RefundIssueState> {
  RefundIssueBloc(this._facade) : super(const RefundIssueState()) {
    on<_ReasonSelected>(_onReasonSelected);
    on<_Submitted>(_onSubmitted);
    on<_ResetSubmission>(_onResetSubmission);
  }

  final RefundIssueFacade _facade;

  void _onReasonSelected(
    _ReasonSelected event,
    Emitter<RefundIssueState> emit,
  ) {
    emit(state.copyWith(selectedType: event.type));
  }

  Future<void> _onSubmitted(
    _Submitted event,
    Emitter<RefundIssueState> emit,
  ) async {
    // The UI hides the button while in flight and after success, but a stray
    // second event (a queued tap, a rebuilt listener) would otherwise fire a
    // duplicate request the server now answers with 409.
    if (state.submitStatus.isLoading || state.submitStatus.isSuccess) {
      printY('[RefundIssueBloc] submit ignored, already in flight or done');
      return;
    }

    emit(state.copyWith(submitStatus: const BlocStatus.loading()));
    final result = await _facade.submitRefundIssue(
      tripId: event.tripId,
      request: CreateRefundIssueRequestModel(
        requestType: event.type,
        customerReason: event.customerReason,
        note: event.note?.trim().isEmpty == true ? null : event.note?.trim(),
      ),
    );

    result.when(
      success: (issue) {
        printG('[RefundIssueBloc] submitted id=${issue.id}');
        emit(state.copyWith(submitStatus: BlocStatus.success(issue)));
      },
      failure: (message) {
        printY('[RefundIssueBloc] submit failed=$message');
        emit(state.copyWith(submitStatus: BlocStatus.failure(message)));
      },
    );
  }

  void _onResetSubmission(
    _ResetSubmission event,
    Emitter<RefundIssueState> emit,
  ) {
    emit(state.copyWith(submitStatus: const BlocStatus.initial()));
  }
}
