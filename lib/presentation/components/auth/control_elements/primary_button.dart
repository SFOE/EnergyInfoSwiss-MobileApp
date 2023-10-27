import 'package:energy_dashboard/core/utils/auth/auth_constants.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatefulWidget {
  final String title;
  final VoidCallback callback;
  final bool isDisabled;
  final bool isLoading;
  const PrimaryButton({super.key, required this.title, required this.callback, this.isDisabled = false, this.isLoading = false});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with SingleTickerProviderStateMixin{

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
          decoration: AuthConst.kPrimaryButtonBoxDecoration.copyWith(color: widget.isDisabled ? ColorPalette.disabledButtonColor : ColorPalette.primaryColor),
          alignment: Alignment.center,
          child: widget.isLoading
            ? AuthConst.kPrimaryButtonLoadingSpinner
            : Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AuthConst.kPrimaryButtonTextStyle.copyWith(color: widget.isDisabled ? ColorPalette.disabledButtonTextColor : ColorPalette.white),
            ),
        ),
      ),
      onTap: (){
        if(!widget.isDisabled && !widget.isLoading){
          widget.callback();
          AuthUtils().shrinkButtonSize(_animationController);
          AuthUtils().restoreButtonSize(_animationController);
        }
      },
      onTapDown: (_) => !widget.isDisabled && !widget.isLoading ? AuthUtils().shrinkButtonSize(_animationController) : null,
      onTapCancel: () => !widget.isDisabled && !widget.isLoading ? AuthUtils().restoreButtonSize(_animationController) : null,
    );
  }

}
