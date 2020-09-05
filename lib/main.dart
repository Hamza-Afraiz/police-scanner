import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/add_record.dart';
import 'package:flash_chat/screens/view record.dart';
import 'package:flash_chat/screens/Selection.dart';
import 'package:flash_chat/screens/Officerr_login.dart';
import 'package:flash_chat/screens/add_report.dart';
import 'package:flash_chat/screens/view_report.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute:SelectionScreen.selection_id,
      routes: {WelcomeScreen.welcome_id :(context) => WelcomeScreen(),
        RegistrationScreen.reg_id :(context) => RegistrationScreen(),
       AddRecord.chat_id :(context) => AddRecord()
     , LoginScreen.login_id:(context) => LoginScreen(),
        ViewRecord.view_id:(context) => ViewRecord() ,
        OfficerScreen.Officer_id:(context) => OfficerScreen(),
        SelectionScreen.selection_id:(context) => SelectionScreen(),
        AddReport.addreport:(context) =>AddReport() ,
        ViewReport.view_report:(context) =>ViewReport() ,

        },
    );
  }
}
