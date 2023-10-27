import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:energy_dashboard/presentation/components/modals/code_verification_modal.dart';
import 'package:energy_dashboard/presentation/components/modals/data_privacy_modal.dart';
import 'package:energy_dashboard/presentation/components/modals/delete_account_modal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


///
/// Utility methods that are used in the entire application
///
class Utils{

  void launchExternalUrl(String url, BuildContext context) async {
    var uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }else{
      if(context.mounted){
        FlashMessageFactory.showFlashMessage(context: context, type: FlashMessageType.error, title: Translations.of(context)!.text('snackbar.url.not_openable'));
      }
    }
  }


  bool mapEquals(Map<String, dynamic> a, Map<String, dynamic> b) {
    if(a.length != b.length){
      return false;
    }

    for(final key in a.keys){
      if(a[key] != b[key]){
        return false;
      }
    }

    return true;
  }

  String getLangNameByCode(String langCode, BuildContext context){
    switch(langCode){
      case 'de':
        return Translations.of(context)!.text('language.german');
      case 'fr':
        return Translations.of(context)!.text('language.french');
      case 'it':
        return Translations.of(context)!.text('language.italian');
      case 'en':
        return Translations.of(context)!.text('language.english');
      default:
        throw Exception('[Utils] languageName: Invalid language code: $langCode');
    }
  }

  openCodeVerificationModalSheet({
    required BuildContext context,
    required String email,
    required AnimationController animationController,
    required VerifyCallback verifyCallback
  }){
    showModalBottomSheet(
      context: context,
      transitionAnimationController: animationController,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      enableDrag: false,
      isDismissible: true,
      elevation: 0,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_){
        return CodeVerificationModal(
          email: email,
          verifyCallback: (code) => verifyCallback(code),
        );
      }
    );
  }

  openDeleteAccountModal({
    required BuildContext context,
    required AnimationController animationController,
  }){
    showModalBottomSheet(
      context: context,
      transitionAnimationController: animationController,
      backgroundColor: ColorPalette.white,
      barrierColor: Colors.transparent,
      enableDrag: false,
      isDismissible: true,
      builder: (_){
        return const DeleteAccountModal();
      }
    );
  }

  openDataPrivacyModal({
    required BuildContext context,
    required AnimationController animationController,
  }){
    showModalBottomSheet(
      context: context,
      transitionAnimationController: animationController,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (_){
        return const DataPrivacyModal();
      }
    );
  }

}