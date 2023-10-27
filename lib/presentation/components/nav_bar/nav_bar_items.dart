import 'package:energy_dashboard/core/mixins/nav_bar_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/navigation_route.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class NavBarItems extends StatelessWidget with NavBarMixin{
  final int index;
  const NavBarItems({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // for the show/hide nav bar purpose
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(NavBarMixin.horizontalPadding, NavBarMixin.topPadding, NavBarMixin.horizontalPadding, 0),
        child: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: ColorPalette.primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: ColorPalette.textColorLight,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorPalette.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: NavBarMixin.labelFontSize,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          unselectedFontSize: NavBarMixin.labelFontSize,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Overview.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Overview-fill.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              ),
              label: Translations.of(context)!.text('navigation.mobile.title.home'),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Energy.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Energy-fill.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              ),
              label: Translations.of(context)!.text('navigation.strom'),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Gas.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Gas-fill.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              ),
              label: Translations.of(context)!.text('navigation.gas'),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Price-Trend.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS),
                child: SvgPicture.asset('assets/icons/nav_bar/Price-Trend-fill.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              ),
              label: Translations.of(context)!.text('navigation.preise'),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS-2),
                child: SvgPicture.asset('assets/icons/nav_bar/Weather.svg', width: 26, height: 26, colorFilter: const ColorFilter.mode(ColorPalette.textColorLight, BlendMode.srcIn)),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: Paddings.paddingXS-2),
                child: SvgPicture.asset('assets/icons/nav_bar/Weather-fill.svg', width: 26, height: 26, colorFilter: const ColorFilter.mode(ColorPalette.primaryColor, BlendMode.srcIn)),
              ),
              label: Translations.of(context)!.text('navigation.wetter'),
            )
          ],
          currentIndex: index < NavigationRoute.values.length ? index : 0,
          onTap: (newIndex) {
            context.read<KPIManager>()
                ..disableEditorMode()
                ..updateRoute(NavigationRouteExtension.getRouteByIndex(newIndex));
            Navigation.goToRouteByIndex(newIndex);
          },
        ),
      ),
    );
  }
}
