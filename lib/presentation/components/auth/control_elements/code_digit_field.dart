import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CodeDigitField extends StatefulWidget {
  final String email;
  final bool hasSubtitle; //to display text to whom the mail was sent
  final List<TextEditingController> digitControllers;
  final ResendCodeCallback resendCodeCallback;
  const CodeDigitField({super.key, required this.email, required this.digitControllers, required this.resendCodeCallback, this.hasSubtitle=false});

  @override
  State<CodeDigitField> createState() => _CodeDigitFieldState();
}

class _CodeDigitFieldState extends State<CodeDigitField> {

  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _digitControllers;

  @override
  void initState() {
    super.initState();
    _digitControllers = widget.digitControllers;
    _focusNodes = List.generate(AuthConst.kCodeDigits, (index) => FocusNode());
  }

  @override
  void dispose() {
    widget.digitControllers.map((c) => c.dispose());
    _digitControllers.map((c) => c.dispose());
    _focusNodes.map((f) => f.dispose());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: AuthConst.kTextFieldLabelFontSize,
                fontWeight: FontWeight.normal,
                color: ColorPalette.textColor,
                height: 1
              ),
              children: [
                TextSpan(text: Translations.of(context)!.text('code-digit-field.label.enter-code')),
                if(widget.hasSubtitle)
                  const TextSpan(text: '\n'),
                if(widget.hasSubtitle)
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(top: Paddings.paddingXXS),
                      child: Text(
                        '${Translations.of(context)!.text('code-digit-field.subtitle.code-sent-to')} ${widget.email}',
                        style: const TextStyle(color: ColorPalette.textColorLight, fontSize: 12, height: 1)
                      ),
                    )
                  ),
              ]
            ),
          ),
        ),
        Gaps.vSpacingXXS,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < AuthConst.kCodeDigits; i++)
              SizedBox(
                width: AuthConst.kCodeDigitFieldSize,
                height: AuthConst.kCodeDigitFieldSize,
                child: TextField(
                  controller: _digitControllers[i],
                  focusNode: _focusNodes[i],
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                  decoration: InputDecoration(
                    border: AuthConst.kTextfieldBorder,
                    enabledBorder: AuthConst.kTextfieldBorderEnabled,
                    focusedBorder: AuthConst.kTextfieldBorderFocused,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                  textInputAction: i < AuthConst.kCodeDigits-1 ? TextInputAction.next : TextInputAction.done,
                  style: AuthConst.kCodeDigitFieldTextStyle,
                  onChanged: (value) {
                    if(value.isEmpty && i > 0){
                      FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                    }else if(i < AuthConst.kCodeDigits - 1 || value.length > 1){
                      if(i==0 && value.isEmpty){
                        return;
                      }
                      FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                    }
                  },
                ),
              ),
          ],
        ),
        Gaps.vSpacingS,
        SecondaryButton(
          title: Translations.of(context)!.text('code-digit-field.paste-code-from-clipboard'),
          callback: () async => await AuthUtils().pasteCodeFromClipboard(_digitControllers).then((digitControllers){
            if(digitControllers!=null){
              setState(() {
                _digitControllers = digitControllers;
              });
            }
          }),
          isSmall: true,
        ),
        Gaps.vSpacingXXS,
        SecondaryButton(
          title: Translations.of(context)!.text('code-digit-field.resend-code'),
          callback: () => widget.resendCodeCallback(),
          isSmall: true,
        ),
      ],
    );
  }
}
