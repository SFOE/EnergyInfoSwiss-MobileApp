import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/login_service.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


/// Service for the Registration process
///
/// Handles all registration functionalities
class RegistrationService extends ChangeNotifier {

  RegistrationService() {
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
    isLoadingVerification = ValueNotifier(false);
    isLoadingConfirmation = ValueNotifier(false);
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

  // Button states
  late ValueNotifier<bool> isLoadingVerification;
  late ValueNotifier<bool> isLoadingConfirmation;

  @override
  dispose() {
    // Dispose of controllers, focus nodes, and value notifiers
    emailController.removeListener(_emailListener);
    emailController.dispose();
    passwordRepeatController.removeListener(_passwordListener);
    passwordController.dispose();
    passwordRepeatController.removeListener(_passwordRepeatListener);
    passwordRepeatController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordRepeatFocusNode.dispose();
    isLoadingVerification.dispose();
    isLoadingConfirmation.dispose();
    super.dispose();
  }


  // Listeners

  _emailListener() {
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

  _passwordListener() {
    // remove error text on valid email
    if(passwordFocusNode.hasFocus){
      if(passwordErrorText != null){
        if(AuthUtils().isValidPassword(passwordController.text)){
          passwordErrorText = null;
          notifyListeners();
        }
      }
    }
  }

  _passwordRepeatListener() {
    // remove error text on valid email
    if(passwordRepeatFocusNode.hasFocus){
      if(passwordRepeatErrorText != null){
        if(passwordController.text == passwordRepeatController.text){
          passwordRepeatErrorText = null;
          notifyListeners();
        }
      }
    }
  }

  // Sign up a user
  Future<bool> signUpUser(BuildContext context) async {
    if(validCredentials()){
      isLoadingVerification.value = true;
      final signUpResult = await GetIt.I.get<AuthRepository>().signUpUser(
        email: emailController.text,
        password: passwordController.text,
      ).then((success) {
        isLoadingVerification.value = false;
        if (!success) {
          FlashMessageFactory.showFlashMessage(
            context: context,
            type: FlashMessageType.error,
            title: Translations.of(context)!.text('snackbar.registration.failure')
          );
        }
        return success;
      });
      return signUpResult;
    }else{
      if(!AuthUtils().isValidEmail(emailController.text)){
        emailErrorText = Translations.of(context)!.text('textfield.error.invalid-email');
        notifyListeners();
      }else if(!AuthUtils().isValidPassword(passwordController.text)){
        passwordErrorText = Translations.of(context)!.text('textfield.error.password-policy');
        notifyListeners();
      }else if(passwordController.text != passwordRepeatController.text){
        passwordRepeatErrorText = Translations.of(context)!.text('textfield.error.mismatched-passwords');
        notifyListeners();
      }
      return false;
    }
  }

  // Check if the provided credentials are valid
  bool validCredentials(){
    return AuthUtils().isValidEmail(emailController.text) &&
        AuthUtils().isValidPassword(passwordController.text) &&
        AuthUtils().isValidPassword(passwordRepeatController.text) &&
        passwordController.text == passwordRepeatController.text;
  }


  // Finish the registration process
  Future<void> finishRegistration(BuildContext context, bool verified) async {
    if(verified){
      Navigator.of(context).pop();
      await GetIt.I.get<AuthRepository>().signInUser(
        emailController.text,
        passwordController.text,
      );
      clear();
      isLoadingVerification.value = false;
      if(context.mounted){
        context.read<LoginService>().clear();
        Navigator.of(context).pop(); // Pop back to login
        Navigation.finishOnBoarding();
        FlashMessageFactory.showFlashMessage(
          context: context,
          type: FlashMessageType.success,
          title: Translations.of(context)!.text('snackbar.registration.success')
        );
      }
    }else{
      isLoadingVerification.value = false;
      isLoadingConfirmation.value = false;
      FlashMessageFactory.showFlashMessage(
        context: context,
        type: FlashMessageType.error,
        title: Translations.of(context)!.text('snackbar.code-input.failure')
      );
    }
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
