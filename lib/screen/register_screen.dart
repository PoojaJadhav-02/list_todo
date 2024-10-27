import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_todo/screen/list_task.dart';
import 'package:list_todo/screen/login_page.dart';
//import 'package:list_todo/service/firebase_controller.dart';
import 'package:list_todo/service/firestoredb_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/firebase_controller.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  // final FirebaseController _firebaseController = Get.put(FirebaseController());
  final FirebaseController _firebaseController = Get.find<FirebaseController>();                                                  //this <> angle braces are nothing but the controller



  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Colors.black38, Colors.black])),
        image: DecorationImage(
            image: AssetImage("assets/login-background.png"),
            fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only( top: 100,),
              child: const Text("Register",style: TextStyle(
                  color: Colors.white,
                  fontSize: 35
              ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.3,
                  right: 35,
                  left: 35,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        validator:(username){
                          if(username!.isEmpty){
                            return "This is  required";
                           }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),

                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.person,color: Colors.black,),
                          fillColor: Colors.white70,
                          filled: true,
                        //  label: const Text("Name",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          hintText: "Enter Your Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                        style: const TextStyle(color: Colors.black),

                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.email_outlined,color: Colors.black,),
                          fillColor: Colors.white70,
                          filled: true,
                         // label: const Text("Email",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          hintText: "Enter Your Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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

                        style: const TextStyle(color: Colors.black),

                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                              hoverColor: Colors.grey.shade700,
                              icon: Icon(passwordVisible? Icons.visibility_off: Icons.visibility,color: Colors.black,)),
                          fillColor: Colors.white70,
                          filled: true,
                        //  label: const Text("Password",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          hintText: "Enter Your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: confirmPasswordVisible,
                        controller: _confirm,
                        validator: (val){
                          if(val!.isEmpty){
                            return "This is required";
                          }if(val.length<8){
                            return 'Please Enter Correct Password';
                          }
                          return null;
                        },

                        style: const TextStyle(color: Colors.black),

                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                              hoverColor: Colors.grey.shade700,
                              icon: Icon(confirmPasswordVisible? Icons.visibility_off: Icons.visibility,color: Colors.black,)),
                          fillColor: Colors.white70,
                          filled: true,
                       //   label: const Text("Confirm Password",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          hintText: "Enter Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(
                        ()=> AnimatedContainer(
                          duration: const Duration(seconds: 4),
                          child: _firebaseController.isLoading.value?const LinearProgressIndicator():Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.greenAccent,
                                    shape: RoundedRectangleBorder
                                      (borderRadius: BorderRadius.circular(20))),
                                onPressed: () async {
                                  if(_formkey.currentState!.validate()){
                                    final User? user = await _firebaseController
                                        .registerUser(_username.text, _password.text);
                                    _password.clear();
                                    _username.clear();
                                    _confirm.clear();
                                    _name.clear();
                                    _firebaseController.isLoading.value = true;
                                    if (user != null) {
                                      Get.to(() => const MyLogin());
                                      Get.snackbar("Successfully Registered !", "",
                                          maxWidth: double.infinity,
                                          backgroundColor: Colors.black,
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.green);
                                     // _firebaseController.isLoading.value = false;
                                    }
                                  }
                                }, child: const Text(
                                "Register", style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height:20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {
                            Get.to(() => const MyLogin());
                          },
                              child: const Row(
                                children: [
                                  Text("Already have an account?",
                                    style: TextStyle(color: Colors.white),),
                                 Text(" Login",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),)
                                ],
                              ),
                          ),
                        ],
                      )

                      //     const SizedBox(width: 10,),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         TextButton(onPressed: (){}, child: const Text(
                      //          "Forgot Password?", style: TextStyle(
                      //          // decoration: TextDecoration.underline,
                      //           fontSize: 18,
                      //           color: Colors.blueAccent,
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




