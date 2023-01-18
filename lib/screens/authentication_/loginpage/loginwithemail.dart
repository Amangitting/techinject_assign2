// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:new_assesment/screens/authentication_/signup/signupwithemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:new_assesment/screens/postscreen/postscreen.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _key=GlobalKey<FormState>();

  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ElevatedButton(
          onPressed: () {
            if(_key.currentState!.validate()){
              _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value) {
                Get.snackbar("succesfully logged in", "Logged In");
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Postscreen(
                  email: emailcontroller.text.toString(),
                )));
              }).onError((error, stackTrace) {
Get.snackbar("error", error.toString().substring(30));           });
            }
            
          },
          child:Text("login") ),
      ),
      appBar: AppBar(
        title: const Text("Login with email"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Form(
            key: _key,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    validator: ((value){
                      if(value==null|| value.isEmpty){
                        return "fill emailadress";
                      }
                      if(!value.contains("@")){
                        return "fill proper emailadress";
                      }
                    }),
          
                    
                    
                    decoration: InputDecoration(hintText: "email"),
                    keyboardType:TextInputType.emailAddress,
                    controller: emailcontroller,
                  ),
                ),
               
                TextFormField(
                  validator:((value){
                      if(value==null|| value.isEmpty){
                        return "fill emailadress";
                      }
                      
                    }) ,
                  decoration: InputDecoration(hintText: "password"),
                  controller: passwordcontroller,
                  obscureText: true,
                ),
                SizedBox(height: 40,),
               
          
                
                SizedBox( height: 40,),
                Row(children: [
                  Text("New here ?       "),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signupwitemail(
                    
                    )));
                  }, child: Text("create new account"))
          
                ],)
          
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
