import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/dismiss_keyboard.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/domain/services/registration_service.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/code_digit_field.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


class CodeVerificationModal extends StatefulWidget {
  final String email;
  final VerifyCallback verifyCallback;
  const CodeVerificationModal({super.key, required this.email, required this.verifyCallback});

  @override
  State<CodeVerificationModal> createState() => _CodeVerificationModalState();
}

class _CodeVerificationModalState extends State<CodeVerificationModal> {

  late final List<TextEditingController> _codeControllers;
  late final RegistrationService _registrationService;

  @override
  void initState() {
    super.initState();
    _codeControllers = List.generate(AuthConst.kCodeDigits, (index) => TextEditingController());
    _registrationService = context.read<RegistrationService>();
  }

  @override
  void dispose() {
    super.dispose();
    _codeControllers.map((c) => c.dispose());
  }


  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Column(
        children: [
          AuthConst.kAuthModalTopGap,
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              decoration: AuthConst.kAuthModalBoxDecorationShadow,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingXS, Paddings.paddingS, Paddings.paddingL+MediaQuery.of(context).viewPadding.bottom),
                decoration: AuthConst.kAuthModalBoxDecoration,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            Translations.of(context)!.text('modal.code-verification.title'),
                            maxLines: 2,
                            style: AuthConst.kAuthModalTitleTextStyle,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: AuthConst.kAuthModalCloseButtonSize, color: ColorPalette.textColor),
                          padding: const EdgeInsets.all(0),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: AuthConst.kAuthModalInfoTextStyle,
                        children: [
                          TextSpan(
                            text: Translations.of(context)!.text('modal.code-verification.instructions.code-sent-to')
                          ),
                          TextSpan(
                            text: widget.email,
                            style: AuthConst.kAuthModalInfoTextStyle.copyWith(color: ColorPalette.disabledButtonTextColor),
                          ),
                          const TextSpan(
                            text: '\n\n',
                          ),
                          TextSpan(
                            text: Translations.of(context)!.text('modal.code-verification.instructions.code-input')
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    CodeDigitField(
                      email: widget.email,
                      digitControllers: _codeControllers,
                      resendCodeCallback: () async {
                        await GetIt.I.get<AuthRepository>().resendSignUpCode(widget.email).then((success){
                          if(success){
                            FlashMessageFactory.showFlashMessage(
                              context: context,
                              type: FlashMessageType.success,
                              title: '${Translations.of(context)!.text('snackbar.code-resend.success')} ${widget.email}'
                            );
                          }else{
                            FlashMessageFactory.showFlashMessage(
                              context: context,
                              type: FlashMessageType.error,
                              title: Translations.of(context)!.text('snackbar.code-resend.failure')
                            );
                          }
                        });
                      },
                    ),
                    const Spacer(flex: 4),
                    ValueListenableBuilder(
                      valueListenable: _registrationService.isLoadingConfirmation,
                      builder: (context, loading, _) {
                        return PrimaryButton(
                          title: Translations.of(context)!.text('button.title.verify-code'),
                          callback: (){
                            _registrationService.isLoadingConfirmation.value = true;
                            widget.verifyCallback(AuthUtils().getCodeByControllers(_codeControllers));
                          },
                          isLoading: loading,
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
