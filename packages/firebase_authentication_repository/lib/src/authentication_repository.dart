import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  ///The associated error message.
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unkown exception occurred.',
  ]);

  /// Create an authentication message
  /// form a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromcode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          "Email is not valid or badly formatted. ",
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This User has been disable. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          "operation is not allowed. please contact support.",
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          "Please enter a stronger password.",
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}

class LogInWithGoogleFailure implements Exception {
  final String message;

  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  ///Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
            'Account exists with different credentials.');
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed. please contact support.',
        );
      case 'user-disable':
        return const LogInWithGoogleFailure(
          'This user has been disabled. please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create and account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please create an account.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );

      default:
        return const LogInWithGoogleFailure();
    }
  }
}

///Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  final CacheClient _cache;

}
