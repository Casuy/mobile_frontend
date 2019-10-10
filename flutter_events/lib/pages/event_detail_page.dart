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
        //map
        Container(
          padding: EdgeInsets.only(top: 60),
          height: 350,
          width: 450,
          child: _googleMap(context),
        ),
        //TODO: display event detail
        ListView(
          padding: EdgeInsets.fromLTRB(10, 350, 10, 10),
          children: <Widget>[
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
        ),
        _appBar(Colors.red, Colors.white),
      ],
    );
  }

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
    Completer<GoogleMapController> _controller = Completer();

    LatLng targetLatLng = LatLng(widget.item.lat, widget.item.lon);
    CameraPosition _position = CameraPosition(
      target: targetLatLng,
      zoom: 13.7,
    );
    List<Marker> markers = <Marker>[];
    markers.add(Marker(
        markerId: MarkerId(widget.item.title),
        position: targetLatLng,
        infoWindow: InfoWindow(title: widget.item.title)));

    return GoogleMap(
      initialCameraPosition: _position,
      mapType: MapType.normal,
      markers: Set<Marker>.of(markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
