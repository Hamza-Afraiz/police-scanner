import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
class AddRecord extends StatefulWidget {
  static String chat_id='chat_screen';
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  bool spinning=false;
  File _image;
  String _uploadedFileURL;
   String name;
   String crimetype;
  final _auth=FirebaseAuth.instance;
  final _firestore=Firestore.instance;
  FirebaseUser loggedinuser;

  @override
  void initState() {

    super.initState();
    getcurrentuser();
    messagesStream();


  }
  void getcurrentuser()async{
    final user=_auth.currentUser();
    if (user != null){
      loggedinuser=await user;

    }
  }



   void messagesStream()async{
     await for(var snapshot in _firestore.collection('criminals').snapshots()){
       for(var message in snapshot.documents){
         print(message.data);
       }

     }


     }
   Future chooseFile() async {
     await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
       setState(() {
         _image = image;
       });
     });
   }
  void _showDialog(String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          backgroundColor: Colors.lightBlue[50],
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

   Future uploadFile() async {
     setState(() {
       spinning=true;
     });

     StorageReference storageReference = FirebaseStorage.instance
         .ref()
         .child('chats/${Path.basename(_image.path)}}');
     StorageUploadTask uploadTask = storageReference.putFile(_image);
     await uploadTask.onComplete;
     setState(() {
       spinning=false;
     });

     storageReference.getDownloadURL().then((fileURL) {
       setState(() {



         _uploadedFileURL = fileURL;
         print(_uploadedFileURL);

         _showDialog("Uploaded");

       });
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('️Add Record'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
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
        child: ModalProgressHUD(
          inAsyncCall: spinning,
          child: SafeArea(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          name=value;

                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(hintText: 'type criminal name'),
                      ),
                    ),

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          crimetype=value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(hintText: 'type crime details'),
                      ),
                    ),

                  ],
                ),
                Text('Selected Image'),
                _image != null
                    ? Image.asset(
                  _image.path  ,
                  height: 200
                )
                    : Container(height: 100),
                _image == null
                    ? RaisedButton(
                  child: Text('Choose File'),
                  onPressed: chooseFile,
                  color: Colors.cyan,
                )
                    : Container(),
                _image != null
                    ? RaisedButton(
                  child: Text('Upload File'),


                  onPressed:

                  uploadFile,
                  color: Colors.cyan,

                ):Container(),


                FlatButton(

                  onPressed: () async{
                    setState(() {
                      spinning=true;
                    });
                    try {
                      _firestore.collection('criminals').add({
                        'Name': name,
                        'Details': crimetype,
                        'url': _uploadedFileURL
                      });
                      setState(() {
                        spinning=false;
                      });
                      _showDialog("Submitted");
                    }
                    catch(e){
                      print(e);
                      _showDialog(" NOT Submitted");
                    }

                  },
                  child: Text(
                    'Submit',
                    style: kSendButtonTextStyle,


                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
