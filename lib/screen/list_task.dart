/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_todo/model/task_model.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  final List<String> tasks = [];
  final List<bool> isCompleted = [];
    final List<DateTime> date = [];

  final TextEditingController _taskController = TextEditingController();

  void addNewTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(_taskController.text);
        isCompleted.add(false);
        _taskController.clear();
      });
    }
  }

  void taskCompleted(int index) {
    setState(() {
      isCompleted[index] = !isCompleted[index];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      isCompleted.removeAt(index);
    });
  }

  void editTask(int index, updatedTask) {
    String updatedTask = _taskController.text;
    if (updatedTask.isNotEmpty) {
      setState(() {
        tasks[index] = updatedTask;
        isCompleted[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Daily Routine TimeTable",
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: "Add Task",
        onPressed: () {
          _showDialog();
        },
        child: const Text("+"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "No tasks yet. Add some task!",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                tasks[index],
                                style: TextStyle(
                                    decoration: isCompleted[index]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: isCompleted[index]
                                        ? Colors.grey.shade600
                                        : Colors.black),
                              ),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        taskCompleted(index);
                                      },
                                      icon: Icon(
                                        isCompleted[index]
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: isCompleted[index]
                                            ? Colors.green
                                            : null,
                                      )),
                                  IconButton(
                                      tooltip: "Delete",
                                      onPressed: () {
                                        deleteTask(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      )),
                                  IconButton(
                                      tooltip: "Edit",
                                      onPressed: () {
                                        promptTaskDialog(title: "Edit Task");
                                        editTask(index, String);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              onTap: () => taskCompleted(index),
                            ),
                          );
                        })),
          ],
        ),
      ),
    );
  }

  _showDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                  hintText: "Task Name", label: Text("Task Name")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                 // autofocus: false,
                  onPressed: () {
                    _taskController.clear();
                    // Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                //  autofocus: true,
                    onPressed: () {
                      addNewTask();
                      Navigator.pop(context);
                    },
                    child: const Text("Save")),
              ],
            )
          ],
        ),
      ),
    );
  }

  promptTaskDialog({
    required String title,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: _taskController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Enter task'),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

              TextButton(
                child: const Text('Save'),
                onPressed: () {
                 // addNewTask();
                 // editTask();
                  // onSubmit(_textController.text);
                  Navigator.pop(context);
                },
              ),
             ] )
            ],
          );
        });
  }
}
 */







import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
//import 'package:list_todo/db_controller.dart';
import 'package:list_todo/model/task_model.dart';
import 'package:list_todo/screen/splash_screen.dart';
import '../controller/db_controller.dart';


class ListTask extends StatefulWidget {
  const ListTask(String s, {super.key});

  @override
  _ListTaskState createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {

  final List<Map<String, dynamic>> tasks = [
    {"task": "Wake up Early Morning", "completed": false, "date":DateTime},
    {"task": "Morning Exercise", "completed": false, "date":DateTime},
    {"task": "Breakfast", "completed": false, "date":DateTime},
    {"task": "Check Emails", "completed": false, "date":DateTime},
    {"task": "Team Meeting", "completed": false, "date":DateTime},
    {"task": "Work on Mobile apps for 2 hours", "completed": false, "date": DateTime},
  ];
 // final List<Map<String, dynamic>> tasks = [];


  DateTime? _selectedDate;

  final dbController = Get.put(DbController());
  final TextEditingController _textController = TextEditingController();
   final TextEditingController _controller = TextEditingController();

 //  List<TaskModel> data = [];              //


  void addTask(String task){
    if (task.isNotEmpty && _selectedDate != dbController) {
      setState(() {
        tasks.add({"task": task, "completed": false, "dateTime": DateTime,});

      //  data = dbController.fetchAllTask(widget.toString()) as List<TaskModel>;                   //

      });
      _textController.clear();
      _controller.clear();
    }
  }

  void editTask(int index, String updatedTask) {
    //     if (updatedTask.isNotEmpty && _selectedDate != null) {
    if (updatedTask.isNotEmpty ) {
      setState(() {
        tasks[index]["task"] = updatedTask;
     //   _selectedDate;
      });
    }
  }

  void taskCompleted(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void BottomSheet(
      {required String title,
        required String initialTask,
        required Function(String) onSubmit}) {
    _textController.text = initialTask ?? '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _textController,
                autofocus: true,
                decoration: const InputDecoration(labelText: "Enter task"),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller:  _controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: "Enter Date" ),
              )
            ],
          ),

          actions: [
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.black),
                    onPressed: () {
                      _pickDate(context);
                    }
                ),
              ],
            ),
            const SizedBox(width: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(width: 5,),
            Row(
          //    mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    dbController.addTask(widget.toString(),
                        TaskModel(tasks: _textController.text,
                      isCompleted: false, date:DateTime.now(),));
                    print(DateTime.now());
                    onSubmit(_textController.text);
                    _selectedDate;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildTaskItem(Map<String, dynamic> task, int index) {
   // final task = tasks[index];                                                 ///date
    return ListTile(
      title: Text(
        task["task"],
        style: TextStyle(
          decoration: task["completed"]
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),


    //   subtitle: Column(
    //       children: [
    //   task["dateTime"](),
    //   ]
    // ),


      // subtitle: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text('date: ${DateFormat('yyyy-MM-dd').format(task["dateTime"])}',
      //           style: const TextStyle(color: Colors.black)),
      //   ],
      // ),


      leading: Checkbox(
        hoverColor: Colors.white38,
        checkColor: Colors.green,
        value: task["completed"],
        onChanged: (bool? value) {
          taskCompleted(index);
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            hoverColor: Colors.white38,
            tooltip: "Edit",
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              BottomSheet(
                title: "Edit Task",
                initialTask: task["task"],
                onSubmit: (updatedTask) => editTask(index, updatedTask),
              );
            },
          ),
          IconButton(
            hoverColor: Colors.white38,
            tooltip: "Delete",
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              deleteTask(index);
              ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                clipBehavior: Clip.hardEdge,
                content: Text("   Delete Successfully",style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
              ));
              // Get.snackbar(" Delete Successfully ", "",
              //     maxWidth: double.infinity,
              //     backgroundColor: Colors.white,
              //     snackPosition: SnackPosition.BOTTOM,
              //     colorText: Colors.black
              // );
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: const Text("Daily Routine Schedule",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
      IconButton(
        focusColor: Colors.grey.shade200,
        tooltip: "Logout",
      icon: const Icon(Icons.logout, color: Colors.redAccent),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.purpleAccent]),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.blueAccent])),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return buildTaskItem(tasks[index], index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BottomSheet(
            title: "Add New Task",
            onSubmit: (newTask) => addTask(newTask),
            initialTask: "",
          );
        },
        hoverColor: Colors.grey.shade300,
        tooltip: "Add Task",
        child: const Icon(Icons.add),
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









//
//
// return _pickDate(
// _selectedDate: _selectedDate,
// onChanged: onNewSelected,
// initialDate: DateTime.now(),
// firstDate: DateTime(2000),
// lastDate: DateTime(2101),
// datePickerStyles: styles


















/*
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';
import '../models/todo_model.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('My Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return Column(
            children: [
              Expanded(
                child: todoProvider.todoList.isEmpty
                    ? Center(child: Text('No tasks available.', style: TextStyle(fontSize: 18,)))
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
        color: Colors.teal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    hintStyle: TextStyle(color: Colors.white),

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.black),
                onPressed: () => _pickDate(context),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                  Text('High Priority', style: TextStyle(fontWeight: FontWeight.bold,)),
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
                icon: Icon(Icons.add_circle, color: Colors.black, size: 30),
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
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            Text('Due: ${DateFormat('yyyy-MM-dd').format(todo.date)}', style: TextStyle(color: Colors.black)),
            Text('Category: ${todo.category}', style: TextStyle(color: Colors.black)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
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

 */