import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../network/api_endpoints.dart';
import '../../../utils/helpers/colored_print.dart';

/// Fetches and caches the admin-editable support contact used by the in-trip
/// "Report problem" action. Falls back to a hardcoded WhatsApp number when the
/// server has none configured or the request fails, so the action always works.
@singleton
class SupportContactService {
  SupportContactService(this._dio);

  final Dio _dio;

  /// Fallback used when the server returns no number (or is unreachable).
  static const String fallbackWhatsApp = '31639550352';

  String _whatsApp = fallbackWhatsApp;

  /// The WhatsApp number (digits only, no '+') to open via wa.me.
  String get whatsApp => _whatsApp;

  Future<void> fetch() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.supportContact,
      );
      final raw = (response.data?['whatsApp'] as String?)?.trim();
      if (raw != null && raw.isNotEmpty) {
        _whatsApp = _normalize(raw);
        printG('[SupportContactService] fetched whatsApp=$_whatsApp');
      } else {
        printY('[SupportContactService] empty number — using fallback');
      }
    } catch (e) {
      printY('[SupportContactService] fetch failed: $e — using fallback');
    }
  }

  /// wa.me expects an international number without '+', spaces, or dashes.
  String _normalize(String value) =>
      value.replaceAll(RegExp(r'[^0-9]'), '');
}
