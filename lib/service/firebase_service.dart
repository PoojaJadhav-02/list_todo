import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'firestoredb_service.dart';

class FirebaseService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseDbService _firebaseDbService = FirebaseDbService();



  Future<User?>loginUser(String username, String password)async{
    try {
     // final UserCredential response = await _firebaseAuth.createUserWithEmailAndPassword(email: username, password: password);            //   you are used different email id not same email id are used.
      final UserCredential response = await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);                  // used same email id again and again
      if (response.user != null) {
        await _firebaseDbService.createDatabase(username);
        return response.user;
      }
      return null;
    }catch(e){
      log("Error in  User  Login Authenticating $e");
      return null;
    }
  }


  Future<User?>registerUser(String username, String password)async{
    try {
      final UserCredential response = await _firebaseAuth.createUserWithEmailAndPassword(email: username, password: password);            //   you are used different email id not same email id are used.
      //   final UserCredential response = await _firebaseAuth.signInWithEmailAndPassword(email: username, password: password);                  // used same email id again and again

      if (response.user != null) {
        await _firebaseDbService.createDatabase(username);
        return response.user;
      }
      return null;
    }catch(e){
      log("Error in  User Register Authenticating $e");
      return null;
    }
  }
}





// Change 1