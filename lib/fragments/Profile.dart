import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/database/model/account.dart';
import 'package:bpulsa/MainActivity.dart';
class Profile extends StatefulWidget {
  @override
   ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  String email,password,passwordConfirm,nama,nomorTelepon = " ";
  var databaseHelper = new  DatabaseHelper() ;
  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    email = list[0]["email"];
    nama = list[0]["nama"];
    nomorTelepon = list[0]["nomor_telepon"];
    
  }
  @override
  void initState(){
    super.initState();
    (() async {
      var asu = await getDataAccount(); 
      setState(() {
         
      });
    })();
    // new Future<String>.delayed(new Duration(seconds: 1), () => '["123", "456", "789"]').then((String value) {
    //   setState(() {
    //       getDataAccount(); 
    //   });
    // });

  }
  @override
  Widget build(BuildContext context) { 
    // getDataAccount(); 
   
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: TextEditingController(
                text: email
              ),
            ),
          ),
          
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              enabled: false,
              controller: TextEditingController(
                text: nama
              ),
              keyboardType: TextInputType.text,
              autofocus: false,

            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(

              keyboardType: TextInputType.phone,
              autofocus: false,
              enabled: false,
              controller: TextEditingController(
                text: nomorTelepon
              ),
            ),
          ),

        ],
      ),
    );
  }
}
