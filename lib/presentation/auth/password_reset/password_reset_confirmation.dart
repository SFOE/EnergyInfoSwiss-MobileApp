import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/password_service.dart';
import 'package:energy_dashboard/presentation/auth/password_reset/footers/password_reset_confirmation_footer.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_scaffold.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/code_digit_field.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


class PasswordResetConfirmation extends StatefulWidget {
  const PasswordResetConfirmation({super.key});

  @override
  State<PasswordResetConfirmation> createState() => _PasswordResetConfirmationState();
}

class _PasswordResetConfirmationState extends State<PasswordResetConfirmation> {

  late final List<TextEditingController> _codeControllers;

  @override
  void initState() {
    super.initState();
    _codeControllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    super.dispose();
    _codeControllers.map((c) => c.dispose());
  }


  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      header: Header(
        title: Translations.of(context)!.text('password-reset.appbar.title'),
        showSwissLogo: true
      ),
      footer: PasswordResetConfirmationFooter(codeControllers: _codeControllers),
      body: [
        Padding(
          padding: const EdgeInsets.only(top: Paddings.paddingS),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: AuthConst.kAuthInstructionsFontSize,
                fontWeight: FontWeight.normal,
                color: ColorPalette.textColor,
              ),
              children: [
                TextSpan(
                  text: Translations.of(context)!.text('password-reset.confirmation.instructions.password-input'),
                ),
                TextSpan(
                  text: Translations.of(context)!.text('button.title.reset-password'),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: '.'),
              ]
            ),
          ),
        ),
        Gaps.vSpacingM,
        Selector<PasswordService, String?>(
          selector: (_, service) => service.passwordErrorText,
          shouldRebuild: (prev, next) => true,
          builder: (_, error, __) {
            return PasswordTextField(
              label: Translations.of(context)!.text('textfield.label.password'),
              controller: context.read<PasswordService>().passwordController,
              errorText: error,
              inputAction: TextInputAction.next,
              focusNode: context.read<PasswordService>().passwordFocusNode,
              hintText: Translations.of(context)!.text('textfield.hint.password'),
            );
          }
        ),
        Selector<PasswordService, String?>(
          selector: (_, service) => service.passwordRepeatErrorText,
          shouldRebuild: (prev, next) => true,
          builder: (_, error, __) {
            return PasswordTextField(
              label: Translations.of(context)!.text('textfield.label.password-repeat'),
              controller: context.read<PasswordService>().passwordRepeatController,
              errorText: error,
              inputAction: TextInputAction.done,
              focusNode: context.read<PasswordService>().passwordRepeatFocusNode,
              hintText: Translations.of(context)!.text('textfield.hint.password-repeat'),
            );
          }
        ),
        Gaps.vSpacingS,
        CodeDigitField(
          email: context.read<PasswordService>().emailController.text,
          digitControllers: _codeControllers,
          resendCodeCallback: () async => await GetIt.I.get<AuthRepository>().resetPassword(context.read<PasswordService>().emailController.text),
          hasSubtitle: true,
        ),
        Gaps.vSpacingS,
      ],
    );
  }
}
