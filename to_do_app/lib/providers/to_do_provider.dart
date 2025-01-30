import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/to_do_item.dart';


class ToDoProvider extends ChangeNotifier {
  final List<ToDoItem> _items = [];
  final controller = TextEditingController();
  final focusNode = FocusNode();

  UnmodifiableListView<ToDoItem> get items => UnmodifiableListView(_items);

  void addItem(String content) {
    if (content.isEmpty) return;
    _items.add(ToDoItem(content));
    controller.clear();
    focusNode.requestFocus();
    notifyListeners();
  }

  void toggleItemCheck(int index) {
    _items[index].toggleCheck();
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}