import 'package:flutter/material.dart';

//pages
import 'package:bpulsa/login/login.dart';
import 'package:bpulsa/screens/settings.dart';


//Fragments
import 'package:bpulsa/fragments/TukarPoint.dart';
import 'package:bpulsa/fragments/HistorTukarPoint.dart';
import 'package:bpulsa/fragments/MainMenu.dart';
import 'package:bpulsa/fragments/Profile.dart';

//Database
import 'package:bpulsa/database/DatabaseHelper.dart';

class DrawerItem {
  String title;
  IconData icon;
}

class MainActivity extends StatefulWidget {
  static const String routeName = '/MainActivity';
  // MainActivity(this.namaMember);

  @override
  MainActivityState createState() => new MainActivityState();
}

class MainActivityState extends State<MainActivity> {
  String namaMember = configClass.app_name;
  var databaseHelper = new  DatabaseHelper() ;
  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    namaMember = list[0]["nama"];
  }
  @override
  void initState(){
    super.initState();
    (() async {
      var asu = await getDataAccount();
      setState(() {
      });
    })();

  }
  String fragmentTag = configClass.app_name;
  String barTitle = configClass.app_name;
  Drawer getNavDrawer(BuildContext context) {
    final  childrenHeader = Container(
      child: new Row(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/logo.png'),
          ),
         Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(namaMember)
          ),
        ],
      ),
    );


    var headerChild = new DrawerHeader(child: childrenHeader);
    var fragmentMainMenu = new ListTile(
          leading: new Icon(Icons.home),
          title: new Text("Main Menu"),
          selected: this.fragmentTag == configClass.app_name,
          onTap: (){
            this.barTitle = configClass.app_name;
            setState(() => this.fragmentTag = configClass.app_name);
            Navigator.of(context).pop();
          }
        );
    var fragmentTukarPoint = new ListTile(
          leading: new Icon(Icons.shopping_cart),
          title: new Text("Tukar Point"),
          selected: this.fragmentTag == "Tukar Point",
          onTap: (){
            setState(() => this.fragmentTag = "Tukar Point");
            Navigator.of(context).pop();
          }
        );
    var fragmentHistoriTukarPoint = new ListTile(
          leading: new Icon(Icons.alarm),
          title: new Text("Histori Tukar Point"),
          selected: this.fragmentTag == "Histori Tukar Point",
          onTap: (){
            setState(() => this.fragmentTag = "Histori Tukar Point");
            Navigator.of(context).pop();
          }
        );
    var fragmentProfile = new ListTile(
          leading: new Icon(Icons.account_circle),
          title: new Text("Profile"),
          selected: this.fragmentTag == "Profile",
          onTap: (){
            setState(() => this.fragmentTag = "Profile");
            Navigator.of(context).pop();
          }
        );
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: configClass.app_name,
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info)
      );

    ListTile getNavItem(var icon, String s, String routeName) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        onTap: () {
          if(routeName == LoginPage.routeName){
             logoutProcess();
             print("Logout");
          }
          setState(() {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(routeName);
          });

        },
      );
    }


    var myNavChildren = [
      headerChild,
      fragmentMainMenu,
      fragmentTukarPoint,
      fragmentHistoriTukarPoint,
      fragmentProfile,
      getNavItem(Icons.settings, "Setting", SettingsScreen.routeName),
      getNavItem(Icons.sync, "Sync", ""),
      aboutChild,
      getNavItem(Icons.share, "Share", SettingsScreen.routeName),
      getNavItem(Icons.power_settings_new, "Logout", LoginPage.routeName),
    ];

    ListView listView = new ListView(children: myNavChildren);

    return new Drawer(
      child: listView,
    );
  }

  _getDrawerItemWidget(String pos) {
      this.barTitle = pos;
      switch (pos) {
        case "Tukar Point":
          return new TukarPoint();
        case "Histori Tukar Point":
          return new HistoriTukarPoint();
        case "Profile":
          return new Profile();
        default:
          this.barTitle = configClass.app_name;
          return new MainMenu(namaMember);
      }
  }

  @override
  Widget build(BuildContext context) {
    getDataAccount();
    return new Scaffold(
      appBar: new AppBar(
        title:  Text(
          this.barTitle,
          style: new TextStyle(color: Colors.white),
          ),
      ),
      body:_getDrawerItemWidget(this.fragmentTag),
      drawer: getNavDrawer(context),

    );
  }

  void logoutProcess() async{
     databaseHelper.deleteAccount();


  }
}
