import 'package:energy_dashboard/core/mixins/nav_bar_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:energy_dashboard/presentation/components/nav_bar/nav_bar_items.dart';
import 'package:energy_dashboard/presentation/components/nav_bar/nav_bar_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class NavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavBar({Key? key, required this.navigationShell}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Selector<KPIManager, bool>(
      selector: (_, manager) => manager.editorMode,
      builder: (context, isEditing, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: NavBarMixin.heightAnimationDuration),
          curve: Curves.easeIn,
          height: isEditing ? 0 : Constants.kNavBarHeight + MediaQuery.of(context).viewPadding.bottom,
          color: ColorPalette.white,
          child: Stack(
            children: [
              NavBarItems(index: navigationShell.currentIndex),
              const Divider(thickness: 1, color: ColorPalette.dividerColor, height: 1),
              NavBarSlider(index: navigationShell.currentIndex),
            ],
          ),
        );
      }
    );
  }
}
