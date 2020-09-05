import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/add_record.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcome_id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: 200.0,
                  ),
                  Text(
                    'Police Scanner',
                    style: TextStyle(
                      fontFamily: 'fonts1',
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Roundedbutton(text:'LOGIN',onpressed:(){
               Navigator.pushNamed(context, LoginScreen.login_id);}),

            ],
          ),
        ),
      ),
    );
  }
}

class Roundedbutton extends StatelessWidget {
Roundedbutton({this.text,@required this.onpressed});
final String text;
final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
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
      ),
    );
  }
}
