import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Paddings.paddingXS),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 13.4,
            fontWeight: FontWeight.normal,
            color: ColorPalette.textColor
          ),
          children: [
            TextSpan(
              text: '${Translations.of(context)!.text('Types of processed data and purpose of processing.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Types of processed data and purpose of processing.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Privacy policy for cookies.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Privacy policy for cookies.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Processing of Personal Data through the Login Feature.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Processing of Personal Data through the Login Feature.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Rights of the Data Subjects.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Rights of the Data Subjects.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Delete Account.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Delete Account.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Legal notice.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Legal notice.text'),
            ),
            WidgetSpan(
              child: GestureDetector(
                child: const Text('https://www.admin.ch/gov/en/start/terms-and-conditions.html', style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.blueAccent)),
                onTap: () => Utils().launchExternalUrl('https://www.admin.ch/gov/en/start/terms-and-conditions.html', context),
              )
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Changes and updates to the privacy policy.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Changes and updates to the privacy policy.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: '${Translations.of(context)!.text('Responsible.title')}\n',
              style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Translations.of(context)!.text('Responsible.text'),
            ),
            const WidgetSpan(child: SizedBox(height: 8, width: double.infinity)),
            TextSpan(
              text: Translations.of(context)!.text('Last modified.text'),
            ),
          ]
        ),
      ),
    );
  }
}
