import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
      title: "To-do App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ToDoProvider(),
        child: MyHomePage()
  ),
    );
  }
}

class ToDoProvider extends ChangeNotifier {
  final List<ToDoItem> _items = [];
  final controller = TextEditingController();

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
  });
  
  @override
  Widget build(BuildContext context) {
    final todo = context.read<ToDoProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ToDoList(),
            ),
            SafeArea(
              child: TextField(
                  controller: todo.controller,
                  onSubmitted: (value) => todo.addItem(value),
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
    final todo = context.watch<ToDoProvider>();

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
