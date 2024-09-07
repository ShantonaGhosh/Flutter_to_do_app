// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoListModelAdapter extends TypeAdapter<ToDoListModel> {
  @override
  final int typeId = 1;

  @override
  ToDoListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoListModel(
      title: fields[0] as String?,
      time: fields[1] as String?,
      date: fields[2] as DateTime?,
      imageData: fields[3] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.imageData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
