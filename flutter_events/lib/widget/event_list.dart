import 'package:flutter/material.dart';
import 'package:flutter_events/model/event_model.dart';
import 'package:flutter_events/pages/event_detail_page.dart';
import 'package:geolocator/geolocator.dart';

const TYPES = ['ball', 'bike', 'exercise', 'running', 'swim', 'yoga'];

class EventList extends StatefulWidget{
  final EventModel eventModel;

  const EventList({Key key, this.eventModel}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList>{

  @override
  Widget build(BuildContext context) {
    return _eventsList();
  }

  _eventsList() {
    return ListView.builder(
        itemCount: widget.eventModel?.data?.length ?? 0,
        itemBuilder: (BuildContext context, int position) {
          return _item(position);
        });
  }

  _item(int position) {
    if (widget.eventModel == null || widget.eventModel.data == null) return null;

    EventItem item = widget.eventModel.data[position];

    String status = _setStatus(item);

    Position target = new Position(latitude: item.lat, longitude: item.lon);
    double distance = 0.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailPage(
                  item: item,
                )));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 15, 13),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              height: 54,
              width: 70,
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  //icon image
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image(
                        height: 33,
                        width: 33,
                        image: AssetImage(_typeImage(item.type))),
                  ),
                  //distance
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: _distanceText(item, distance),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                _titleText(item),
                _locationText(item),
                _timeText(item, status),
              ],
            )
          ],
        ),
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

  _typeImage(String type) {
    if (type == null) {
      return 'images/type_exercise.png';
    }

    String path = 'exercise';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _distanceText(EventItem item, double distance) {
    String result;

    if (item == null) return null;

    if (distance < 100) {
      result = '< 100 m';
    } else if (distance >= 100 && distance < 1000) {
      result = distance.round().toString() + ' m';
    } else {
      result = (distance / 1000).toStringAsFixed(1) + ' km';
    }

    return Text(
      result,
      style: TextStyle(color: Colors.black45, fontSize: 14),
    );
  }

  _titleText(EventItem item) {
    if (item == null) return '';
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 3),
      width: 300,
      child: Text(
        '${item.title}',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  _locationText(EventItem item) {
    if (item == null) return '';
    return Container(
      width: 300,
      child: Text(
        '${item.address ?? ''}, ${item.districtName ?? ''}',
        softWrap: true,
        style: TextStyle(fontSize: 15, color: Colors.black54),
      ),
    );
  }

  _timeText(EventItem item, String status) {
    if (item == null) return null;
    return Container(
      width: 300,
      child: Row(
        children: <Widget>[
          _statusText(status),
          Text(
            '  ·  ${item.startTime} - ${item.endTime}  ${item.day} ${MONTH[item.month]}',
            style: TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
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