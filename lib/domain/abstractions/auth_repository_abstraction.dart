import 'package:amplify_flutter/amplify_flutter.dart';


abstract class AuthRepositoryAbstraction {

  /// Init

  Future<void> initAmplify();

  /// Registration

  Future<void> signUpUser({required String email, required String password});

  Future<void> confirmUser({required String email, required String confirmationCode});

  /// Login

  Future<bool> signInUser(String email, String password);

  Future<bool> isUserSignedIn();

  Future<AuthUser> getCurrentUser();

  Future<bool> signOutCurrentUser();

  /// Update attributes

  Future<bool> updateUserEmail({required String newEmail});

  Future<bool> verifyEmailUpdate({required String newEmail, required String confirmationCode});

  Future<bool> updateUsername({required String newEmail});

  Future<bool> resetPassword(String email);

  Future<bool> confirmResetPassword({required String email, required String newPassword, required String confirmationCode});

  Future<bool> updatePassword({required String oldPassword, required String newPassword});

  /// First use

  Future<bool> isFirstUse();

  Future<void> setFirstUse(bool firstUse);

  /// Others

  Future<bool> resendVerificationCode();

  Future<bool> resendSignUpCode(String email);

  Future<void> deleteUser();

}