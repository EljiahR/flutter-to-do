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

  UnmodifiableListView<ToDoItem> get items => UnmodifiableListView(_items);

  void addItem(String content) {
    if (content.isEmpty) return;
    _items.add(ToDoItem(content));
    controller.clear();
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
                  return ToDoList();
                },
                ),
            ),
            SafeArea(
              child: Consumer<ToDoModel>(
                builder: (context, todo, child) => TextField(
                  controller: todo.controller,
                  onSubmitted: (value) => todo.addItem(value),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}

class ToDoList extends StatelessWidget {
  const ToDoList({super.key,});


  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<ToDoModel>(context);

    return ListView.separated(
      itemCount: todo.items.length,
      itemBuilder: (context, index) {
        final item = todo.items[index];
        return ListTile(
          leading: Checkbox(
            value: item.isChecked,
            onChanged: (_) => todo.toggleItemCheck(index),
          ),
          title: Text(item.content),
          trailing: IconButton(
            onPressed: () => todo.deleteItem(index), 
            icon: Icon(Icons.delete)
          ),
        );
      },
      separatorBuilder:(context, index) => Divider(),
    );
  }
}
