import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/modals/modal_drag_handle.dart';
import 'package:energy_dashboard/presentation/information/privacy_policy/privacy_policy_text.dart';
import 'package:flutter/material.dart';


class DataPrivacyModal extends StatelessWidget {
  const DataPrivacyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthConst.kAuthModalTopGap,
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            decoration: AuthConst.kAuthModalBoxDecorationShadow,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingXS, Paddings.paddingS, Paddings.paddingM+MediaQuery.of(context).viewPadding.bottom),
              decoration: AuthConst.kAuthModalBoxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const ModalDragHandle(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      Translations.of(context)!.text('modal.terms-of-use.title'),
                      maxLines: 2,
                      style: AuthConst.kAuthModalTitleTextStyle,
                    ),
                  ),
                  Gaps.vSpacingXS,
                  const Expanded(
                    flex: 20,
                    child: SingleChildScrollView(
                      child: PrivacyPolicyText(),
                    ),
                  ),
                  Gaps.vSpacingXS,
                  PrimaryButton(
                    title: Translations.of(context)!.text('button.title.close'),
                    callback: () => Navigator.of(context).pop()
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
