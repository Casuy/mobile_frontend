import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_events/model/event_model.dart';

//import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';

const TOKEN =
    'pk.eyJ1IjoiY2FzdXkiLCJhIjoiY2sxanRwaWljMDcxMjNicGU2MnZyaHZneiJ9.E3_SYHBHZfbkH3tK5KVI5A';

class EventDetailPage extends StatefulWidget {
  final EventItem item;

  const EventDetailPage({Key key, this.item}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  CameraPosition _position = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: <Widget>[
        //TODO: display event detail
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                //map
                Container(
                  height: 300,
                  width: 450,
                  child: _googleMap(context),
                ),
                //details
                Container(
                  width: 450,
                  height: 500,
                  color: Colors.blue,
                  child: Text('Event detail ${widget.item.title}'),
                ),
                //location
                Container()
              ],
            )),
        _appBar(Colors.red, Colors.white),
      ],
    );
  }

//  _map(BuildContext context) {
//    return FlutterMap(
//      options: new MapOptions(
//        center: new LatLng(51.5, -0.09),
//        zoom: 13.0,
//      ),
//      layers: [
//        new TileLayerOptions(
//          urlTemplate: "https://api.tiles.mapbox.com/v4/"
//              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//          additionalOptions: {
//            'accessToken': TOKEN,
//            'id': 'mapbox.streets',
//          },
//        ),
//        new MarkerLayerOptions(
//          markers: [
//            new Marker(
//              width: 40,
//              height: 40,
//              point: new LatLng(51.5, -0.09),
//              builder: (context) => new Image(
//                  height: 30,
//                  width: 30,
//                  image: AssetImage('images/local_nav_nearby.png')),
//            ),
//          ],
//        ),
//      ],
//    );
//  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    return Container(
      height: 60,
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            //Return button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 26),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            // Title
            Positioned(
              left: 0,
              right: 0,
              top: 28,
              child: Center(
                child: Text(
                  'Detail',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _googleMap(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _position,
      myLocationEnabled: true,
      mapType: MapType.normal,

    );
  }
}
