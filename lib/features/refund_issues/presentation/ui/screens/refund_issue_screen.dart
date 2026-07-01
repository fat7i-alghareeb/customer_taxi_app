import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_refund_status.dart';

import '../../../constants/forms/refund_issue_forms.dart';
import '../../states/refund_issue_bloc.dart';
import '../widgets/refund_issue_body.dart';

class RefundIssueScreenArgs {
  const RefundIssueScreenArgs({
    required this.tripId,
    required this.referenceCode,
    required this.refundAmount,
    required this.currencyCode,
    required this.refundPercent,
    required this.fromLabel,
    required this.toLabel,
    this.cancelledAtUtc,
    this.refundStatus = TripRefundStatus.preparing,
    this.knownFailedRefund = false,
  });

  final String tripId;
  final String referenceCode;
  final double refundAmount;
  final String currencyCode;
  final double refundPercent;
  final String fromLabel;
  final String toLabel;
  final DateTime? cancelledAtUtc;
  final TripRefundStatus refundStatus;
  final bool knownFailedRefund;
}

class RefundIssueScreen extends StatefulWidget {
  const RefundIssueScreen({super.key, required this.args});

  static const String pagePath = '/refund_issue';
  static const String pageName = 'RefundIssueScreen';

  final RefundIssueScreenArgs args;

  @override
  State<RefundIssueScreen> createState() => _RefundIssueScreenState();
}

class _RefundIssueScreenState extends State<RefundIssueScreen> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = RefundIssueForms.formGroup();
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RefundIssueBloc>(
      create: (_) => getIt<RefundIssueBloc>(),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.refundIssueTitle,
        ),
        bottomNavigationBar: RefundIssueBottomAction(
          args: widget.args,
          form: _form,
        ),
        child: RefundIssueBody(args: widget.args, form: _form),
      ),
    );
  }
}
