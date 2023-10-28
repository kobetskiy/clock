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
      isOn: fields[0] as bool,
      time: fields[1] as String,
      description: fields[2] as String,
      id: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmClock obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isOn)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.id);
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
