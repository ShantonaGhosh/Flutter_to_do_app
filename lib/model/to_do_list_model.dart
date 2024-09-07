import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'to_do_list_model.g.dart';

@HiveType(typeId: 1)
class ToDoListModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? time;

  @HiveField(2)
  DateTime? date;

  @HiveField(3)
  Uint8List? imageData;

  ToDoListModel({
    this.title,
    this.time,
    this.date,
    this.imageData,
  });
}
