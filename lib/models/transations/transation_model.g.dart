// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class transationModelAdapter extends TypeAdapter<transationModel> {
  @override
  final int typeId = 3;

  @override
  transationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return transationModel(
      purpose: fields[0] as String,
      amound: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as Categorytype,
      category: fields[4] as Categorymodel,
    )..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, transationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amound)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is transationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
