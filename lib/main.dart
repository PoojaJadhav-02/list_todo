
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_todo/screen/list_task.dart';
import 'package:list_todo/screen/splash_screen.dart';
//import 'controller/firebase_controller.dart';
import 'controller/firebase_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android
  );

  //Get.put(FirebaseController());                                                 // create instance and initialize
  Get.lazyPut(()=>FirebaseController());                                        // jevha aaplyala garaj ahe as vatate tevha instance tayar karnar(find)

  return runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
   //   theme: ThemeData.dark(),
       home:SplashScreen()
    );
  }
}







//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:list_todo/screen/register_screen.dart';
// import 'package:list_todo/screen/splash_screen.dart';
// import 'package:provider/provider.dart';
//
// import 'Pooja/todo_list.dart';
// import 'Pooja/todo_provider.dart';
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.android
//   );
//   return runApp( TodoApp());
// }
//
// class TodoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TodoProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const SplashScreen(),
//           '/todo': (context) => TodoListScreen(),
//         },
//       ),
//     );
//   }
// }
//














/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDateTime;

  void _addTask() {
    if (_taskController.text.isNotEmpty && _selectedDateTime != null) {
      setState(() {
        _tasks.add({
          'task': _taskController.text,
          'dateTime': _selectedDateTime,
        });
        _taskController.clear();
        _selectedDateTime = null;
      });
    }
  }

  void _selectDateTime() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (dateTime) {
        setState(() {
          _selectedDateTime = dateTime;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime!)
                        : 'No Date/Time selected',
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectDateTime,
                  child: Text('Pick Date/Time'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(task['task']),
                    subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(task['dateTime'])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */







/*
// Create week date picker with passed parameters
Widget buildWeekDatePicker (DateTime selectedDate, DateTime firstAllowedDate, DateTime lastAllowedDate, ValueChanged<DatePeriod> onNewSelected) {

  // add some colors to default settings
  DatePickerRangeStyles styles = DatePickerRangeStyles(
    selectedPeriodLastDecoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0))),
    selectedPeriodStartDecoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10.0), bottomStart: Radius.circular(10.0)),
    ),
    selectedPeriodMiddleDecoration: BoxDecoration(
        color: Colors.yellow, shape: BoxShape.rectangle),
  );

  return WeekPicker(
      selectedDate: selectedDate,
      onChanged: onNewSelected,
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
      datePickerStyles: styles
  );
}
 */













/*
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDateTime;

  // Method to add task to the list
  void _addTask() {
    if (_taskController.text.isNotEmpty && _selectedDateTime != null) {
      setState(() {
        _tasks.add({
          'task': _taskController.text,
          'dateTime': _selectedDateTime,
        });
        _taskController.clear();
        _selectedDateTime = null;
      });
    }
  }

  // Method to show date and time picker
  void _selectDateTime() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (dateTime) {
        setState(() {
          _selectedDateTime = dateTime;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Field to enter task description
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // DateTime picker row
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime!)
                        : 'No Date/Time selected',
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectDateTime,
                  child: Text('Pick Date/Time'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Button to add task to the list
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 16),
            // Display the list of tasks
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(task['task']),
                    subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(task['dateTime'])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
