import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_todo/screen/list_task.dart';
import 'package:list_todo/screen/register_screen.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold (
      backgroundColor: Colors.purple,
      body: SafeArea(
          child: Center(
          child: Container(

              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only( top: 20,),

            decoration: const BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/todoimage.jpg"),
                  fit: BoxFit.fill
              ),
            ),
              child: const Text("Todo List",style: TextStyle(
                  color: Colors.black,
                  fontSize: 33
              ),
              ),
            ),
          ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: IconButton(onPressed: (){
               Get.to(()=>const MyRegister());
          },tooltip: "Next",
            icon: const Icon(Icons.arrow_forward,color: Colors.white,),
          ),
          ),
        ],
      )
      );
  }
}
