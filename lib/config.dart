import 'package:progress_hud/progress_hud.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
class ConfigClass {
  String APP_NAME = "BPulsa";
  String hostName ;
  
  String getHostName(){
    this.hostName = "http://bpulsa.rm-rf.studio/";
    return this.hostName;
  }
  String auth(){
    return getHostName()+"auth";
  }
  String register(){
    return getHostName()+"register";
  }
  var loadingScreen = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
  );
  void showLoading(context){
    showDialog(
              context: context,
              child: this.loadingScreen
    );
  }
  void closeLoading(context){
      Navigator.pop(context);
  }




  // static Database databaseHelper;
  // Future<Database> get db async {
  //   if (databaseHelper != null) return databaseHelper;
  //   databaseHelper = await initDb();
  //   return databaseHelper;
  // }
  // initDb() async {
  //   io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, "test.db");
  //   var theDb = await openDatabase(path, version: 1, onCreate: databaseSetup);
  //   return theDb;
  // }
  // void databaseSetup(Database db, int version) async{
  //   // When creating the db, create the table
  //   await db.execute("CREATE TABLE account (email text,nama text,saldo int(11),status int(11))");
  //   print("Created tables");
  // }
  // void sqlQuery(String query){
  //    databaseHelper.execute(query);
  // }


}