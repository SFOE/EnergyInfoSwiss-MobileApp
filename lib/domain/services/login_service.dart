import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

/// Service for the Login process
///
/// Handles all login functionalities
class LoginService extends ChangeNotifier {

  LoginService() {
    // Initialize controllers, focus nodes, and value notifiers
    emailController = TextEditingController()..addListener(_emailListener);
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    emailErrorText = null;
    passwordErrorText = null;
    isLoading = ValueNotifier(false);
  }

  // Controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  // Focus nodes
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  // Error texts
  late String? emailErrorText;
  late String? passwordErrorText;

  // Button state
  late ValueNotifier<bool> isLoading;

  @override
  dispose() {
    // Dispose of controllers, focus nodes, and value notifiers
    emailController.removeListener(_emailListener);
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    isLoading.dispose();
    super.dispose();
  }

  // Listeners

  // Listener for email text field changes
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

  // Sign in user with email and password
  Future<void> signInUser(BuildContext context) async {
    if(!AuthUtils().isValidEmail(emailController.text)){
      emailErrorText = Translations.of(context)!.text('textfield.error.invalid-email');
      notifyListeners();
      return;
    }
    isLoading.value = true;
    await GetIt.I.get<AuthRepository>().signInUser(emailController.text, passwordController.text).then((success) {
      isLoading.value = false;
      if(success){
        finishLogin();
        FlashMessageFactory.showFlashMessage(
          context: context,
          type: FlashMessageType.success,
          title: Translations.of(context)!.text('snackbar.login.success')
        );
      }else{
        FlashMessageFactory.showFlashMessage(
          context: context,
          type: FlashMessageType.error,
          title: Translations.of(context)!.text('snackbar.login.failure')
        );
      }
    });
  }

  // Finish the login process
  void finishLogin() {
    Navigation.finishOnBoarding();
    clear();
  }

  // Clear error messages and text fields
  void clear() {
    emailErrorText = null;
    passwordErrorText = null;
    emailController.clear();
    passwordController.clear();
  }
}
