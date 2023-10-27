import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

/// Service for the Password reset process
///
/// Handles all pw reset functionalities
class PasswordService extends ChangeNotifier {
  PasswordService() {
    // Initialize controllers, focus nodes, and value notifiers
    emailController = TextEditingController()..addListener(_emailListener);
    passwordController = TextEditingController()..addListener(_passwordListener);
    passwordRepeatController = TextEditingController()..addListener(_passwordRepeatListener);
    emailErrorText = null;
    passwordErrorText = null;
    passwordRepeatErrorText = null;
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordRepeatFocusNode = FocusNode();
    isLoading = ValueNotifier(false);
  }

  // Controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordRepeatController;

  // Error texts
  late String? emailErrorText;
  late String? passwordErrorText;
  late String? passwordRepeatErrorText;

  // Focus nodes
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode passwordRepeatFocusNode;

  // button state
  late ValueNotifier<bool> isLoading;

  @override
  dispose() {
    // Dispose of controllers, focus nodes, and value notifiers
    emailController.removeListener(_emailListener);
    emailController.dispose();
    passwordController.removeListener(_passwordListener);
    passwordController.dispose();
    passwordRepeatController.removeListener(_passwordRepeatListener);
    passwordRepeatController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  // Listeners

  _emailListener(){
    // remove error text on valid email
    if(emailFocusNode.hasFocus){
      if(emailErrorText != null){
        if(AuthUtils().isValidEmail(emailController.text)){
          emailErrorText = null;
          notifyListeners();
        }
      }
    }
  }

  _passwordListener(){
    // remove error text on valid password
    if(passwordFocusNode.hasFocus){
      if(passwordErrorText != null){
        if(AuthUtils().isValidPassword(passwordController.text)){
          passwordErrorText = null;
          notifyListeners();
        }
      }
    }
  }

  _passwordRepeatListener(){
    // remove error text on valid password
    if(passwordRepeatFocusNode.hasFocus){
      if(passwordRepeatErrorText != null){
        if(passwordController.text == passwordRepeatController.text){
          passwordRepeatErrorText = null;
          notifyListeners();
        }
      }
    }
  }


  // Reset the password with email confirmation
  Future<void> resetPassword(BuildContext context) async {
    if(!AuthUtils().isValidEmail(emailController.text)){
      emailErrorText = Translations.of(context)!.text('textfield.error.invalid-email');
      notifyListeners();
    }else{
      isLoading.value = true;
      await GetIt.I.get<AuthRepository>().resetPassword(emailController.text).then((success) {
        if(success){
          Navigation.goToPwResetConfirmation();
        }else{
          FlashMessageFactory.showFlashMessage(
            context: context,
            type: FlashMessageType.error,
            title: Translations.of(context)!.text('snackbar.password-reset.failure')
          );
        }
      });
      isLoading.value = false;
    }
  }

  // Set a new password after receiving a code
  Future<void> setNewPassword(String code, BuildContext context) async {
    if(passwordErrorText != null || passwordRepeatErrorText != null){
      return;
    }
    if(!AuthUtils().isValidPassword(passwordController.text)){
      passwordErrorText = Translations.of(context)!.text('textfield.error.password-policy');
      notifyListeners();
      return;
    }
    if(passwordController.text != passwordRepeatController.text){
      passwordRepeatErrorText = Translations.of(context)!.text('textfield.error.mismatched-passwords');
      notifyListeners();
      return;
    }

    isLoading.value = true;
    await GetIt.I.get<AuthRepository>().confirmResetPassword(
      email: emailController.text,
      newPassword: passwordController.text,
      confirmationCode: code,
    ).then((success){
      isLoading.value = false;
      if(success){
        Navigation.goToLogin();
        clear();
        FlashMessageFactory.showFlashMessage(
          context: context,
          type: FlashMessageType.success,
          title: Translations.of(context)!.text('snackbar.password-reset.success')
        );
      }else{
        FlashMessageFactory.showFlashMessage(
          context: context,
          type: FlashMessageType.error,
          title: Translations.of(context)!.text('snackbar.code-input.failure')
        );
      }
    });
  }

  // Cancel the password reset process
  void cancelPasswordReset(){
    Navigation.goToLogin();
    clear();
  }


  // Clear text fields and error messages
  void clear(){
    emailController.clear();
    passwordRepeatController.clear();
    passwordRepeatController.clear();
    emailErrorText = null;
    passwordErrorText = null;
    passwordRepeatErrorText = null;
  }
}
