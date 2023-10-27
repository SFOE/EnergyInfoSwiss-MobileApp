import 'package:energy_dashboard/core/mixins/ampel_system_mixin.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';


class AmpelSystemPlaceholder extends StatelessWidget {
  const AmpelSystemPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AmpelSystemMixin.kAmpelSystemHeight
          +AmpelSystemMixin.kAmpelSystemTabsHeight
          +Paddings.paddingXS
          +Paddings.paddingM,
      width: double.infinity,
    );
  }
}
