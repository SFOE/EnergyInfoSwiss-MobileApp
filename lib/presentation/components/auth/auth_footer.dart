import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


/// This widget applies the auth footer design
///
/// It is used only for authentication screens
/// to keep the footers consistent
class AuthFooter extends StatelessWidget {
  final List<Widget> children;
  const AuthFooter({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingXXS, Paddings.paddingS, MediaQuery.of(context).viewPadding.bottom+Paddings.paddingS),
      color: ColorPalette.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
