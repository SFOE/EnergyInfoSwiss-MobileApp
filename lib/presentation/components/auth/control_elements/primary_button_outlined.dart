import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:flutter/material.dart';


class PrimaryButtonOutlined extends StatefulWidget {
  final String title;
  final VoidCallback callback;
  const PrimaryButtonOutlined({super.key, required this.title, required this.callback});

  @override
  State<PrimaryButtonOutlined> createState() => _PrimaryButtonOutlinedState();
}

class _PrimaryButtonOutlinedState extends State<PrimaryButtonOutlined> with SingleTickerProviderStateMixin{

  late final AnimationController _animationController;

  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 120),
        lowerBound: 0.0,
        upperBound: 0.02
    )..addListener((){
      setState(() => _scale = 1 - _animationController.value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: AuthConst.kPrimaryButtonHeight,
          width: double.infinity,
          decoration: AuthConst.kPrimaryButtonOutlinedBoxDecoration,
          alignment: Alignment.center,
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AuthConst.kPrimaryButtonOutlinedTextStyle,
          ),
        ),
      ),
      onTap: (){
        widget.callback();
        AuthUtils().shrinkButtonSize(_animationController);
        AuthUtils().restoreButtonSize(_animationController);
      },
      onTapDown: (_) => AuthUtils().shrinkButtonSize(_animationController),
      onTapCancel: () => AuthUtils().restoreButtonSize(_animationController),
    );
  }

}
