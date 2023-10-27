import 'package:hive/hive.dart';

part 'trend.g.dart';

@HiveType(typeId: 2)
enum Trend{
  @HiveField(0)
  upStrong,
  @HiveField(1)
  upMild,
  @HiveField(2)
  neutral,
  @HiveField(3)
  downMild,
  @HiveField(4)
  downStrong
}


extension TrendExtension on Trend{

  String get apiTitle{
    switch(this){
      case Trend.upStrong:
        return 'up_strong';
      case Trend.upMild:
        return 'up_mild';
      case Trend.neutral:
        return 'neutral';
      case Trend.downMild:
        return 'down_mild';
      case Trend.downStrong:
        return 'down_strong';
    }
  }

}