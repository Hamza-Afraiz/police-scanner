import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

class ViewRecord extends StatefulWidget{
  static String view_id = 'view record';

  @override
  _ViewRecordState createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  String name;
  String crimetype;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() async {
    final user = _auth.currentUser();
    if (user != null) {
      loggedinuser = await user;
    }
  }

  void getdetails() async {
    final messages = await _firestore.collection('criminals').getDocuments();
    for (var message in messages.documents) {
      List<String> key = message.data.keys;

      print(message.data.keys);
      print(message.data.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('️view Record',style: TextStyle(fontFamily: 'fonts1'),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
         StreamBuilder<QuerySnapshot>(

              stream: _firestore.collection('criminals').snapshots(),
              builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    final messages = snapshot.data.documents;

                    List<Card> messagewidgets = [];
                    for (var message in messages) {
                      final messagetext = message.data['Name'];

                      final crimetext = message.data['Details'];
                      String urltext= message.data['url'];;
                        if(urltext == null){
                          urltext='https://firebasestorage.googleapis.com/v0/b/policescabbwe.appspot.com/o/no-profile-picture-icon-13.jpg?alt=media&token=edd810b0-9511-47c0-b927-062ae2e010bf';
                        }

                      final messagewidget = Card(

                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    const Color(0xFF3366FF),
                                    const Color(0xFF00CCFF),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ' Name is $messagetext  ',
                                  style:
                                  TextStyle(
                                      color: Colors.white, fontSize: 20.0,fontFamily: 'fonts1'),

                                ),
                                SizedBox(height: 15.0),
                                Text(' Crime is $crimetext ',style:TextStyle(
                                    color: Colors.white, fontSize: 20.0,fontFamily: 'fonts1'),),
                                SizedBox(height: 15.0),

                                Container(

                                  child: Image.network(urltext), height: 100,)

                              ],
                            ),


                          ),

                        ),
                        margin: EdgeInsets.all(10.0),
                        color: Colors.blueAccent,

                      );
                      messagewidgets.add(messagewidget);
                    }

                    return Expanded (
                      child: ListView(children: messagewidgets,),


                    );
                  }



              },
            ),
          ],
        ),
      ),
    );
  }
}




class NullException implements Exception {
  String errorMessage() {
    return 'Null value';
  }
}