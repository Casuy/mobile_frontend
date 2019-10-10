import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_events/model/event_model.dart';

//import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';

const TOKEN =
    'pk.eyJ1IjoiY2FzdXkiLCJhIjoiY2sxanRwaWljMDcxMjNicGU2MnZyaHZneiJ9.E3_SYHBHZfbkH3tK5KVI5A';
const MONTH = {
  '01': 'Jan',
  '02': 'Feb',
  '03': 'Mar',
  '04': 'Apr',
  '05': 'May',
  '06': 'Jun',
  '07': 'Jul',
  '08': 'Aug',
  '09': 'Sep',
  '10': 'Oct',
  '11': 'Nov',
  '12': 'Dec'
};

class EventDetailPage extends StatefulWidget {
  final EventItem item;

  const EventDetailPage({Key key, this.item}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  String status;
  double distance;

  @override
  void initState() {
    super.initState();
    this.status = _setStatus(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
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
          child: _googleMap(),
        ),
        //TODO: display event detail
        ListView(
          padding: EdgeInsets.fromLTRB(10, 350, 10, 10),
          children: <Widget>[
            //details
            Container(
              width: 450,
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(7)),
              child: _info(),
            ),
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

  _googleMap() {
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

  _info() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
      child: Column(
        children: <Widget>[
          //title
          _title(),

          //location + distance
          _location(),

          //time
          _time(),

          //description
          _description(),

          //TODO: participants
          _participants(),
        ],
      ),
    );
  }

  _title() {
    return Container(
//          color: Colors.grey,
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        widget.item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
      ),
    );
  }

  _location() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            size: 18,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                  '${widget.item.address}, ${widget.item.districtName}',
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),),
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'Distance',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _time() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.access_time,
            size: 18,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(child: Text(
                  '${widget.item.startTime} - ${widget.item.endTime}  ${widget.item.day} ${MONTH[widget.item.month]}',
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),),
                Container(
                  padding: EdgeInsets.only(top: 3),
                  child: _statusText(status),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _description() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.3, color: Colors.grey))),
      padding: EdgeInsets.fromLTRB(15, 15, 13, 15),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'ABOUT',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(
            widget.item.description,
            textAlign: TextAlign.left,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  _participants() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.3, color: Colors.grey))),
      padding: EdgeInsets.fromLTRB(15, 15, 13, 0),
      alignment: Alignment.topLeft,
      child: Text(
        'PARTICIPANTS',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _setStatus(EventItem item) {
    if (item == null) return '';
    var dateTime = new DateTime.now();
    var startDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.startTime}:00');
    var endDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.endTime}:00');

    if (dateTime.isBefore(startDateTime)) {
      return 'Upcoming';
    } else if (dateTime.isAfter(endDateTime)) {
      return 'Past';
    } else {
      return 'Now';
    }
  }

  _statusText(String status) {
    if (status.contains('Upcoming')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 15, color: Colors.blueAccent),
      );
    } else if (status.contains('Now')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 15, color: Colors.red),
      );
    } else if (status.contains('Past')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 15, color: Colors.grey),
      );
    }
    return '';
  }
}
