import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 1)
class ToDoItem extends HiveObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  bool isChecked;

  ToDoItem({required this.content, this.isChecked = false});

  void toggleCheck() {
    isChecked = !isChecked;
    save();
  }
}