import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:energy_dashboard/amplifyconfiguration.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/domain/abstractions/auth_repository_abstraction.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Repository for user management
///
/// Contains all necessary amplify methods
/// to manage the user and its authentication
class AuthRepository extends AuthRepositoryAbstraction{

  /// Init

  @override
  Future<void> initAmplify() async{
    try{
      final authPlugin = AmplifyAuthCognito();
      await Amplify.addPlugin(authPlugin);

      await Amplify.configure(amplifyconfig);
      safePrint('aws successfully initialized!');
    } on Exception catch(e){
      safePrint('An error occurred configuring Amplify: $e');
    }
  }


  /// Registration

  @override
  Future<bool> signUpUser({
    required String email,
    required String password,
  }) async {
    safePrint('username: $email');
    safePrint('password: $password');
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      final authSignUpStep = await _handleSignUpResult(result);
      return authSignUpStep == AuthSignUpStep.done || authSignUpStep == AuthSignUpStep.confirmSignUp;
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      return false;
    }
  }

  Future<AuthSignUpStep> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
    return result.nextStep.signUpStep;
  }

  @override
  Future<bool> confirmUser({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result);
      return true;
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      return false;
    }
  }



  /// Sign in/out

  @override
  Future<bool> signInUser(String email, String password) async {
    try {
      final signIn = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      final result = await _handleSignInResult(signIn, email);
      return result == AuthSignInStep.done;
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
      return false;
    }
  }


  Future<AuthSignInStep> _handleSignInResult(SignInResult result, String email) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      case AuthSignInStep.resetPassword:
        final resetResult = await Amplify.Auth.resetPassword(
          username: email,
        );
        await _handleResetPasswordResult(resetResult);
        break;
      case AuthSignInStep.confirmSignUp:
      // Resend the sign up code to the registered device.
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: email,
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);
        break;
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
      case AuthSignInStep.continueSignInWithMfaSelection:
        safePrint('continueSignInWithMfaSelection no action');
        break;
      case AuthSignInStep.continueSignInWithTotpSetup:
        safePrint('continueSignInWithTotpSetup no action');
        break;
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
        safePrint('confirmSignInWithTotpMfaCode no action');
        break;
    }
    return result.nextStep.signInStep;
  }

  @override
  Future<bool> isUserSignedIn() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      safePrint('User is signed in: ${result.isSignedIn}');
      return result.isSignedIn;
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
      return false;
    }
  }

  @override
  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  Future<void> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final identityId = result.identityIdResult.value;
      safePrint("Current user's identity ID: $identityId");
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<String?> getUserEmail() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      return result.firstWhere((u) => u.userAttributeKey == AuthUserAttributeKey.email).value;
    } on AuthException catch (e) {
      safePrint('Error fetching user email: ${e.message}');
      return null;
    }
  }

  @override
  Future<bool> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
      return true;
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
      return false;
    }
    return false;
  }


  /// Reset Password

  @override
  Future<bool> resetPassword(String email) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: email,
      );
      await _handleResetPasswordResult(result);
      return true;
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}, username: $email');
      return false;
    }
  }

  @override
  Future<bool> confirmResetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
      return true;
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      return false;
    }
  }

  Future<AuthResetPasswordStep> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthResetPasswordStep.done:
        safePrint('Successfully reset password');
        break;
    }
    return result.nextStep.updateStep;
  }


  @override
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      safePrint('Password updated successfully: $newPassword');
      return true;
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
      return false;
    }
  }


  /// Other

  @override
  Future<bool> updateUserEmail({
    required String newEmail,
  }) async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        value: newEmail,
      );
      _handleUpdateUserAttributeResult(result);
      return false;
    } on AuthException catch (e) {
      safePrint('[updateUserEmail] Error updating user attribute: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> updateUsername({
    required String newEmail
  }) async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.preferredUsername,
        value: newEmail,
      );
      final authUpdateResult = _handleUpdateUserAttributeResult(result);
      if(authUpdateResult == AuthUpdateAttributeStep.done){
        return true;
      }
      return false;
    } on AuthException catch (e) {
      safePrint('[_updateUsername] Error updating user attribute: ${e.message}');
      return false;
    }
  }

  AuthUpdateAttributeStep _handleUpdateUserAttributeResult(
      UpdateUserAttributeResult result,
      ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        safePrint('Successfully updated attribute');
        break;
    }
    return result.nextStep.updateAttributeStep;
  }

  @override
  Future<bool> verifyEmailUpdate({
    required String newEmail,
    required String confirmationCode
  }) async {
    try {
      await Amplify.Auth.confirmUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        confirmationCode: confirmationCode,
      );
      // update username as well
      final usernameResult = await updateUsername(newEmail: newEmail);
      safePrint('username updated ($newEmail): $usernameResult');
      return usernameResult;
    } on AuthException catch (e) {
      safePrint('Error confirming email update: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await Amplify.Auth.deleteUser();
      safePrint('Delete user succeeded');
    } on AuthException catch (e) {
      safePrint('Delete user failed with error: $e');
    }
  }


  /// First use

  @override
  Future<bool> isFirstUse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(Constants.kSharedPrefFirstUseKey)){
      return prefs.getBool(Constants.kSharedPrefFirstUseKey)!;
    }
    return true;
  }

  @override
  Future<void> setFirstUse(bool firstUse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool(Constants.kSharedPrefFirstUseKey) != firstUse){
      prefs.setBool(Constants.kSharedPrefFirstUseKey, firstUse);
    }
  }


  /// Verification code

  @override
  Future<bool> resendVerificationCode() async {
    try {
      final result = await Amplify.Auth.sendUserAttributeVerificationCode(
        userAttributeKey: AuthUserAttributeKey.email,
      );
      _handleCodeDelivery(result.codeDeliveryDetails);
      return true;
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> resendSignUpCode(String email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);
      safePrint('Confirmation code resent successfully.');
      return true;
    } on AuthException catch (e) {
      safePrint('Error resending confirmation code: ${e.message}');
      return false;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

}