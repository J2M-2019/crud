import 'package:flutter/material.dart';
import 'utils/api_connect.dart' show ApiService;
//import 'routes.dart';

void main() => runApp(new LoginApp());

class LoginApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiService (). getProfiles (). then ((valeur) => print ("valeur: $valeur")); 
    return new MaterialApp(
      title: 'J2M',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      
    );
  }


}

