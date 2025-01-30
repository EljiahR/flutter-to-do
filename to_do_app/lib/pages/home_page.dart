import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/to_do_provider.dart';
import '../widgets/to_do_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: todo.controller,
                    onSubmitted: (value) => todo.addItem(value),
                    focusNode: todo.focusNode,
                    decoration: InputDecoration(
                      hintText: "Enter a new item...",
                      border: OutlineInputBorder()
                    ),
                  ),
              ),
            )
          ],
        ),
      )
    );
  }
}