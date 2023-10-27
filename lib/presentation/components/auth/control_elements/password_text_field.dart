import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputAction? inputAction;
  final String? errorText;
  final FocusNode? focusNode;
  final OnChangeCallback? onChangeCallback;
  const PasswordTextField({super.key, required this.label, required this.controller, this.hintText, this.inputAction, this.errorText, this.focusNode, this.onChangeCallback});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  late ValueNotifier<bool> _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = ValueNotifier(false);
  }

  @override
  void dispose() {
    _isVisible.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Paddings.paddingS),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AuthConst.kTextFieldLabelTextStyle,
          ),
          Gaps.vSpacingXXS,
          ValueListenableBuilder(
            valueListenable: _isVisible,
            builder: (context, isVisible, _) {
              return TextField(
                controller: widget.controller,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: widget.inputAction ?? TextInputAction.done,
                focusNode: widget.focusNode,
                obscureText: !isVisible,
                onEditingComplete: (){
                  if(widget.inputAction == TextInputAction.next){
                    widget.focusNode?.nextFocus();
                    widget.focusNode?.nextFocus();  // one nextFocus would just focus the IconButton
                  }else{
                    widget.focusNode?.unfocus();
                  }
                },
                onChanged: (change) => widget.onChangeCallback != null ? widget.onChangeCallback!(change) : null,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(AuthConst.kTextfieldContentPadding),
                  hintText: widget.hintText ?? '',
                  hintStyle: AuthConst.kTextFieldHintTextStyle,
                  border: AuthConst.kTextfieldBorder,
                  enabledBorder: AuthConst.kTextfieldBorderEnabled,
                  focusedBorder: AuthConst.kTextfieldBorderFocused,
                  errorText: widget.errorText,
                  errorStyle: AuthConst.kTextFieldErrorTextStyle,
                  errorMaxLines: 2,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          isVisible ? 'assets/icons/eye-slash.svg': 'assets/icons/eye.svg',
                          width: AuthConst.kTextFieldSuffixIconSize,
                          height: AuthConst.kTextFieldSuffixIconSize,
                          colorFilter: const ColorFilter.mode(ColorPalette.textFieldSuffixButtonColor, BlendMode.srcIn),
                        ),
                        onPressed: () => _isVisible.value = !_isVisible.value,
                      ),
                      if(widget.errorText != null)
                        Gaps.hSpacing3XS,
                      if(widget.errorText != null)
                        SvgPicture.asset(
                          'assets/icons/flash_message/error.svg',
                          width: AuthConst.kTextFieldSuffixIconSize,
                          height: AuthConst.kTextFieldSuffixIconSize,
                          colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn),
                        ),
                      if(widget.errorText != null)
                        Gaps.hSpacingS
                    ],
                  ),
                ),
                style: AuthConst.kTextFieldTextStyle,
              );
            }
          ),
        ],
      ),
    );
  }
}
