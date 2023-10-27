// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend_rating.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendRatingAdapter extends TypeAdapter<TrendRating> {
  @override
  final int typeId = 3;

  @override
  TrendRating read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TrendRating.negative;
      case 1:
        return TrendRating.neutral;
      case 2:
        return TrendRating.positive;
      default:
        return TrendRating.negative;
    }
  }

  @override
  void write(BinaryWriter writer, TrendRating obj) {
    switch (obj) {
      case TrendRating.negative:
        writer.writeByte(0);
        break;
      case TrendRating.neutral:
        writer.writeByte(1);
        break;
      case TrendRating.positive:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendRatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
