import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:list_todo/service/firebase_service.dart';

class FirebaseController extends GetxController{

  final FirebaseService _firebaseService = FirebaseService();

  RxBool isLoading = false.obs;

  Future<User?> loginUser(String userName, String password)async{
    return await _firebaseService.loginUser(userName, password);
  }

  Future<User?> registerUser(String userName, String password)async{
    return await _firebaseService.registerUser(userName, password);
  }


}