import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/callbacks.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


class EmailTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputAction? inputAction;
  final String? errorText;
  final FocusNode? focusNode;
  final OnChangeCallback? onChangeCallback;

  const EmailTextField({super.key, required this.label, required this.controller, this.hintText, this.inputAction, this.errorText, this.focusNode, this.onChangeCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Paddings.paddingXS),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AuthConst.kTextFieldLabelTextStyle,
          ),
          Gaps.vSpacingXXS,
          TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: inputAction ?? TextInputAction.next,
            focusNode: focusNode,
            onChanged: (change) => onChangeCallback != null ? onChangeCallback!(change) : null,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(AuthConst.kTextfieldContentPadding),
              hintText: hintText ?? '',
              hintStyle: AuthConst.kTextFieldHintTextStyle,
              border: AuthConst.kTextfieldBorder,
              enabledBorder: AuthConst.kTextfieldBorderEnabled,
              focusedBorder: AuthConst.kTextfieldBorderFocused,
              errorText: errorText,
              errorStyle: AuthConst.kTextFieldErrorTextStyle,
              errorMaxLines: 2
            ),
            style: AuthConst.kTextFieldTextStyle,
          ),
        ],
      ),
    );
  }
}
