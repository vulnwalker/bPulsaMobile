import 'package:flutter/material.dart';
import 'package:bpulsa/model/login.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/database/model/account.dart';
import 'package:bpulsa/MainActivity.dart';
ConfigClass configClass = new ConfigClass();
class ProfileEdit extends StatefulWidget {
  static const String routeName = "/editProfile";
  @override
   ProfileEditState createState() => new ProfileEditState();
}

class ProfileEditState extends State<ProfileEdit> {
  String email,password,passwordConfirm,nama,nomorTelepon = " ";

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ProfileEdit"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {
            if(password != passwordConfirm ){
              AlertDialog dialog = new AlertDialog(
                    content: new Text("Confirm Password Tidak Sama ")
                  );
              showDialog(context : context, child: dialog);
            }else{
              configClass.showLoading(context);
              var dataPost = {
                "email":email, 
                "password": passwordConfirm,
                "nama": nama,
                "nomorTelepon": nomorTelepon,
                };
              http.post(configClass.editProfile(), body: dataPost).then((response) {
                  configClass.closeLoading(context);
                  final jsonResponse = json.decode(response.body.toString());
                  String loginResponse ;
                  Resp resp = new Resp.fromJson(jsonResponse);
                  print("Welcome "+ resp.result.content.nama.toString());
                  if(resp.result.err == ''){
                    var db = new DatabaseHelper();
                    var dataAccount = new Account(
                      email,
                      password,
                      resp.result.content.nama,
                      resp.result.content.nomor_telepon,
                      0,
                      1,
                    );
                    db.saveAccount(dataAccount);
                    AlertDialog dialog = new AlertDialog(
                      content: new Text("ProfileEdit Success")
                    );
                    showDialog(context: context,child: dialog);
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
            }
            

          })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              onChanged: (String text) {
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
           new ListTile(
            leading: const Icon(Icons.security),
            title: new TextField(
              onChanged: (String text) {
                password = text;
              },
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
          ),
           new ListTile(
            leading: const Icon(Icons.security),
            title: new TextField(
              onChanged: (String text) {
                passwordConfirm = text;
              },
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              onChanged: (String text) {
                nama = text;
              },
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              onChanged: (String text) {
                nomorTelepon = text;
              },
              keyboardType: TextInputType.phone,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
          ),

        ],
      ),
    );
  }
}
