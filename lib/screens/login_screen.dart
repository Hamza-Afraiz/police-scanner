import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/Officerr_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class LoginScreen extends StatefulWidget {
  static String login_id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool spinning=false;
  final _auth =FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Container(
        
        child: ModalProgressHUD(
          inAsyncCall: spinning,
          child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  onChanged: (value) {
                    email=value;
                    //Do something with the user input.
                  },
                  decoration: kdecoration.copyWith(hintText: 'enter email')
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password=value;
                    //Do something with the user input.
                  },
                  decoration: kdecoration.copyWith(hintText: 'enter password')
                ),
                SizedBox(
                  height: 24.0,
                ),
                Roundedbutton(text: 'LOGIN',onpressed :()async {
                  setState(() {
                    spinning=true;
                  });
                  try {
                    final newuser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (newuser != null){
                      Navigator.pushNamed(context, OfficerScreen.Officer_id);
                    }
                    setState(() {
                      spinning=false;
                    });
                  }
                  catch(e){
                    setState(() {
                      spinning=false;

                      _showDialog("Invalid Email Or Password ");
                    });
                    print(e);
                  }

                },),
                Roundedbutton2(text:'REGISTER NOW',onpressed:(){
                  Navigator.pushNamed(context, RegistrationScreen.reg_id);
                }),
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
  Roundedbutton({this.text,@required this.onpressed});
  final String text;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            onpressed();
            //Go to registration screen.
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,style: TextStyle(fontFamily: 'fonts1',fontSize: 25.0),
          ),
        ),
      ),
    );
  }

}
class Roundedbutton2 extends StatelessWidget {
  Roundedbutton2({this.text,@required this.onpressed});
  final String text;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(

        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 50.0,
        child: MaterialButton(
          onPressed: () {
            onpressed();
            //Go to registration screen.
          },
          minWidth: 10.0,
          height: 2.0,
          child: Text(
            text,style: TextStyle(fontFamily: 'fonts1',fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
