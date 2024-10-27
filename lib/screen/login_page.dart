import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_todo/screen/list_task.dart';
import 'package:list_todo/screen/register_screen.dart';
//import 'package:list_todo/service/firebase_controller.dart';
import 'package:list_todo/service/firestoredb_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/firebase_controller.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  // final FirebaseController _firebaseController = Get.put(FirebaseController());
  final FirebaseController _firebaseController = Get.find<FirebaseController>();                                                  //this <> angle braces are nothing but the controller


  
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
         // gradient: LinearGradient(
           //   colors: [Colors.greenAccent, Colors.purpleAccent])),
        image: DecorationImage(
            image: AssetImage("assets/back image.png"),
            fit: BoxFit.cover
       ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only( top: 200,),
              child: const Text("Login",style: TextStyle(
                  color: Colors.black,
                  fontSize: 35
              ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.43,
                  right: 35,
                  left: 35,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _username,
                        validator:(username){
                          if(username!.isEmpty){
                            return "Email should not be empty";
                          }else if(!username.contains("@")){
                            return "Email is invalid";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.email_outlined,color: Colors.white54,),
                      fillColor: Colors.black,
                          filled: true,
                          label: const Text("Email",style: TextStyle(color: Colors.white,fontSize: 15)),
                          hintText: "Enter Your Email ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: passwordVisible,
                        controller: _password,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Password should not be empty";
                          }if(val.length<8){
                              return 'Please use some Characters, Symbols,\n and Numbers';
                          }
                          return null;
                        },

                        style: const TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                              hoverColor: Colors.grey.shade700,
                              icon: Icon(passwordVisible? Icons.visibility_off: Icons.visibility,color: Colors.white,)),
                          fillColor: Colors.black,
                          filled: true,
                          label: const Text("Password",style: TextStyle(color: Colors.white,fontSize: 15),),
                          hintText: "Enter Your Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),


                     // ElevatedButton(onPressed: (){}, child: const Text("")),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder
                                  (borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if(_formkey.currentState!.validate()){
                                final User? user = await _firebaseController
                                    .loginUser(_username.text, _password.text);
                                _password.clear();
                                _username.clear();
                                if (user != null) {
                                  Get.to(() => ListTask("${user.email}"));
                                  Get.snackbar("Successfully Login !", "",
                                      maxWidth: double.infinity,
                                      backgroundColor: Colors.black,
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.green);
                                }
                              }
                          }, child: const Text(
                            "Log in", style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(height:20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {
                           Get.to(() => const MyRegister());
                          },
                              child: const Row(
                                children: [
                                  Text("Don't have an account?",
                                    style: TextStyle(color: Colors.black),),
                                  Text(" Register",
                                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 16),),
                                ],
                              ),
                          ),
                        ],
                      ),

                      //     const SizedBox(width: 10,),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         TextButton(onPressed: (){}, child: const Text(
                      //          "Forgot Password?", style: TextStyle(
                      //          // decoration: TextDecoration.underline,
                      //           fontSize: 18,
                      //           color: Colors.black,
                      //         ),
                      //         ),
                      //         ),
                      //   ],
                      // ),

                  ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
















/*
 const SizedBox(width: 10,),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Icon(Icons.arrow_back)
                    ),
                  ])
 */

