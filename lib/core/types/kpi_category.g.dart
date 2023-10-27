// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KPICategoryAdapter extends TypeAdapter<KPICategory> {
  @override
  final int typeId = 1;

  @override
  KPICategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KPICategory.energy;
      case 1:
        return KPICategory.gas;
      case 2:
        return KPICategory.price;
      case 3:
        return KPICategory.weather;
      default:
        return KPICategory.energy;
    }
  }

  @override
  void write(BinaryWriter writer, KPICategory obj) {
    switch (obj) {
      case KPICategory.energy:
        writer.writeByte(0);
        break;
      case KPICategory.gas:
        writer.writeByte(1);
        break;
      case KPICategory.price:
        writer.writeByte(2);
        break;
      case KPICategory.weather:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KPICategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
