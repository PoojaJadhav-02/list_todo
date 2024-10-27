import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:list_todo/model/task_model.dart';
import 'package:list_todo/service/firestoredb_service.dart';

class DbController extends GetxController{

  // List data = [];                      //

  final FirebaseDbService _firebaseDbService = FirebaseDbService();

  Future<bool> addTask(String userName, TaskModel model)async{
    return _firebaseDbService.addTaskInDb(userName, model);
  }

  // Future<List<TaskModel>>fetchAllTask(String userName)async{                  //
  //   return _firebaseDbService.getTaskFromDb(userName);
  // }
}