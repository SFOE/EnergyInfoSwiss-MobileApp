import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';


class AuthUtils{

  // Returns true if the provided email format is valid
  bool isValidEmail(String email){
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  // Return true if the provided password complies the password policy
  bool isValidPassword(String password){
    return password.length >= 8;
  }

  // Concatenates the digit controllers values
  String getCodeByControllers(List<TextEditingController> controllers){
    return controllers.map((c) => c.text).join('');
  }


  // Sends and handles the registration code
  Future<void> sendRegistrationCode({
    required BuildContext context,
    required RegistrationService registrationService,
    required AnimationController animationController
  }) async {
    final String email = registrationService.emailController.text;
    final signUpSuccessful = await registrationService.signUpUser(context);
    //ignore_for_file: use_build_context_synchronously
    if(registrationService.validCredentials() && signUpSuccessful){
      Utils().openCodeVerificationModalSheet(
        context: context,
        email: email,
        animationController: animationController,
        verifyCallback: (code) async {
          registrationService.isLoadingVerification.value = true;
          await GetIt.I.get<AuthRepository>().confirmUser(
            email: email,
            confirmationCode: code,
          ).then((verified) async {
            registrationService.finishRegistration(context, verified);
          });
        },
      );
    }
  }

  // Returns digit controllers with pasted numbers, or null
  Future<List<TextEditingController>?> pasteCodeFromClipboard(List<TextEditingController> digitControllers) async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final clipboardText = clipboardData?.text;

    if(clipboardText != null && clipboardText.length == 6){
      try{
        final digits = clipboardText.split('').map(int.tryParse).toList();

        if(digits.every((digit) => digit != null)){
          for(int i = 0; i < digitControllers.length; i++){
            digitControllers[i].text = digits[i].toString();
          }
          return digitControllers; // Return digit controllers with pasted numbers
        }
      }catch (e){
        debugPrint('[_copyCodeFromClipboard] Cannot parse clipboard text to integer');
      }
    }else{
      debugPrint('Invalid clipboard data: $clipboardText');
    }
    return null;
  }

  // Shrink button animation (shrink)
  void shrinkButtonSize(AnimationController animationController){
    animationController.forward();
  }

  // Shrink button animation (grow)
  void restoreButtonSize(AnimationController animationController){
    Future.delayed(
      const Duration(milliseconds: AuthConst.kButtonShrinkAnimationDuration),
          () => animationController.reverse(),
    );
  }

}