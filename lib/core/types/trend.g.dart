// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendAdapter extends TypeAdapter<Trend> {
  @override
  final int typeId = 2;

  @override
  Trend read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Trend.upStrong;
      case 1:
        return Trend.upMild;
      case 2:
        return Trend.neutral;
      case 3:
        return Trend.downMild;
      case 4:
        return Trend.downStrong;
      default:
        return Trend.upStrong;
    }
  }

  @override
  void write(BinaryWriter writer, Trend obj) {
    switch (obj) {
      case Trend.upStrong:
        writer.writeByte(0);
        break;
      case Trend.upMild:
        writer.writeByte(1);
        break;
      case Trend.neutral:
        writer.writeByte(2);
        break;
      case Trend.downMild:
        writer.writeByte(3);
        break;
      case Trend.downStrong:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
