import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo_item.dart';


class ToDoProvider extends ChangeNotifier {
  final _todoBox = Hive.box<ToDoItem>("todos");


  final controller = TextEditingController();
  final focusNode = FocusNode();

  List<ToDoItem> get items => _todoBox.values.toList();

  void addItem(String content) {
    if (content.isEmpty) return;
    
    final newItem = ToDoItem(content: content);
    _todoBox.add(newItem);
    controller.clear();
    focusNode.requestFocus();
    notifyListeners();
  }

  void toggleItemCheck(ToDoItem item) {
    item.toggleCheck();
    notifyListeners();
  }

  void deleteItem(int index) {
    _todoBox.deleteAt(index);
    notifyListeners();
  }
}