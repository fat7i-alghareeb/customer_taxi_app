import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../utils/helpers/app_strings.dart';
import '../../../../utils/helpers/colored_print.dart';

/// Firebase is used ONLY for Google Sign-In now. Phone verification moved to the
/// backend-owned OTP flow (CM.com SMS), so all Firebase phone-auth logic is gone.
@lazySingleton
class AuthFirebaseDataSource {
  AuthFirebaseDataSource(this._firebaseAuth, this._firebaseMessaging);

  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: const ['email']);

  /// Runs the native Google chooser, signs into Firebase with the Google
  /// credential, and returns a fresh Firebase ID token for the backend to verify.
  /// Returns null if the user cancels.
  Future<String?> signInWithGoogle() {
    return rethrowAsAppException(() async {
      try {
        printC('[GoogleAuth] starting Google sign-in');
        // Force the account chooser each time so users can switch accounts.
        await _googleSignIn.signOut();

        final account = await _googleSignIn.signIn();
        if (account == null) {
          printY('[GoogleAuth] user cancelled the chooser');
          return null; // user cancelled
        }
        printG('[GoogleAuth] account chosen: ${account.email}');

        final googleAuth = await account.authentication;
        printY(
          '[GoogleAuth] googleAuth idToken=${googleAuth.idToken != null} '
          'accessToken=${googleAuth.accessToken != null}',
        );

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        printG('[GoogleAuth] firebase signIn ok uid=${userCredential.user?.uid}');

        final idToken = await userCredential.user?.getIdToken(true);
        if (idToken == null || idToken.isEmpty) {
          printR('[GoogleAuth] Firebase ID token missing after sign-in');
          throw const AppException('Could not retrieve Firebase ID token');
        }
        printG('[GoogleAuth] got firebase idToken (len=${idToken.length})');
        return idToken;
      } on AppException {
        rethrow;
      } catch (e, s) {
        // Log the RAW cause before rethrowAsAppException collapses it to "unknown".
        if (e is PlatformException) {
          printR(
            '[GoogleAuth] PlatformException code=${e.code} '
            'message=${e.message} details=${e.details}',
          );
        } else if (e is FirebaseAuthException) {
          printR(
            '[GoogleAuth] FirebaseAuthException code=${e.code} '
            'message=${e.message}',
          );
        } else {
          printR('[GoogleAuth] ${e.runtimeType}: $e');
        }
        printR('[GoogleAuth] stack:\n$s');
        rethrow;
      }
    });
  }

  /// Best-effort FCM device token. Returns null on any failure.
  Future<String?> getFcmToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (_) {
      return null;
    }
  }

  /// Signs the user out of Firebase/Google (used on logout).
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {/* ignore */}
    try {
      await _firebaseAuth.signOut();
    } catch (_) {/* ignore */}
  }

  // ignore: unused_element  (retained for potential Google error mapping)
  AppException _mapError(FirebaseAuthException e) =>
      AppException(e.message ?? AppStrings.somethingWentWrong);
}
