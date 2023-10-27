import 'package:energy_dashboard/core/types/ampel_level.dart';
import 'package:energy_dashboard/core/types/ampel_type.dart';


class Ampel{
  final AmpelType type;
  final AmpelLevel level;
  final String validFrom;
  const Ampel({required this.type, required this.level, required this.validFrom});

  factory Ampel.fromJson(Map<String, dynamic> json, String key) => Ampel(
    type: AmpelTypeExtension.typeByJsonKey(key),
    level: AmpelLevelExtension.getAmpelLevelByInt(json['level']),
    validFrom: json['validFrom']
  );

}

class AmpelResponse{
  late List<Ampel> results;

  AmpelResponse.fromJson(Map<String, dynamic> json){
    results = [];
    for(var a in json.entries){
      results.add(Ampel.fromJson(a.value, a.key));
    }
  }

}