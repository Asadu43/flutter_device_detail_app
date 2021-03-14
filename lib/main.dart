import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_detail_app/CallDataPage.dart';
import 'package:flutter_device_detail_app/DetailPage.dart';
import 'package:flutter_device_detail_app/DeviceInfoPage.dart';
import 'package:flutter_device_detail_app/ImeiNumberPage.dart';
import 'package:flutter_device_detail_app/Notifications.dart';
import 'package:flutter_device_detail_app/geoLocation.dart';
import 'package:url_launcher/url_launcher.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Replace with server token from firebase console settings.
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseTrigger(context);


  }

  firebaseTrigger(BuildContext ctx){

    _firebaseMessaging.configure(
      onMessage: (message){
        print(message);

      },
      onLaunch: (message){
        final data = message['data'];
        if(data ['page'] != null){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage()));

        }
        _Urllauncher(data['link']);
      },
      onResume: (message){
        final data = message['data'];
        if(data ['page'] != null){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage()));

        }
        _Urllauncher(data['link']);
      },
    );

  }

  _Urllauncher(String link) async{
    if(await canLaunch(link)){
      await launch(link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Detail App'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            FlatButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CallDataPage()));
            },
              height: 50,
              minWidth: 120,
              child: Text("Call Log"),
              color: Colors.green,),
            SizedBox(height: 12.0,),
            FlatButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceInfoPage()));
            },
              height: 50,
              minWidth: 120,
              child: Text("Deivce Info"),
              color: Colors.green,),
            SizedBox(height: 12.0,),
            FlatButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImeiNumberPage()));
            },
              height: 50,
              minWidth: 120,
              child: Text("IMEI Address"),
              color: Colors.green,),


            SizedBox(height: 12.0,),
            FlatButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GeoLocation()));
            },
              height: 50,
              minWidth: 120,
              child: Text("Geo Location"),
              color: Colors.green,),

            SizedBox(height: 12.0,),
            FlatButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications()));
            },
              height: 50,
              minWidth: 120,
              child: Text("Notifications"),
              color: Colors.green,),
          ],
        ),
      ),
    );
  }
}

