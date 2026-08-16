import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/helpers/colored_print.dart';
import '../../utils/helpers/release_log.dart';
import '../network/interceptors/error_interceptor.dart';
import '../utils/result.dart';
import 'app_exception.dart';

/// Runs [action] and wraps the result into a [Result].
///
/// Usage in repositories:
/// ```dart
/// Future<Result<User>> login(...) {
///   return runAsResult(() => _remote.login(...));
/// }
/// ```
Future<Result<T>> runAsResult<T>(FutureOr<T> Function() action) async {
  try {
    final value = await action();
    return Result.success(value);
  } on AppException catch (e) {
    return Result.failure(e.message);
  } on DioException catch (e) {
    // Normally ErrorInterceptor has already converted the error to an
    // AppException via `err.error`. It can be bypassed though — an earlier
    // interceptor (the refresh-token one) may reject first — so map it here
    // rather than degrading to "Unknown error".
    final appEx =
        e.error is AppException ? e.error as AppException : ErrorInterceptor.mapDioError(e);
    return Result.failure(appEx.message);
  } catch (e, s) {
    printR('runAsResult unexpected error: $e');
    logAlways('runAsResult unexpected error', error: e, stackTrace: s);
    return Result.failure(
      AppException.unknown(cause: e, stackTrace: s).message,
    );
  }
}

/// Runs [action] and rethrows errors as [AppException].
///
/// Intended for remote data sources which want to bubble errors up to
/// repositories, where they will be converted into [Result] via
/// [runAsResult].
Future<T> rethrowAsAppException<T>(FutureOr<T> Function() action) async {
  try {
    return await action();
  } on AppException {
    rethrow;
  } on DioException catch (e) {
    if (e.error is AppException) {
      throw e.error!;
    }
    throw ErrorInterceptor.mapDioError(e);
  } catch (e, s) {
    logAlways('rethrowAsAppException unexpected error', error: e, stackTrace: s);
    throw AppException.unknown(cause: e, stackTrace: s);
  }
}

/// Runs [action] and returns an [AppException] instead of throwing.
///
/// Usage example:
/// ```dart
/// final error = await runAndReturnError(() => _remoteCall());
/// if (error != null) {
///   // show error.message in UI
/// }
/// ```
Future<AppException?> runAndReturnError<T>(
  FutureOr<T> Function() action,
) async {
  try {
    await action();
    return null;
  } on AppException catch (e) {
    return e;
  } on DioException catch (e) {
    if (e.error is AppException) {
      return e.error as AppException;
    }
    printR('runAndReturnError DioException: $e');
    return ErrorInterceptor.mapDioError(e);
  } catch (e, s) {
    printR('runAndReturnError unexpected error: $e');
    logAlways('runAndReturnError unexpected error', error: e, stackTrace: s);
    return AppException.unknown(cause: e, stackTrace: s);
  }
}
