import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:snapmap/core/error/exception.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signupWithEmail({
    required String email,
    required String password,
    required String name,
  });
  Future<UserModel> signinWithEmail({
    required String email,
    required String password,
  });
  Future<void> signout();
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithGoogle();

  // New biometric
  Future<bool> isBiometricAvailable();
  Future<bool> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  });
  Future<void> forgotPassword(String email);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  final LocalAuthentication localAuth;

  AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.localAuth,
    required this.firestore,
  });
  @override
  Future<UserModel> signupWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCreds = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCreds);
      if (userCreds.user == null) throw AuthException("Sign up failed");
      await userCreds.user!.updateDisplayName(name);
      await userCreds.user!.reload();
      final updatedUser = firebaseAuth.currentUser!;
      await firestore.collection('users').doc(updatedUser.uid).set({
        'uid': updatedUser.uid,
        'email': updatedUser.email,
        'name': updatedUser.displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'onboardingComplete': false,
      });
      return UserModel.fromFirebaseUser(updatedUser);
    } on FirebaseException catch (e) {
      print(e);
      throw AuthException(e.message ?? "Signup failed");
    } catch (e) {
      print(e);

      throw AuthException("An unexpected error occured");
    }
  }

  @override
  Future<UserModel> signinWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCreds = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCreds.user == null) throw AuthException("Sign in failed");

      return UserModel.fromFirebaseUser(userCreds.user!);
    } on FirebaseException catch (e) {
      print(e);

      throw AuthException(e.message ?? "Signin failed");
    } catch (error) {
      print(error);

      throw (AuthFailure("An unexpected error occured"));
    }
  }

  @override
  Future<void> signout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      throw AuthException(e.message ?? "Signout failed");
    } catch (e) {
      throw AuthException("An unexpected error occurred.");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      // final user = firebaseAuth.currentUser;
      final user = await firebaseAuth.authStateChanges().first;
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? "Couldn't get current user");
    } catch (e) {
      throw (AuthFailure("An unexpected error occured"));
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;
      if (idToken == null) throw AuthException("Sign in failed");

      final userCreds = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: idToken),
      );
      if (userCreds.user == null) throw AuthException("Sign in failed");
      await firestore.collection('users').doc(userCreds.user!.uid).set({
        'uid': userCreds.user!.uid,
        'email': userCreds.user!.email,
        'name': userCreds.user!.displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'onboardingComplete': false,
      }, SetOptions(merge: true));
      return UserModel.fromFirebaseUser(userCreds.user!);
    } on FirebaseAuthException catch (e) {
      print(e);

      throw AuthException(e.message ?? "firebase auth error");
    } catch (e) {
      print(e);

      throw (AuthFailure("An unexpected error occured"));
    }
  }

  @override
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await localAuth.canCheckBiometrics;
      final isDeviceSupported = await localAuth.isDeviceSupported();
      final enrolled = await localAuth.getAvailableBiometrics();
      return canCheck && isDeviceSupported && enrolled.isNotEmpty;
    } catch (e) {
      print(e);

      return false;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // e.g. user-not-found, invalid-email, too-many-requests
      throw AuthException(e.message ?? 'Password reset failed');
    } catch (e) {
      print(e);
      throw AuthException("An unexpected error occurred");
    }
  }

  @override
  Future<bool> authenticateWithBiometric({
    required String reason,
    required bool useDevicePasscode,
  }) async {
    try {
      return await localAuth.authenticate(
        localizedReason: reason,
        persistAcrossBackgrounding: true,
        biometricOnly: false,
      );
    } on LocalAuthException catch (e) {
      print('[BIOMETRIC] ${e.code} - $e');
      if (e.code == LocalAuthExceptionCode.userCanceled ||
          e.code == LocalAuthExceptionCode.systemCanceled ||
          e.code == LocalAuthExceptionCode.noCredentialsSet) {
        return false; // user explicitly cancelled
      }
      rethrow; // real error → Left(failure) in bloc
    } catch (e) {
      rethrow;
    }
  }
}
