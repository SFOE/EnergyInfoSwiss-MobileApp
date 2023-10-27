import 'package:energy_dashboard/core/extensions/uri_extension.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:energy_dashboard/core/utils/information_details_parameter.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:energy_dashboard/presentation/components/flash_message.dart';
import 'package:energy_dashboard/presentation/information/information_app_version.dart';
import 'package:energy_dashboard/presentation/information/information_tile.dart';
import 'package:energy_dashboard/presentation/information/information_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.grey50,
      appBar: Header(title: Translations.of(context)!.text('appbar.title.information'), showSwissLogo: false, showBackButton: true),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            InformationTileGroup(
              children: [
                FutureBuilder(
                  future: GetIt.I.get<AuthRepository>().isUserSignedIn(),
                  builder: (_, snapshot){
                    if(snapshot.hasData && snapshot.data != null){
                      if(snapshot.data!){
                        return InformationTile(
                          title: Translations.of(context)!.text('information-tile.title.sign-out'),
                          isLink: false,
                          callback: (){
                            GetIt.I.get<AuthRepository>().signOutCurrentUser().then((success){
                              Navigation.goToOverview();
                              FlashMessageFactory.showFlashMessage(
                                  context: context,
                                  type: FlashMessageType.success,
                                  title: Translations.of(context)!.text('snackbar.sign-out.success')
                              );
                            });
                          }
                        );
                      }else{
                        return InformationTile(
                          title: Translations.of(context)!.text('information-tile.title.sign-in'),
                          isLink: false,
                          callback: (){
                            Navigator.of(context).pop();
                            Navigation.goToLogin();
                          }
                        );
                      }
                    }else{
                      return InformationTile(title: '', isLink: false, callback: (){});
                    }
                  },
                ),
              ],
            ),
            InformationTileGroup(children: [
              InformationTile(title: Translations.of(context)!.text('information.language.title'), subtitle: Utils().getLangNameByCode(Translations.of(context)!.locale.languageCode, context), isLink: false, callback: () => Navigation.goToLanguages(context))
            ]),
            InformationTileGroup(children: [
              InformationTile(title: Translations.of(context)!.text('footer.info.topic1'), isLink: true, callback: () => Utils().launchExternalUrl(Translations.of(context)!.text('footer.info.topic1.url'), context)),
              InformationTile(title: Translations.of(context)!.text('footer.info.topic2'), isLink: true, callback: () => Utils().launchExternalUrl(Translations.of(context)!.text('footer.info.topic2.url'), context)),
              InformationTile(title: Translations.of(context)!.text('footer.info.topic3'), isLink: true, callback: () => Utils().launchExternalUrl(Translations.of(context)!.text('footer.info.topic3.url'), context)),
              InformationTile(title: Translations.of(context)!.text('footer.info.topic4'), isLink: true, callback: () => Utils().launchExternalUrl(Translations.of(context)!.text('footer.info.topic4.url'), context)),
            ]),
            InformationTileGroup(children: [
              InformationTile(title: Translations.of(context)!.text('footer.data.download.opendataswiss'), subtitle: Translations.of(context)!.text('commons.kpi-footer.download-data'), isLink: true, callback: () => Utils().launchExternalUrl(Translations.of(context)!.text('footer.data.download.opendataswiss.url'), context)),
            ]),
            InformationTileGroup(children: [
              InformationTile(title: Translations.of(context)!.text('footer.ax-statement'), isLink: false, callback: () => Navigation.goToInformationDetails(InformationDetailsParameter(title: Translations.of(context)!.text('footer.ax-statement'), url: 'https://dev.energiedashboard.ch/ax-statement?viewtype=app&lng=${Translations.of(context)!.currentLanguage}'))),
              InformationTile(title: Translations.of(context)!.text('footer.contact'), isLink: false, callback: () => Utils().launchExternalUrl(Uri(scheme: 'mailto', path: 'media@bfe.admin.ch').toUrl(), context)),
              InformationTile(title: Translations.of(context)!.text('appbar.title.privacy_policy'), isLink: false, callback: () => Navigation.goToPrivacyPolicy()),
            ]),
            Gaps.vSpacingXS,
            const InformationAppVersion(),
          ],
        ),
      ),
    );
  }
}
