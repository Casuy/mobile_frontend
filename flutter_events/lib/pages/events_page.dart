import 'package:flutter/material.dart';
import 'package:flutter_events/dao/event_dao.dart';
import 'package:flutter_events/model/event_model.dart';
import 'package:flutter_events/widget/event_list.dart';

const URL = 'http://10.0.2.2:5000/events?type=';

class EventsPage extends StatefulWidget {
  final String eventsUrl;
  final String type;

  const EventsPage({Key key, this.eventsUrl = URL, this.type})
      : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventModel eventModel;


  @override
  void initState() {
    super.initState();
    _getEventsByType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EventList(eventModel: this.eventModel,),
      ),
    );
  }

  _getEventsByType() {
    if (widget.type.length == 0) {
      setState(() {
        eventModel = null;
      });
      return;
    }
    String url = widget.eventsUrl + widget.type;
    EventDao.fetch(url, '').then((EventModel model) {
      setState(() {
        eventModel = model;
      });
    }).catchError((e) {
      //TODO: Error page
      print(e);
    });
  }
}
