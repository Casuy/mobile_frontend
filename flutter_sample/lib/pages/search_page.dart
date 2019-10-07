import 'package:flutter/material.dart';
import 'package:flutter_sample/dao/search_dao.dart';
import 'package:flutter_sample/model/search_model.dart';
import 'package:flutter_sample/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: '',
            hint: 'popolar events',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
          InkWell(
            onTap: () {
              SearchDao.fetch(
                      'http://10.0.2.2:5000/search?keyword=prprpr')
                  .then((SearchModel value) {
                setState(() {
                  showText = value.data[0].word;
                });
              });
            },
            child: Text('get'),
          ),
          Text(showText),
        ],
      ),
    );
  }

  _onTextChange(text) {}
}
