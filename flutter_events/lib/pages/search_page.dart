import 'package:flutter/material.dart';
import 'package:flutter_events/dao/event_dao.dart';
import 'package:flutter_events/model/event_model.dart';
import 'package:flutter_events/widget/event_list.dart';
import 'package:flutter_events/widget/search_bar.dart';

const URL = 'http://10.0.2.2:5000/search?keyword=';
const TYPES = ['ball', 'bike', 'exercise', 'running', 'swim', 'yoga'];

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  EventModel eventModel;
  String keyword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                  flex: 1,
                  child:
                  EventList(eventModel: eventModel,)
              )),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 75,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: 'Try running, exercise',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _onTextChange(text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        eventModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    EventDao.fetch(url, text).then((EventModel model) {
      if (model.keyword == keyword) {
        setState(() {
          eventModel = model;
        });
      }
    }).catchError((e) {
      //TODO: Error page
      print(e);
    });
  }

}
