import 'package:hive/hive.dart';

part 'trend_rating.g.dart';

@HiveType(typeId: 3)
enum TrendRating{
  @HiveField(0)
  negative,
  @HiveField(1)
  neutral,
  @HiveField(2)
  positive
}


extension TrendRatingExtension on TrendRating{

  String get apiTitle{
    switch(this){
      case TrendRating.negative:
        return 'negativ';
      case TrendRating.neutral:
        return 'neutral';
      case TrendRating.positive:
        return 'positiv';
    }
  }

}