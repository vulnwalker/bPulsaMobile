import 'package:flutter/material.dart';
import 'package:bpulsa/MainActivity.dart';
import 'package:bpulsa/login/login.dart';
import 'package:bpulsa/config.dart';
import 'package:bpulsa/database/DatabaseHelper.dart';

ConfigClass configClass = new ConfigClass();
class SplashScreen extends StatefulWidget {
  static const String routeName = '/Splash';
  var databaseHelper = new  DatabaseHelper() ;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    checkLogin();
  }
  void checkLogin() async{
    this.widget.databaseHelper.initDb();
    var statusLogin =  await this.widget.databaseHelper.accountRowCount() ;
    print("Row Count" + statusLogin.toString());

    if(statusLogin == 0){
     Navigator.of(context).pushNamed(LoginPage.routeName);
    }else{
     Navigator.of(context).pushNamed(MainActivity.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.orange),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        configClass.app_name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Free Miner \n For Everyone",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
