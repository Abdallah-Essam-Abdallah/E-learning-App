import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/features/authentication/data/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exception.dart';

abstract class AuthenticationDataSource {
  Future<void> signUp(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> verifyEmail();
  Future<void> resetPassword({required String email});
  Future<void> createUserInDatabase({
    required String userName,
    required String email,
    required String phoneNumber,
    required String userId,
    String? image,
  });
  Future<User?> signInWithGoogle();
  Future<void> signInWithFacebook();
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthenticationDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
      }
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user!.email);
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'too-many-requests':
          throw TooManyRequestsException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-not-found':
          throw UserNotFoundException();
      }
    }
  }

  @override
  Future<void> createUserInDatabase({
    required String userName,
    required String email,
    required String phoneNumber,
    required String userId,
    String? image,
  }) async {
      UserModel model = UserModel(
      image: image,
      userName: userName,
      userId: userId,
      email: email,
      phoneNumber: phoneNumber,
    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(model.toJson());
    } catch (e) {
      throw GetUserDataException();
    }
  }

  @override
  Future<void> verifyEmail() async {
    try {
      bool isEmailVerified = false;
      isEmailVerified = firebaseAuth.currentUser!.emailVerified;
      if (!isEmailVerified) {
        final user = firebaseAuth.currentUser!;
        await user.sendEmailVerification();
      }
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw ResetPasswordException();
    }
  }

  @override
  Future<void> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithGoogle() async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
        await createUserInDatabase(
            userName: user!.displayName ?? '',
            email: user.email ?? '',
            phoneNumber: user.phoneNumber ?? '',
            userId: user.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          throw AccountExistsWithDifferentCredentialException();
        } else if (e.code == 'invalid-credential') {
          throw InvalidCredentialException();
        }
      } catch (e) {
        throw SignInWithGoogleException();
      }
    }

    return user!;
  }
}
