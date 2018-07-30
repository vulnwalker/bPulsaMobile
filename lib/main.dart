import 'package:flutter/material.dart';
import 'package:bpulsa/login/login.dart';
import 'package:bpulsa/MainActivity.dart';
import 'package:bpulsa/splash.dart';
import 'package:bpulsa/screens/settings.dart';
import 'package:bpulsa/config.dart';
import 'package:bpulsa/register/register.dart';

void main() {
  runApp(new MyApp());
}
ConfigClass configClass = new ConfigClass();
class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
      LoginPage.routeName: (context) => new LoginPage(),
      SettingsScreen.routeName:  (context) => new SettingsScreen(),
      SplashScreen.routeName:  (context) => new SplashScreen(),
      Register.routeName:  (context) => new Register(),
      MainActivity.routeName:  (context) => new MainActivity(), 
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: configClass.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}


