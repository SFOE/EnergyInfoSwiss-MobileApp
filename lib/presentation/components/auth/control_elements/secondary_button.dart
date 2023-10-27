import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:flutter/material.dart';


class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final bool isSmall;
  const SecondaryButton({super.key, required this.title, required this.callback, this.isSmall=false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: isSmall ? AuthConst.kSecondaryButtonSmallHeight : AuthConst.kSecondaryButtonHeight,
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: isSmall ? AuthConst.kSecondaryButtonSmallTextStyle : AuthConst.kSecondaryButtonTextStyle
        ),
      ),
      onTap: () => callback(),
    );
  }
}
