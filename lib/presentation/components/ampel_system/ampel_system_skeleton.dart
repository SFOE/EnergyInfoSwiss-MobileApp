import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/core/types/ampel_type.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system.dart';
import 'package:energy_dashboard/presentation/components/shimmer.dart';
import 'package:flutter/material.dart';


class AmpelSystemSkeleton extends StatelessWidget {
  const AmpelSystemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      baseColor: ColorPalette.shimmerBaseColor,
      highlightColor: ColorPalette.shimmerHighlightColor,
      child: const IgnorePointer(
        child: AmpelSystem(ampel: Ampel(type: AmpelType.energy, level: AmpelLevel.level1, validFrom: ''))
      ),
    );
  }
}
