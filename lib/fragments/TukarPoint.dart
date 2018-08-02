import 'dart:async';
import 'package:bpulsa/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TukarPoint extends StatefulWidget {
  ConfigClass configClass = new ConfigClass();
  Card getStructuredGridCell(name) {
    return new Card(
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
        ));
    }


  @override
  TukarPointState createState() {
    return new TukarPointState();
  }

}

class TukarPointState extends State<TukarPoint> {
  List<Widget> kolom = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      Future getDataTukarPoint() async{
       await http.post(widget.configClass.auth(), body: {"email":"", "password": ""}).then((response) {

        // kolom[0] =  widget.getStructuredGridCell("");
        // kolom[1] =  widget.getStructuredGridCell("Twitter");
        // kolom[2] =  widget.getStructuredGridCell("Instagram");
        // kolom[3] =  widget.getStructuredGridCell("Linkedin");
        // kolom[4] =  widget.getStructuredGridCell("Gooogle Plus");
        // kolom[5] =  widget.getStructuredGridCell("Launcher Icon");
        kolom.add(widget.getStructuredGridCell("Facebook"));        
        kolom.add(widget.getStructuredGridCell("Twitter"));        
        kolom.add(widget.getStructuredGridCell("Instagram Icon"));        
        kolom.add(widget.getStructuredGridCell("Linkedin Icon"));        
        kolom.add(widget.getStructuredGridCell("Gooogle Icon"));        
        kolom.add(widget.getStructuredGridCell("Launcher Icon"));        
        kolom.add(widget.getStructuredGridCell("Launcher Icon"));        
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