import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/to_do_provider.dart';
import '../widgets/to_do_list.dart';

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