import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {

  String locationMessage= "";

  void getGeoLocation() async{


   var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

   var lastposition = await Geolocator.getLastKnownPosition();

   print(lastposition);

   var lat=position.latitude;
   var long = position.longitude;

   print('$lat  , $long');

   setState(() {

     locationMessage = "Latitude : $lat  , Longitude  : $long ";
   });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geo Location "),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add_location,size: 48.0,color: Colors.teal,),
            SizedBox(height: 15.0,),
            Text("Current Location Of User",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
            SizedBox(height: 15.0,),
            Text("Position   : $locationMessage"),
            FlatButton(color: Colors.indigo,onPressed: (){
              getGeoLocation();
            }, child: Text("Get Current Location")),
          ],
        ),
      ),
    );
  }
}
