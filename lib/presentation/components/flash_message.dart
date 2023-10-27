import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/types/flash_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FlashMessageFactory{
  static Future<void> showFlashMessage({
    required BuildContext context,
    required FlashMessageType type,
    required String title
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: FlashMessage(
            title: title,
            type: type
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 3600),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dismissDirection: DismissDirection.down,
        elevation: 0,
      ),
    );
  }
}

class FlashMessage extends StatefulWidget{
  final FlashMessageType type;
  final String title;
  const FlashMessage({super.key, required this.title, required this.type});

  @override
  State<FlashMessage> createState() => _FlashMessageState();
}

class _FlashMessageState extends State<FlashMessage> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 440),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );

    _animationController.forward().then((_){
      Future.delayed(const Duration(milliseconds: 3250), (){
        if(mounted){
          _animationController.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.paddingS, vertical: 12),
        margin: const EdgeInsets.only(bottom: Paddings.paddingXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type.color,
          boxShadow: const [
            BoxShadow(offset: Offset.zero, spreadRadius: 0, blurRadius: 10, color: ColorPalette.flashMessageShadowColor),
          ],
          border: widget.type == FlashMessageType.info ? Border.all(color: ColorPalette.flashMessageInfoBorderColor, width: 1) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.type.iconAssetPath,
              colorFilter: const ColorFilter.mode(ColorPalette.textColor, BlendMode.srcIn),
              height: 22,
            ),
            Gaps.hSpacingS,
            Flexible(
              fit: FlexFit.loose,
              flex: 10,
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorPalette.textColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
