import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ToDoModel(),
    child: MyApp()
  ));
}

class ToDoItem {
  String content;
  bool isChecked = false;
  ToDoItem(this.content);

  void toggleCheck() {
    isChecked = !isChecked;
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To-do App'),
    );
  }
}

class ToDoModel extends ChangeNotifier {
  final List<ToDoItem> _items = [];
  var controller = TextEditingController();

  List<ToDoItem> getList() {
    return _items;
  }

  void addItem(String content) {
    _items.add(ToDoItem(content));
    controller.clear();
    notifyListeners();
  }

  void toggleItemCheck(ToDoItem item) {
    item.toggleCheck();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title
  });

  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ToDoModel>(
                builder: (context, todo, child) {
                  return ToDoList(todo: todo);
                },
                ),
            ),
            SafeArea(
              child: TextField(
                controller: Provider.of<ToDoModel>(context).controller,
                onSubmitted: (value) => Provider.of<ToDoModel>(context, listen: false).addItem(value),
              ) 
            )
          ],
        ),
      )
    );
  }
}

class ToDoList extends StatelessWidget {
  const ToDoList({
    super.key,
    required this.todo
  });

  final ToDoModel todo;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var item in todo.getList())
          Row(
            children: [
              Checkbox(
                value: item.isChecked, 
                onChanged: (value) => todo.toggleItemCheck(item)
              ),
              Text(item.content)
            ],
          )
      ],
    );
  }
}
