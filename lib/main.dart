import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/model/auth.dart';
ConfigClass configClass = new ConfigClass();


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'BPulsa',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(title: 'BPulsa'),
    );
  }
}


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _LoginPageForm createState() => new _LoginPageForm();
}

class _LoginPageForm extends State<LoginPage> {
  String email,password = "";
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image(
            image: AssetImage("assets/loginImage.png"), 
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: this._emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.security),
            title: new TextField(
                controller: this._passController,
                obscureText: true, // Use secure text for passwords.
                decoration: new InputDecoration(
                  hintText: 'Password',
              )
            ),
          ),
          new RaisedButton(
              child: const Text('Login'),
              onPressed : () {
                this.email = _emailController.text;
                this.password = _passController.text;
                http.post(configClass.auth(), body: {"email":this.email, "password": this.password}).then((response) {
                  final jsonResponse = json.decode(response.body.toString());
                  Resp resp = new Resp.fromJson(jsonResponse);
                  AlertDialog dialog = new AlertDialog(
                    content: new Text("Welcome "+ resp.result.content.nama.toString())
                  );
                  showDialog(context: context,child: dialog);
                });
              },
            )
        ],
      ),
    );
  }
}
