import 'package:flutter/material.dart';
import 'package:flutter_sample/dao/search_dao.dart';
import 'package:flutter_sample/model/search_model.dart';
import 'package:flutter_sample/widget/search_bar.dart';
import 'package:flutter_sample/widget/webview.dart';

const URL = 'http://10.0.2.2:5000/search?keyword=';
const monthMap = {
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
              hint: 'popolar events',
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

    var dateTime = new DateTime.now();

    if (searchModel == null || searchModel.data == null) return null;

    SearchItem item = searchModel.data[position];

    print(dateTime);
    var startDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.startTime}:00');
    var endDateTime =
        DateTime.parse('2019-${item.month}-${item.day} ${item.endTime}:00');

    if (dateTime.isBefore(startDateTime)) {
      status = 'Upcomming';
    } else if (dateTime.isAfter(endDateTime)) {
      status = 'Past';
    } else {
      status = 'Now';
    }

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
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 28,
                  child: Text(
                    '${item.word}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Container(
                  width: 300,
                  child: Text(
                    '${item.location}, ${item.districtName}',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                Container(
                  width: 300,
                  child: Row(
                    children: <Widget>[
                      _statusText(status),
                      Text(
                        '  ·  ${item.startTime} - ${item.endTime}  ${item.day} ${monthMap[item.month]}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _statusText(String status) {
    if (status == 'Upcomming') {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Color(0xFF2962FF)),
      );
    } else if (status == 'Now') {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Colors.red),
      );
    } else {
      return Text(
        '$status',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }
  }
}
