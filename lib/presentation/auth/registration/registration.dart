import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/registration_service.dart';
import 'package:energy_dashboard/presentation/auth/registration/registration_footer.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_scaffold.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/email_text_field.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;
  late final RegistrationService _registrationService;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _registrationService = context.read<RegistrationService>();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      header: Header(
        title: Translations.of(context)!.text('registration.appbar.title'),
        showSwissLogo: true
      ),
      footer: RegistrationFooter(modalAnimationController: _animationController),
      body: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, Paddings.paddingS, 0, Paddings.paddingL),
          child: Text(
            Translations.of(context)!.text('registration.instructions'),
            style: const TextStyle(
              fontSize: AuthConst.kAuthInstructionsFontSize,
              fontWeight: FontWeight.normal,
              color: ColorPalette.textColor,
            ),
          ),
        ),
        Selector<RegistrationService, String?>(
          selector: (_, service) => service.emailErrorText,
          shouldRebuild: (prev, current) => true,
          builder: (_, error, __){
            return EmailTextField(
              label: Translations.of(context)!.text('textfield.label.email'),
              controller: _registrationService.emailController,
              errorText: error,
              focusNode: _registrationService.emailFocusNode,
              inputAction: TextInputAction.next,
              hintText: Translations.of(context)!.text('textfield.hint.email'),
            );
          },
        ),
        Selector<RegistrationService, String?>(
          selector: (_, service) => service.passwordErrorText,
          shouldRebuild: (prev, current) => true,
          builder: (_, error, __){
            return PasswordTextField(
              label: Translations.of(context)!.text('textfield.label.password'),
              controller: _registrationService.passwordController,
              errorText: error,
              inputAction: TextInputAction.next,
              focusNode: _registrationService.passwordFocusNode,
              hintText: Translations.of(context)!.text('textfield.hint.password'),
            );
          },
        ),
        Selector<RegistrationService, String?>(
          selector: (_, service) => service.passwordRepeatErrorText,
          shouldRebuild: (prev, current) => true,
          builder: (_, error, __){
            return PasswordTextField(
              label: Translations.of(context)!.text('textfield.label.password-repeat'),
              controller: _registrationService.passwordRepeatController,
              errorText: error,
              focusNode: _registrationService.passwordRepeatFocusNode,
              hintText: Translations.of(context)!.text('textfield.hint.password-repeat'),
              inputAction: TextInputAction.done,
            );
          },
        ),
        Gaps.vSpacingS,
      ],
    );
  }

}
