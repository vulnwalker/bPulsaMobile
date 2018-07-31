import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:bpulsa/database/model/account.dart';
import 'package:bpulsa/MainActivity.dart';
class Profile extends StatefulWidget {
  ConfigClass configClass = new ConfigClass();
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
     Future buildText() async{
      //  var asu = await getDataAccount(); 
       var postData = await http.post(widget.configClass.auth(), body: {"email":"", "password": ""}).then((response) {
        
       });
        
      return 1;
    }
    return new Scaffold(
      body: FutureBuilder(
            future: buildText(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
               return Center(
                 child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0,),
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                            ),
                            new Text("LOADING ..")
                          ],
                        )
                                
                      ),

                      
                    ],
                  ),
               );
              } else {
               return new Column(
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
                );
              }
            },
          ),

    );
  }
}
