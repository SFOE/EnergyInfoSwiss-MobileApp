

import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/core/types/ampel_type.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';

mixin AmpelSystemMixin{

  // Constants
  static const double kAmpelSystemBorderRadius = 11;
  static const double kAmpelSystemHeight = 45;
  static const double kAmpelSystemTabsHeight = 16;
  static const double kAmpelSystemTabWidth = 38;
  static const double kAmpelSystemBorderWidth = 1;
  static const double kAmpelSystemTabsBorderWidth = 2;
  static const double kAmpelSystemTabHeightInactive = 7;
  static const double kAmpelSystemTabHeightActive = 14;

  // Functions
  String getAmpelTranslationKeyPrefix(Ampel ampel){
    switch(ampel.level){
      case AmpelLevel.level1:
        return ampel.type == AmpelType.energy ? 'ampel-strom_stufe-1' : 'ampel-gas_stufe-1';
      case AmpelLevel.level2:
        return ampel.type == AmpelType.energy ? 'ampel-strom_stufe-2' : 'ampel-gas_stufe-2';
      case AmpelLevel.level3:
        return ampel.type == AmpelType.energy ? 'ampel-strom_stufe-3' : 'ampel-gas_stufe-3';
      case AmpelLevel.level4:
        return ampel.type == AmpelType.energy ? 'ampel-strom_stufe-4' : 'ampel-gas_stufe-4';
      case AmpelLevel.level5:
        return ampel.type == AmpelType.energy ? 'ampel-strom_stufe-5' : 'ampel-gas_stufe-5';
    }
  }
}