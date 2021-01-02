import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/arkadaslar.dart';
import 'package:flutter_app/bildirim.dart';
import 'package:flutter_app/ilkekran.dart';
import 'package:flutter_app/mesaj.dart';
import 'package:flutter_app/mesajSayfa.dart';
import 'package:flutter_app/profil.dart';
import 'package:flutter_app/profilim2.dart';
import 'package:flutter_app/resimler.dart';
import 'arama.dart';
import 'firebase.dart';
import 'detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'sepet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class goster extends StatefulWidget {
  String docal;
  var t;
  var kullanici;
  bool onayDrm=false;
  String bildirimlerim;


  goster({this.t, this.docal,this.kullanici});

  @override
  _gosterState createState() => _gosterState();
}
FirebaseAuth _auth=FirebaseAuth.instance;
int sayac=1;
int fyt;
int bildirimSay;
String text="1";
int limitSay;
int paylasimSay;
bool goruldu=false;


final FirebaseFirestore _firestore= FirebaseFirestore.instance;
class _gosterState extends State<goster> with SingleTickerProviderStateMixin{
  int _sayi=0;
  int _sepetSayi=0;
  int _currentIndex=0;

  TextEditingController txt=new TextEditingController();
  ProgressDialog progressDialog;
  TabController cont;





  Future<Null> refresh() async{

    await Future.delayed(Duration(seconds: 2));
  }


  @override
  Widget build(BuildContext context) {
    DocumentReference dc;



      progressDialog=ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'Yükleniyor...');
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.data == null)
            return Center(child: CircularProgressIndicator());




          return Scaffold(


            body: RefreshIndicator(
                    onRefresh: refresh,
                    child:  ListView(

                        children: [Column(

                            children: snapshot.data.docs
                                .map((doc) {


                                  return Container(
                                color: Colors.white,
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            dty(url: doc['resim'],
                                              ad: doc['ad'],
                                              aciklama: doc['aciklama'],
                                              lokasyon: doc['lokasyon'],
                                              fiyat: doc['fiyat'],)));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        height: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (doc['uid'] ==
                                                      _auth.currentUser.uid) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                profilim()));
                                                  } else {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                profilark(
                                                                  pp: doc['pp'],
                                                                  email: doc['email'],
                                                                  uid: doc['uid'],
                                                                  kuladi: doc['kullanici'],)));
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            doc['pp'] == null
                                                                ? 'https://louisville.edu/enrollmentmanagement/images/person-icon/image'
                                                                : doc['pp'])
                                                        , fit: BoxFit.cover
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(40),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (doc['uid'] ==
                                                      _auth.currentUser.uid) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                profilim()));
                                                  } else {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                profilark(
                                                                  pp: doc['pp'],
                                                                  email: doc['email'],
                                                                  uid: doc['uid'],
                                                                  kuladi: doc['kullanici'],)));
                                                  }
                                                },
                                                child: Container(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(doc['kullanici'],
                                                        style: GoogleFonts
                                                            .comfortaa(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                      Text("Tarih",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 112,
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onPressed: () {


                                                  })
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(children: [
                                            Material(
                                              elevation: 3,
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              child: Hero(
                                                tag: doc['resim'],
                                                child: Container(

                                                  width: 200,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      image: DecorationImage(

                                                        image: NetworkImage(
                                                          doc['resim'],
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),

                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                height: 200,

                                                child: ListView(


                                                  children: [

                                                    Text("Ürün Adı: ",
                                                      style: GoogleFonts.alata(
                                                          fontSize: 15,
                                                          color: Colors.grey),),
                                                    Text(doc['ad'],
                                                        style: GoogleFonts
                                                            .alata(
                                                            fontSize: 15)),

                                                    SizedBox(height: 10,),
                                                    Text("Lokasyon: ",
                                                      style: GoogleFonts.alata(
                                                          fontSize: 15,
                                                          color: Colors.grey),),
                                                    Text(doc['lokasyon'],
                                                        style: GoogleFonts
                                                            .alata(
                                                            fontSize: 15)),

                                                    SizedBox(height: 10,),
                                                    Text("Fiyat: ",
                                                      style: GoogleFonts.alata(
                                                          fontSize: 15,
                                                          color: Colors.grey),),
                                                    Text(doc['fiyat'],
                                                        style: GoogleFonts
                                                            .alata(
                                                            fontSize: 15)),

                                                    SizedBox(height: 10,),
                                                    Text("Açıklama: ",
                                                      style: GoogleFonts.alata(
                                                          fontSize: 15,
                                                          color: Colors.grey),),
                                                    Text(doc['aciklama'],
                                                        style: GoogleFonts
                                                            .alata(
                                                            fontSize: 15))


                                                  ],
                                                ),
                                              ),
                                            ),

                                          ]),
                                          SizedBox(height: 20,),
                                          Container(
                                            height: 0.5,
                                            color: Colors.black.withOpacity(
                                                0.3),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            height: 30,

                                            child: Row(


                                              children: [

                                                Container(
                                                  child: Row(
                                                      children: [


                                                        IconButton(icon: Icon(
                                                            Icons
                                                                .add_shopping_cart_outlined),
                                                            onPressed: () {
                                                              sepet(
                                                                  doc['uid'],
                                                                  doc['email'],
                                                                  doc['pp'],
                                                                  doc['kullanici'],
                                                                  doc['ad'],
                                                                  widget.docal,
                                                                  doc['resim'],
                                                                  doc['aciklama'],
                                                                  doc['lokasyon'],
                                                                  doc['fiyat']);
                                                              Toast.show(
                                                                  "Ürün Sepete Eklendi",
                                                                  context,
                                                                  duration: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity: Toast
                                                                      .BOTTOM);
                                                            }),
                                                      ]
                                                  ),
                                                ),
                                                SizedBox(width: 15,),
                                                Container(

                                                  child: IconButton(
                                                      icon: Icon(Icons
                                                          .arrow_forward_ios),
                                                      onPressed: () {
                                                        kiralama(
                                                            context,
                                                            doc['resim'],
                                                            doc['kullanici'],
                                                            doc['aciklama'],
                                                            doc['fiyat'],
                                                            doc['ad'],
                                                            doc['lokasyon'],
                                                            doc['uid'],
                                                            doc.id.toString() +
                                                                _auth
                                                                    .currentUser
                                                                    .email,
                                                            widget.onayDrm);
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),

                                        ]),
                                      ),

                                    ),

                                  ),
                                ),


                              );
                            }
                            ).toList()),

                      ]),



                  ),
          );
        });



  }


  void sepet(String uid,String email,String pp,String kulad,String ad,String doc, var res, String aciklama,String lokasyon, String fiyat) async{
    try{

      Map<String, dynamic> aktar= Map();
      aktar['uid']=uid;
      aktar['pp']=pp;
      aktar['email']=email;
      aktar['kullanici']=kulad;
      aktar['ad']=ad;
      aktar['resim']=res;
      aktar['aciklama']=aciklama;
      aktar['lokasyon']=lokasyon;
      aktar['fiyat']=fiyat;

      await _firestore.collection(_auth.currentUser.uid).doc().set(aktar, SetOptions(merge: true));

    }
    catch(e){
      debugPrint(e);

    }
  }
  void siparis(String sahipAd,String uid,String email,String pp,String kulad,String ad, var res, String aciklama,String lokasyon, String fiyat,String sahipUid,docId,onayDurumu) async{
    try{

      Map<String, dynamic> aktar= Map();
      aktar['sahipAd']=sahipAd;
      aktar['uid']=uid;
      aktar['pp']=pp;
      aktar['email']=email;
      aktar['kullanici']=kulad;
      aktar['ad']=ad;
      aktar['resim']=res;
      aktar['aciklama']=aciklama;
      aktar['lokasyon']=lokasyon;
      aktar['fiyat']=fiyat;
      aktar['sahipUid']=sahipUid;
      aktar['docId']=docId;
      aktar['onayDurumu']=onayDurumu;
      await _firestore.collection('istekler').doc(docId).set(aktar, SetOptions(merge: true));

    }
    catch(e){
      debugPrint(e);

    }

  }
  void bildirim(bool gormeDurumu,bool onayDurumu,String uid,String karsiUid,String kulad,String dcal,bool istekDurumu) async{
    try{

      Map<String, dynamic> aktar= Map();
      aktar['gormeDurumu']=gormeDurumu;
      aktar['onayDurumu']=onayDurumu;
      aktar['uid']=uid;
      aktar['karsiUid']=karsiUid;
      aktar['kullanici']=kulad;
      aktar['doc']=dcal;
      aktar['istekDurumu']=istekDurumu;



      await _firestore.collection('bildirimler').doc(dcal).set(aktar, SetOptions(merge: true));

    }catch(e){
    }
  }

  kiralama(context, url,sahipAd, aciklama,fiyat,ad,lokasyon,sahipUid,docId,onayDurumu){


    return showDialog(context: context, builder: (context){
      
      return Center(
        child: Material(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 350,
            height: 530,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
            ),
            child: ListView(
              children:[ Container(
                width: MediaQuery.of(context).size.width,
                height:250 ,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            url
                        ),fit:BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(25)
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height:40 ,
                child: ListView(children:[
                  Center(child: Text(aciklama, style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey, decoration: TextDecoration.none,),))]) ,
              ),

              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,

                height:40 ,
                child: Center(child: Text(fiyat, style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey, decoration: TextDecoration.none,),)) ,
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      child: IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: (){
                          if(sayac>1){
                                setState(() {
                                  sayac--;

                                });
                          }

                        },
                      ),

                    ),
                    SizedBox(width: 10,),

                    Container(
                      width: 50,
                      child:  Center(
                        child: Text(
                         "1"
                        ),
                      ),

                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 50,
                      child: IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: (){

                          setState(() {

                            sayac++;

                          });

                        },
                      ),

                    ),
                  ],
                ),

              ),
              SizedBox(height: 15,),
              FlatButton(onPressed: (){
                siparis(sahipAd,_auth.currentUser.uid, _auth.currentUser.email, _auth.currentUser.photoURL, _auth.currentUser.displayName, aciklama, url,ad , lokasyon,fiyat,sahipUid,
                    docId,onayDurumu);
                bildirim(false, onayDurumu, _auth.currentUser.uid, sahipUid, _auth.currentUser.displayName, docId,true);

              }, child:Text("Kirama İsteği Gönder",style: TextStyle(color: Colors.red),),
              )



            ]
            ),
          ),
        ),
      );
    }

    );
  }





 gunSayisi(){
    setState(() {
     text= sayac.toString();

    });

}


}

