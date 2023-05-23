import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late String text;

  @HiveField(1)
  late bool isDone;

  Todo({
    required this.text,
    this.isDone = false,
  });
}
