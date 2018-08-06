import 'dart:async';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
class TukarPoint extends StatefulWidget {
  ConfigClass configClass = new ConfigClass();
  



  @override
  TukarPointState createState() {
    return new TukarPointState();
  }

}

class TukarPointState extends State<TukarPoint> {
  List<Widget> kolom = [];
  List dataResult;
  List dataContent;
  // final List<DaftarPoint> listDaftarPoint;

  // List<DaftarPoint> parseDaftarPoints(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<DaftarPoint>((json) => DaftarPoint.fromJson(json)).toList();
  // }
  @override
  void initState() {
    super.initState();
    this.kolom = [];
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
      GestureDetector getStructuredGridCell(name,deskripsi) {
        return new GestureDetector(
        onTap: (){
          Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM, //Immutable
            reverseAnimationCurve: Curves.decelerate, //Immutable
            forwardAnimationCurve: Curves.elasticOut, //Immutable
            
          )
            ..title = name
            ..message = deskripsi
            ..duration = Duration(seconds: 3)
            ..backgroundColor = Colors.red
            ..backgroundColor = Colors.red
            ..shadowColor = Colors.blue[800]
            ..isDismissible = true
            ..mainButton = FlatButton(
              onPressed: () {},
              child: Text(
                "TUKAR",
                style: TextStyle(color: Colors.amber),
              ),
            )
            ..backgroundGradient = new LinearGradient(colors: [Colors.blue,Colors.black])
            ..icon = Icon(
              Icons.shopping_cart,
              color: Colors.greenAccent,
            )
            ..linearProgressIndicator = LinearProgressIndicator(
              backgroundColor: Colors.blueGrey,
            )
            ..show(context);
          // Flushbar(
          //   title: name,
          //   message: deskripsi,
          //   flushbarPosition: FlushbarPosition.TOP, //Immutable
          //   reverseAnimationCurve: Curves.decelerate, //Immutable
          //   forwardAnimationCurve: Curves.elasticOut, //Immutable
          //   backgroundColor: Colors.red,
          //   shadowColor: Colors.blue[800],
          //   backgroundGradient: new LinearGradient(colors: [Colors.blue,Colors.black]),
          //   isDismissible: false,
          //   duration: Duration(seconds: 4),
          //   icon: Icon(
          //     Icons.check,
          //     color: Colors.greenAccent,
          //   ),
          //   mainButton: FlatButton(
          //     onPressed: () {},
          //     child: Text(
          //       "CLAP",
          //       style: TextStyle(color: Colors.amber),
          //     ),
          //   ),
          //   linearProgressIndicator: LinearProgressIndicator(
          //     backgroundColor: Colors.blueGrey,
          //   ),
          //   titleText: new Text(
          //     "Hello Hero",
          //     style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.yellow[600], fontFamily: "ShadowsIntoLightTwo"),
          //   ),
          //   messageText: new Text(
          //     "You killed that giant monster in the city. Congratulations!",
          //     style: TextStyle(fontSize: 18.0, color: Colors.green ,fontFamily: "ShadowsIntoLightTwo"),
          //   ),
          // )..show(context);
        }, 
        
        child: new Card(
              elevation: 1.5,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  new Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                  
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(name)
                      ),
                    ],
                  ),
                ],
              )
          )
      );
     
    }

      Future getDataTukarPoint() async{
       await http.post("http://bpulsa.rm-rf.studio/daftar/point", body: {"email":"vulnwalker@tuyul.online", "password": "rf09thebye"}).then((response) {
        this.kolom = [];
        var extractdata = JSON.decode(response.body);
        dataResult = extractdata["result"];
        dataContent = dataResult[0]["content"];
        for (var i = 0; i < dataContent.length; i++) {
          kolom.add(getStructuredGridCell(dataContent[i]['title'],dataContent[i]['description']));        
          
        }

        // kolom.add(widget.getStructuredGridCell("Twitter"));        
        // kolom.add(widget.getStructuredGridCell("Instagram Icon"));        
        // kolom.add(widget.getStructuredGridCell("Linkedin Icon"));        
        // kolom.add(widget.getStructuredGridCell("Gooogle Icon"));        
        // kolom.add(widget.getStructuredGridCell("Launcher Icon"));        
        // kolom.add(widget.getStructuredGridCell("Launcher Icon"));        
        print("Load sukses");
       });
       
        
      return 1;
    }


     return new Scaffold(
       
      body: FutureBuilder(
            future: getDataTukarPoint(),
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
                  return new GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(1.0),
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    children: kolom
                );
              }
            },
          ),

    );
  }
}