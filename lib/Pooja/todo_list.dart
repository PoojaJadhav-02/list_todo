
import 'package:flutter/material.dart';
import 'package:list_todo/Pooja/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
  bool _isHighPriority = false;
  String _selectedCategory = 'General';
  final List<String> _categories = ['General', 'Work', 'Personal', 'Health', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      appBar: AppBar(

        backgroundColor: Colors.blueAccent.shade100,

        title: const Text('My Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Provider.of<TodoProvider>(context, listen: false).setFilter(value);
            },
            itemBuilder: (BuildContext context) {
              return {'All', 'Completed', 'Pending'}.map((String choice) {
                return PopupMenuItem<String>(

                  value: choice,
                  child: Text(choice,),

                );
              }).toList();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return Column(
            children: [
              Expanded(
                child: todoProvider.todoList.isEmpty
                    ? const Center(child: Text('No tasks available.', style: TextStyle(fontSize: 18,)))
                    : ListView.builder(
                  itemCount: todoProvider.todoList.length,
                  itemBuilder: (context, index) {
                    return _buildTodoItem(context, todoProvider, index);
                  },
                ),
              ),
              _buildInputSection(todoProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputSection(TodoProvider todoProvider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        //color: Colors.teal,
        gradient: const LinearGradient(
            colors: [ Colors.white38,Colors.blueAccent]
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10)],
      ),
      child: Column(
        children: [

          Row(
            children: [
              Expanded(

                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new task',
                    hintStyle: const TextStyle(color: Colors.black),

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                  ),
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () => _pickDate(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  const Text('High Priority', style: TextStyle(fontWeight: FontWeight.bold,)),
                  Switch(
                    value: _isHighPriority,
                    onChanged: (value) {
                      setState(() {
                        _isHighPriority = value;
                      });
                    },
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.white, size: 30),
                onPressed: () {
                  if (_controller.text.isNotEmpty && _selectedDate != null) {
                    todoProvider.addTodoItem(
                      _controller.text,
                      _selectedDate!,
                      _isHighPriority,
                      _selectedCategory,
                    );
                    _controller.clear();
                    setState(() {
                      _selectedDate = null;
                      _isHighPriority = false;
                      _selectedCategory = 'General';
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(BuildContext context, TodoProvider todoProvider, int index) {
    final todo = todoProvider.todoList[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            todoProvider.toggleTodoStatus(index);
          },
          activeColor: Colors.blue,
        ),
        title: Text(
          todo.task,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: todo.isHighPriority ? Colors.red : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due: ${DateFormat('yyyy-MM-dd').format(todo.date)}', style: const TextStyle(color: Colors.black)),
            Text('Category: ${todo.category}', style: const TextStyle(color: Colors.black)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.purpleAccent),
          onPressed: () {
            todoProvider.removeTodoItem(index);
          },
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}