import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/add_record.dart';
import 'package:flash_chat/screens/view record.dart';
import 'package:flash_chat/screens/add_report.dart';
import 'package:flash_chat/screens/view_report.dart';

class OfficerScreen extends StatefulWidget {
  static String Officer_id='Officerr_login';
  @override
  _OfficerScreenState createState() => _OfficerScreenState();
}

class _OfficerScreenState extends State<OfficerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
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
                    height: 150.0,
                  ),
                  Text(
                    'Police Scanner',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,fontFamily: 'fonts1',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Roundedbutton(text:'add record',onpressed:(){
                Navigator.pushNamed(context, AddRecord.chat_id);}),
              Roundedbutton(text:'view record',onpressed:(){
                Navigator.pushNamed(context,ViewRecord.view_id );
              }),
              Roundedbutton(text:'send report',onpressed:(){
                Navigator.pushNamed(context,AddReport.addreport );
              }),
              Roundedbutton(text:'view report',onpressed:(){
                Navigator.pushNamed(context,ViewReport.view_report );
              }),
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
            text,style: TextStyle(fontFamily: 'fonts1',fontSize: 25.0)
          ),
        ),
      ),
    );
  }
}
