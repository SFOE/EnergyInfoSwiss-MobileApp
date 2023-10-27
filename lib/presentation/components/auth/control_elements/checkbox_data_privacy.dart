import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:flutter/material.dart';


class CheckboxDataPrivacy extends StatefulWidget {
  final CheckboxCallback checkboxCallback;
  final VoidCallback openDataPrivacyModalCallback;
  const CheckboxDataPrivacy({super.key, required this.checkboxCallback, required this.openDataPrivacyModalCallback});

  @override
  State<CheckboxDataPrivacy> createState() => _CheckboxDataPrivacyState();
}

class _CheckboxDataPrivacyState extends State<CheckboxDataPrivacy> {

  late ValueNotifier<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = ValueNotifier(false);
  }

  @override
  void dispose() {
    _isChecked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: Paddings.paddingS),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: _isChecked,
            builder: (context, checked, _) {
              return Checkbox(
                value: checked,
                activeColor: ColorPalette.primaryColor,
                checkColor: ColorPalette.white,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                onChanged: (_){
                  _isChecked.value = !_isChecked.value;
                  widget.checkboxCallback(_isChecked.value);
                }
              );
            }
          ),
          Flexible(
            fit: FlexFit.loose,
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: AuthConst.kTextFieldTextStyle,
                children: [
                  TextSpan(
                    text: Translations.of(context)!.text('checkbox.data-privacy.label'),
                  ),
                  WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Text(
                        Translations.of(context)!.text('checkbox.data-privacy.link'),
                        maxLines: 2,
                        style: AuthConst.kTextFieldTextStyle.copyWith(color: ColorPalette.primaryColor, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => widget.openDataPrivacyModalCallback(),
                    )
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
