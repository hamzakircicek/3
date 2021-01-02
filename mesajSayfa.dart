import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/bottom.dart';
import 'package:flutter_app/mesaj.dart';
import 'package:toast/toast.dart';
class mesajSayfasi extends StatefulWidget {
  String docc;
  mesajSayfasi({this.docc});

  @override
  _mesajSayfasiState createState() => _mesajSayfasiState();
}
FirebaseFirestore _firestore=FirebaseFirestore.instance;
FirebaseAuth _auth=FirebaseAuth.instance;



class _mesajSayfasiState extends State<mesajSayfasi> {
  var karsi;
  String email;
  var s;
  var a;
  var d;
  @override
  void initState(){
   veriAl(a,d);
    super.initState();

  }
void veriAl(var b,c)async{
 await _firestore.collection('mesaj').get().then((value) {


      debugPrint(value.docs.toString());


  });
}

  @override
  Widget build(BuildContext context) {


    return


          Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.blueGrey,
            ),
            leading:
            IconButton(
            icon: new Icon(Icons.arrow_back),
    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));}



        ),
        ),


        body: Container(

          child: StreamBuilder(

              stream: _firestore.collection('mesaj').doc(_auth.currentUser.email).collection('mesajIci').
              where('karsiUid', isEqualTo: _auth.currentUser.uid ).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                return


                  Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: snapshot.data.docs.map((doc) =>

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>mesajSayfa(kullanici: doc['kullanici'], karsiUid: doc['karsiUid'],uid: doc['uid'],)));
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueGrey.withOpacity(0.7)
                                ),
                                child: Center(child: Text(doc['kullanici']==_auth.currentUser.displayName?"Ben":doc['kullanici'],style: TextStyle(color: Colors.white),)),

                              ),
                            ),
                          )
                      ).toList(),
                    ),
                  ),
                );
              }

          ),

        ),
        );

  }
}
