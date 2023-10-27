import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/information/privacy_policy/privacy_policy_text.dart';
import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: Header(
        title: Translations.of(context)!.text('appbar.title.privacy_policy'),
        showBackButton: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingM, Paddings.paddingS, Paddings.paddingS),
            child: PrivacyPolicyText(),
          ),
        ),
      ),
    );
  }
}
