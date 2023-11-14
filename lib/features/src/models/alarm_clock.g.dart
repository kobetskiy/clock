// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_clock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmClockAdapter extends TypeAdapter<AlarmClock> {
  @override
  final int typeId = 0;

  @override
  AlarmClock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmClock(
      isOn: fields[1] as bool,
      id: fields[0] as int,
      hours: fields[2] as int,
      minutes: fields[3] as int,
      description: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmClock obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isOn)
      ..writeByte(2)
      ..write(obj.hours)
      ..writeByte(3)
      ..write(obj.minutes)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmClockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
