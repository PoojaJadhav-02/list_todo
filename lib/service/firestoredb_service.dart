import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_todo/model/task_model.dart';

class FirebaseDbService{
  final db = FirebaseFirestore.instance;

  static const userCollection = "Users Data";

  Future<bool> createDatabase(String userName)async{
   await db.collection(userCollection).doc(userName).set({});
          print(["TodoTaskList"]);
   return true;
  }

  // getTaskFromDb(String userName)async{                                              //
  //  try{
  //     final data = await db.collection(userCollection).doc(userName).get();
  //     if(data.data()!=null){
  //       print(data.data()!["TodoTaskList"]);
  //       return getTaskFromMap(data.data()!["TodoTaskList"]);
  //     }
  //   }catch(e){
  //    print("Not found any data $e");
  //    return false;
  //  }
  // }                                                                //


  Future<bool> addTaskInDb(String userName, TaskModel model)async{
    try {
       // List<TaskModel> data = await getTaskFromDb(userName);   //
       // data.add(model);                                        //
     await db.collection(userCollection).doc(userName).set(                                                  // set ha data la override karte
         {"TodoTaskList":[model.toMap()]});
       //   {"TodoTaskList": getMapDataFromTaskModel(data)});     //
      return true;
    }catch(e){
      print("Error while adding the data | $e");
      return false;
    }
    }
  }

