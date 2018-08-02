import 'package:flutter/material.dart';
import 'package:bpulsa/config.dart';
import 'package:firebase_admob/firebase_admob.dart';
const APP_ID = "<Put in your Device ID>";
class MainMenu extends StatefulWidget {
  MainMenu(this.namaMember);
  final String namaMember;
  ConfigClass configClass = new ConfigClass();
  @override
  MainMenuState createState() {
    return new MainMenuState();
  }

}

class MainMenuState extends State<MainMenu> {
   static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Games', 'Puzzles'],
  );
  BannerAd bannerAd;
  InterstitialAd interstitialAd;
  RewardedVideoAd rewardedVideoAd;

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

    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    bannerAd = buildBanner()..load();
    interstitialAd = buildInterstitial()..load();
    // loadVideoAds();
    
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.failedToLoad) {
        widget.configClass.closeLoading(context);
        AlertDialog dialog = new AlertDialog(
            content: new Text("Gagal Load Video")
        );
        showDialog(context: context,child: dialog);
        print("Gagal Load Video");

        // loadVideoAds();
      }else if(event == RewardedVideoAdEvent.loaded){
        widget.configClass.closeLoading(context);
        RewardedVideoAd.instance.show();
        print("Iklan terload");
      }
    };
   

  }
@override
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

    

  @override
  Widget build(BuildContext context) {
     interstitialAd
                ..load()
                ..show();
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
            
          },
          color: Colors.lightBlueAccent,
          child: Text('ABSEN HARIAN', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
     bannerAd.show();
    
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