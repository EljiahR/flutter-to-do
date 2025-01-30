import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/to_do_provider.dart';

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