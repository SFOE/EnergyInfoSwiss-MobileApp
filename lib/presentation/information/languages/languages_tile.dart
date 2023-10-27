import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/localization.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class LanguagesTile extends StatelessWidget {
  final int index;
  final bool active;
  final VoidCallback callback;
  const LanguagesTile({super.key, required this.index, required this.active, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Paddings.paddingM, vertical: Paddings.paddingS),
        margin: EdgeInsets.only(top: index == 0 ? Paddings.paddingM : 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: index != GetIt.I.get<AppLocalization>().supportedLanguages.length-1 ? 1 : 0, color: ColorPalette.dividerColor),
          ),
          color: ColorPalette.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                Utils().getLangNameByCode(GetIt.I.get<AppLocalization>().supportedLanguages[index], context),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300
                ),
              ),
            ),
            active
              ? const Icon(Icons.done_rounded, size: 18, color: ColorPalette.primaryColor)
              : const SizedBox(),
          ],
        ),
      ),
      onTap: () => callback(),
    );
  }
}
