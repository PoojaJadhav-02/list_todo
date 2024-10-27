import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';

class TaskModel {
 final String tasks;
 final bool isCompleted;
 final DateTime date;


 TaskModel({required this.date, required this.tasks, required this.isCompleted,});

  factory TaskModel.fromMap(Map<String, dynamic> map)=>
      TaskModel(tasks: map["taskName"], isCompleted: map["isCompleted"],date: map["dateTime"]);

  Map<String, dynamic> toMap() =>
      {
        "tasks": tasks,
        "isCompleted": isCompleted,
        "dateTime":date
      };
}

  // List<Map<String, dynamic>>getMapDataFromTaskModel(List<TaskModel> data)=>                   //
  //     data.map((ele)=>ele.toMap()).toList();                                                 //

  List<TaskModel>getTaskFromString(String data)=>
      jsonDecode(data).map((x)=>TaskModel.fromMap(x)).toList();

  // List<TaskModel> getTaskFromMap(List<dynamic> data) =>                          //
  //     data.map((ele)=>TaskModel.fromMap(ele)).toList();                          //




























  // static List<TaskModel>? tasks(){
  //   return [
  //     TaskModel( tasks: "Morning Exercise", isCompleted: true),
  //     TaskModel( tasks: "BreakFast"),
  //     TaskModel( tasks: "Check Emails", isCompleted: true),
  //     TaskModel( tasks: "Team Meeting",isCompleted: false),
  //     TaskModel( tasks: "Work on Mobile apps for 2 hour")
  //   ];
  // }
