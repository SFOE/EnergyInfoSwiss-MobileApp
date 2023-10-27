import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


class ModalDragHandle extends StatelessWidget {
  const ModalDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: Paddings.paddingS),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: ColorPalette.modalSheetDragHandlerColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
