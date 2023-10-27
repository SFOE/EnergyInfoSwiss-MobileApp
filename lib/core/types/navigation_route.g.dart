// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_route.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NavigationRouteAdapter extends TypeAdapter<NavigationRoute> {
  @override
  final int typeId = 4;

  @override
  NavigationRoute read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NavigationRoute.overview;
      case 1:
        return NavigationRoute.energy;
      case 2:
        return NavigationRoute.gas;
      case 3:
        return NavigationRoute.price;
      case 4:
        return NavigationRoute.weather;
      default:
        return NavigationRoute.overview;
    }
  }

  @override
  void write(BinaryWriter writer, NavigationRoute obj) {
    switch (obj) {
      case NavigationRoute.overview:
        writer.writeByte(0);
        break;
      case NavigationRoute.energy:
        writer.writeByte(1);
        break;
      case NavigationRoute.gas:
        writer.writeByte(2);
        break;
      case NavigationRoute.price:
        writer.writeByte(3);
        break;
      case NavigationRoute.weather:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationRouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
