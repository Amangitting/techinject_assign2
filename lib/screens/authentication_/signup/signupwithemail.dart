// ignore_for_file: sized_box_for_whitesp

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_assesment/screens/authentication_/loginpage/loginwithemail.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';

class Signupwitemail extends StatefulWidget {
  const Signupwitemail({super.key});

  @override
  State<Signupwitemail> createState() => _SignupwitemailState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final ref= FirebaseFirestore.instance.collection("users");

final re= FirebaseDatabase.instance.ref("users");
var id=DateTime.now().millisecondsSinceEpoch.toString();


TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();

class _SignupwitemailState extends State<Signupwitemail> {
  final _key = GlobalKey<FormState>();
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                auth
                    .createUserWithEmailAndPassword(
                        email: emailcontroller.text.toString(),
                        password: passwordcontroller.text.toString())
                    .then((value) {
                      Get.snackbar("SUCCESFULLY REGISTERED", "Login again");
                      Navigator.pop(context);
                    })
                    .onError((error, stackTrace) {
                      
                      Get.snackbar("error", error.toString().substring(30));
                    });
                    
                    
              }
            },
            child: Text("signup")),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("signup with email"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "fill name";
                      }
                    }),
                    decoration: InputDecoration(hintText: "enter your name"),
                    controller: namecontroller,
                  ),
                ),
                Container(
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "fill emailadress";
                      }
                      if (!value.contains("@")) {
                        return "fill proper emailadress";
                      }
                    }),
                    decoration: InputDecoration(hintText: "email"),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                  ),
                ),
               
                TextField(
                  decoration: InputDecoration(hintText: "password"),
                  controller: passwordcontroller,
                  obscureText: true,
                ),
                SizedBox(
                  height: 40,
                ),
              
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text("already have an account?"),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("login here")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onsubmitname()async{
    var id=DateTime.now().millisecondsSinceEpoch.toString();
    var name=namecontroller.text.toString();
    var email=emailcontroller.text.toString();
    ref.doc(email)
  
   ;



  }
}
