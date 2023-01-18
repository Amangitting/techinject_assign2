import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:new_assesment/screens/postscreen/weightscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Postscreen extends StatefulWidget {
  String email;
  Postscreen({required String this.email});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  
  final re = FirebaseDatabase.instance.ref("user");
  final ref=FirebaseFirestore.instance.collection("users");
    final _key = GlobalKey<FormState>();

  TextEditingController weightcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("upload Screen")),
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: weightcontroller,
                decoration: InputDecoration(
                    hintText: "enter weight", suffixText: "in kg's"),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "enter some value";
                  }
                }),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    submitweight();
                  }
                },
                child: Text("submit")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeightScreen(
                                email: widget.email,
                              )));
                },
                child: Text("see all weights"))
          ],
        ),
      ),
    );
  }

  void submitweight() async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var newtime = DateTime.now().toString().substring(0, 19);
    var email=widget.email;

    await ref.doc(email).collection("entries").doc().
    set({
      "weight": weightcontroller.text.toString(),
      "time": newtime
    }).then((value) {
      Get.snackbar("submitted", weightcontroller.text.toString() + "kgs");
    }).onError((error, stackTrace) {
      Get.snackbar("error", error.toString());
    });
  }
}
