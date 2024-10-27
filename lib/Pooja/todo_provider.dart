import 'package:flutter/material.dart';
import 'package:list_todo/Pooja/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todoList = [];
  String _filter = 'All';

  List<Todo> get todoList {
    if (_filter == 'Completed') {
      return _todoList.where((todo) => todo.isCompleted).toList();
    } else if (_filter == 'Pending') {
      return _todoList.where((todo) => !todo.isCompleted).toList();
    }
    return _todoList;
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTodoItem(String task, DateTime date, bool isHighPriority, String category) {
    _todoList.add(Todo(
      task: task,
      date: date,
      isHighPriority: isHighPriority,
      category: category,
    ));
    notifyListeners();
  }

  void removeTodoItem(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    _todoList[index].isCompleted = !_todoList[index].isCompleted;
    notifyListeners();
  }
}