import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/add_record.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/Officerr_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String reg_id = 'registeration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String phoneNumber;
  String cnic;
  String name;
  String password;
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFFE8F5E9),
                const Color(0xFFC8E6C9),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),

                  height: 80,
                ),
                TextFormField(
                    onChanged: (value) {
                      name = value;
                      //Do something with the user input.
                    },
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                    decoration:
                        kdecoration.copyWith(hintText: 'enter your name'),
                validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,),
                SizedBox(
                  height: 10.0,
                ),



                TextField(
                    onChanged: (value) {
                      phoneNumber = value;
                      //Do something with the user input.
                    },
                    decoration: kdecoration.copyWith(
                        hintText: 'enter your phone number')),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    onChanged: (value) {
                      cnic = value;
                      //Do something with the user input.
                    },
                    decoration:
                        kdecoration.copyWith(hintText: 'enter your cnic')),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    onChanged: (value) {
                      email = value; //Do something with the user input.
                    },
                    decoration:
                        kdecoration.copyWith(hintText: 'enter your email')),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    obscureText: true,
                    onChanged: (value) {
                      print(value);
                      password = value;
                      //Do something with the user input.
                    },
                    decoration:
                        kdecoration.copyWith(hintText: 'enter your password')),
                SizedBox(height:80.0),
                Container(
                  height: 100.0,
                  child: Roundedbutton(
                      text: 'REGISTER',
                      onpressed: () async {
                        setState(() {
                          showspinner = true;
                        });
                        try {
                          final newuser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newuser != null) {
                            Navigator.pushNamed(
                                context, OfficerScreen.Officer_id);
                          }
                          else{

                          }

                        } catch (e) {
                          setState(() {
                            showspinner = false;
                            _showDialog("Wrong entry:"
                                "Enter again");

                          });

                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showDialog(String text) {
    // flutter defined function
    showDialog(

      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          backgroundColor: Colors.indigo[200],
          content: new Text(text,style: TextStyle(fontFamily: 'fonts1'),),
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
}

class Roundedbutton extends StatelessWidget {
  Roundedbutton({this.text, @required this.onpressed});
  final String text;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 1.0),
      child: Material(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10.0),
        elevation: 50.0,
        child: MaterialButton(
          onPressed: () {
            onpressed();
            //Go to registration screen.
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,style: TextStyle(fontFamily: 'fonts1'),
          ),
        ),
      ),
    );
  }
}
