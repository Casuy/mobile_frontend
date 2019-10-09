import 'package:flutter/material.dart';
import 'package:flutter_events/dao/search_dao.dart';
import 'package:flutter_events/model/event_model.dart';
import 'package:flutter_events/pages/event_detail_page.dart';
import 'package:flutter_events/widget/search_bar.dart';
import 'package:flutter_events/widget/webview.dart';

const URL = 'http://10.0.2.2:5000/search?keyword=';
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
  EventModel searchModel;
  String keyword;
  String status = '';

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
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      }))),
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
            height: 80,
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
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((EventModel model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      //TODO: Error page
      print(e);
    });
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;

    EventItem item = searchModel.data[position];

    status = _setStatus(item);

    return GestureDetector(
      onTap: () {
        //TODO: go to detail page of a event
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventDetailPage(item: item,)));
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
                    child: Text(
                      '10.5 km',
                      style: TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                _title(item),
                _location(item),
                _time(item),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _setStatus(EventItem item) {
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
        style: TextStyle(fontSize: 16, color: Colors.blueAccent),
      );
    } else if (status.contains('Now')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Colors.red),
      );
    } else if (status.contains('Past')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }
    return '';
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

  _title(EventItem item) {
    if (item == null) return null;
    return Container(
      padding: EdgeInsets.only(top: 5),
      width: 300,
      height: 28,
      child: Text(
        '${item.word}',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  _location(EventItem item) {
    if (item == null) return null;
    return Container(
      width: 300,
      child: Text(
        '${item.location ?? ''}, ${item.districtName ?? ''}',
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  _time(EventItem item) {
    return Container(
      width: 300,
      child: Row(
        children: <Widget>[
          _statusText(status),
          Text(
            '  ·  ${item.startTime} - ${item.endTime}  ${item.day} ${MONTH[item.month]}',
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }
}
