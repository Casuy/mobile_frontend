import 'package:flutter/material.dart';
import 'package:flutter_sample/dao/search_dao.dart';
import 'package:flutter_sample/model/search_model.dart';
import 'package:flutter_sample/widget/search_bar.dart';
import 'package:flutter_sample/widget/webview.dart';

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
  SearchModel searchModel;
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
    SearchDao.fetch(url, text).then((SearchModel model) {
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

    SearchItem item = searchModel.data[position];

    status = _setStatus(item);

    return GestureDetector(
      onTap: () {
        //TODO: go to detail page of a event
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: 'Detail',
                    )));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 10, 17, 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                alignment: Alignment.topCenter,
                child: Image(
                    height: 28,
                    width: 28,
                    image: AssetImage(_typeImage(item.type))),
              ),
              _title(item),
            ],),
            Column(
              children: <Widget>[
                _location(item),
                _time(item),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _setStatus(SearchItem item) {
    if (item == null) return '';
    var dateTime = new DateTime.now();
    var startDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.startTime}:00');
    var endDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.endTime}:00');

    if (dateTime.isBefore(startDateTime)) {
      return 'Upcomming';
    } else if (dateTime.isAfter(endDateTime)) {
      return 'Past';
    } else {
      return 'Now';
    }
  }

  _statusText(String status) {
    if (status.contains('Upcomming')) {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Color(0xFF2962FF)),
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

  _title(SearchItem item) {
    if (item == null) return null;
    return Container(
      width: 300,
      height: 28,
      child: Text(
        '${item.word}',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  _location(SearchItem item) {
    if (item == null) return null;
    return Container(
      width: 300,
      child: Text(
        '${item.location ?? ''}, ${item.districtName ?? ''}',
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  _time(SearchItem item) {
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
