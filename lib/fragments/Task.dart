import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//Database
import 'package:bpulsa/database/DatabaseHelper.dart';
import 'package:flushbar/flushbar.dart';
const APP_ID = "<Put in your Device ID>";
class Task extends StatefulWidget {
  Task(this.namaMember);
  final String namaMember;
  ConfigClass configClass = new ConfigClass();
  @override
  TaskState createState() {
    return new TaskState();
  }

}

class TaskState extends State<Task> {
   static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Games', 'Puzzles'],
  );
  String emailMember;
  int saldoMember;
  BannerAd bannerAd;
  InterstitialAd interstitialAd;
  RewardedVideoAd rewardedVideoAd;
  var databaseHelper = new  DatabaseHelper() ;
  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    emailMember = list[0]["email"];
    saldoMember = list[0]["saldo"];
  }
  BannerAd buildBanner() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print(event);
        });
  }

  InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.failedToLoad) {
            interstitialAd..load();
          } else if (event == MobileAdEvent.closed) {
            interstitialAd = buildInterstitial()..load();
          }
          print(event);
        });
  }
  void loadVideoAds() {
    RewardedVideoAd.instance.load(
      adUnitId: RewardedVideoAd.testAdUnitId,
      targetingInfo: targetingInfo,
    );
  }

  @override
  void initState() {
    super.initState();
    (() async {
      var asu = await getDataAccount();
      setState(() {
      });
    })();

    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // bannerAd = buildBanner()..load();
    // interstitialAd = buildInterstitial()..load();
    // // loadVideoAds();
    
    // RewardedVideoAd.instance.listener =
    //     (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   print("RewardedVideoAd event $event");
    //   if (event == RewardedVideoAdEvent.failedToLoad) {
    //     widget.configClass.closeLoading(context);
    //     AlertDialog dialog = new AlertDialog(
    //         content: new Text("Gagal Load Video")
    //     );
    //     showDialog(context: context,child: dialog);
    //     print("Gagal Load Video");

    //     // loadVideoAds();
    //   }else if(event == RewardedVideoAdEvent.loaded){
    //     widget.configClass.closeLoading(context);
    //     RewardedVideoAd.instance.show();
    //     print("Iklan terload");
    //   }
    // };
   

  }
@override
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

    

  @override
  Widget build(BuildContext context) {
    //  interstitialAd
    //             ..load()
    //             ..show();
    final videoButton1 = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
           onPressed: () {
             widget.configClass.showLoading(context);
             loadVideoAds();
             
           },
          color: Colors.lightBlueAccent,
          child: Text('VIDEO 1', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final videoButton2 = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            
          },
          color: Colors.lightBlueAccent,
          child: Text('VIDEO 2', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  final videoButton3 = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            
          },
          color: Colors.lightBlueAccent,
          child: Text('VIDEO 3', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

  final viewButton2 = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            
          },
          color: Colors.lightBlueAccent,
          child: Text('VIEW 2', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  final absenButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            widget.configClass.showLoading(context);
              var dataPost = {
                "email":emailMember, 
                };
              http.post(widget.configClass.absesnHarian(), body: dataPost).then((response) {
                widget.configClass.closeLoading(context);
                var extractdata = JSON.decode(response.body);
                List dataResult;
                List dataContent;
                String err,cek;
                dataResult = extractdata["result"];
                err = dataResult[0]["err"];
                cek = dataResult[0]["cek"];
                dataContent = dataResult[0]["content"];
                print(err);
                if(err == ""){
                 

                  Flushbar(
                    flushbarPosition: FlushbarPosition.BOTTOM, //Immutable
                    reverseAnimationCurve: Curves.decelerate, //Immutable
                    forwardAnimationCurve: Curves.elasticOut, //Immutable
                    
                  )
                    ..title = "Sukses"
                    ..message = "Absesn Harian Berhasil di lakukan, anda mendapatkan "+dataContent[0]["point"]+" Point"
                    ..duration = Duration(seconds: 3)
                    ..backgroundColor = Colors.red
                    ..backgroundColor = Colors.red
                    ..shadowColor = Colors.blue[800]
                    ..isDismissible = true
                    ..backgroundGradient = new LinearGradient(colors: [Colors.blue,Colors.black])
                    ..icon = Icon(
                      Icons.error,
                      color: Colors.greenAccent,
                    )
                    ..linearProgressIndicator = LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    )
                    ..show(context);
                }else{
                  Flushbar(
                    flushbarPosition: FlushbarPosition.BOTTOM, //Immutable
                    reverseAnimationCurve: Curves.decelerate, //Immutable
                    forwardAnimationCurve: Curves.elasticOut, //Immutable
                    
                  )
                    ..title = "Error"
                    ..message = err
                    ..duration = Duration(seconds: 3)
                    ..backgroundColor = Colors.red
                    ..backgroundColor = Colors.red
                    ..shadowColor = Colors.blue[800]
                    ..isDismissible = true
                    ..backgroundGradient = new LinearGradient(colors: [Colors.blue,Colors.black])
                    ..icon = Icon(
                      Icons.error,
                      color: Colors.greenAccent,
                    )
                    ..linearProgressIndicator = LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    )
                    ..show(context);
                }                

                });
          },
          color: Colors.lightBlueAccent,
          child: Text('ABSEN HARIAN', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    //  bannerAd.show();
    
     return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            videoButton1,
            videoButton2,
            videoButton3,
            absenButton,
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.0),
            //   child: Material(
            //     borderRadius: BorderRadius.circular(30.0),
            //     shadowColor: Colors.lightBlueAccent.shade100,
            //     elevation: 5.0,
            //     child: MaterialButton(
            //       minWidth: 200.0,
            //       height: 42.0,
            //       onPressed: () {
            //         interstitialAd
            //           ..load()
            //           ..show();
            //       },
            //       color: Colors.lightBlueAccent,
            //       child: Text('VIEW 1', style: TextStyle(color: Colors.white)),
            //     ),
            //   ),
            // ),
            // viewButton2,
            // SizedBox(height: 24.0),
           
            
          ],
        ),
        
      ),
    );
  }
}