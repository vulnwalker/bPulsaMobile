import 'package:flutter/material.dart';
import 'package:bpulsa/model/login.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/MainActivity.dart';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/database/model/account.dart';
import 'package:bpulsa/register/register.dart';
ConfigClass configClass = new ConfigClass();

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email,password = "";
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: this._emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: 'vulnwalker@tuyul.online',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: this._passController,
      autofocus: false,
      // initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
             configClass.showLoading(context);
             http.post(configClass.auth(), body: {"email":_emailController.text, "password": _passController.text}).then((response) {
                configClass.closeLoading(context);
                final jsonResponse = json.decode(response.body.toString());
                String loginResponse ;
                Resp resp = new Resp.fromJson(jsonResponse);
                if(resp.result.err == ''){
                  print("Welcome "+ resp.result.content.nama.toString());
                  var db = new DatabaseHelper();
                  var dataAccount = new Account(
                    _emailController.text,
                    _passController.text,
                    resp.result.content.nama,
                    resp.result.content.nomor_telepon,
                    200,
                    1,
                  );
                  db.saveAccount(dataAccount);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MainActivity(),
                  ));

                }else{
                  loginResponse = resp.result.err;
                  AlertDialog dialog = new AlertDialog(
                    content: new Text(loginResponse)
                  );
                  showDialog(context: context,child: dialog);
                }

              });

          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final registerText = FlatButton(
      child: Text(
        "Don't Have Account ? Click here",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        
             Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Register(),
              ));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerText
          ],
        ),
      ),
    );
  }
}
