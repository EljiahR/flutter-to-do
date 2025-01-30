class ToDoItem {
  String content;
  bool isChecked = false;
  ToDoItem(this.content);

  void toggleCheck() {
    isChecked = !isChecked;
  }

}