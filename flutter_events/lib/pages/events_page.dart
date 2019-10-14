import 'package:flutter/material.dart';
import 'package:flutter_events/dao/search_dao.dart';
import 'package:flutter_events/model/search_model.dart';
import 'package:flutter_events/widget/event_list.dart';

const URL = 'http://10.0.2.2:5000/events?type=';
//const URL = 'http://172.20.10.5:8080/http_server/events?type=';

class EventsPage extends StatefulWidget {
  final String eventsUrl;
  final String type;
  final bool hideIcon;

  const EventsPage({Key key, this.eventsUrl = URL, this.type, this.hideIcon=true})
      : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  SearchModel searchModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EventList(searchModel: this.searchModel),
      ),
    );
  }

  _fetchData() {
//    if (widget.type.length == 0) {
//      setState(() {
//        searchModel = null;
//      });
//      return;
//    }

    String url= widget.eventsUrl;

    if(widget.type != null) {
      url = widget.eventsUrl + widget.type;
    }
    SearchDao.fetch(url, '').then((SearchModel model) {
      setState(() {
        searchModel = model;
      });
    }).catchError((e) {
      //TODO: Error page
      print(e);
    });
  }
}
