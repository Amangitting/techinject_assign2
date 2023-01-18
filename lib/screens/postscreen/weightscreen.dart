import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final ref= FirebaseDatabase.instance.ref("users");


class WeightScreen extends StatefulWidget {
  String email;
   WeightScreen({required String this.email});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" All weights"),),
      body:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection("users").doc(widget.email).collection("entries").snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.hasError){
            return Text("error");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder:(context, index) => ListTile(
              title: Text("weight :"+ snapshot.data!.docs[index]["weight"].toString() ,
              ),
              trailing: Text("Time :"+snapshot.data!.docs[index]["time"].toString()),


          ),);

        }),));
      
    
  }
}