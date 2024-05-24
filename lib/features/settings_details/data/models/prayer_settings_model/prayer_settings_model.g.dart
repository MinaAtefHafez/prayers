// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerSettingsModelAdapter extends TypeAdapter<PrayerSettingsModel> {
  @override
  final int typeId = 0;

  @override
  PrayerSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerSettingsModel(
      isShow: fields[1] as bool?,
      minutes: fields[2] as int?,
      isNotify: fields[3] as bool?,
      prayerName: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerSettingsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.prayerName)
      ..writeByte(1)
      ..write(obj.isShow)
      ..writeByte(2)
      ..write(obj.minutes)
      ..writeByte(3)
      ..write(obj.isNotify);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
