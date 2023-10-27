import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';


class InformationAppVersion extends StatelessWidget {
  const InformationAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          final packageInfo = snapshot.data;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Paddings.paddingS),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 11.4,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.textColorLight,
                    height: 1.4
                  ),
                  children: [
                    TextSpan(text: '${packageInfo!.appName}\n'),
                    TextSpan(text: 'Version ${packageInfo.version} (${packageInfo.buildNumber})'),
                  ]
                ),
              )
            ),
          );
        }else{
          return const SizedBox(height: Paddings.paddingS);
        }
      }
    );
  }
}
