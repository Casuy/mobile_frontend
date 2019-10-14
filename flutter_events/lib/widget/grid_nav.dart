import 'package:flutter/material.dart';
import 'package:flutter_events/pages/events_page.dart';

const TYPES = ['Ball', 'Bike', 'Exercise', 'Running', 'Swim', 'Yoga'];

class GridNav extends StatelessWidget {
  const GridNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 7),
      child: _gridNavItems(context),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsPage(
                      type: title.toLowerCase(),
                    )));
      },
      child: widget,
    );
  }

  _gridNavItems(BuildContext context) {
    return Column(
      children: <Widget>[_firstLine(context), _secondLine(context)],
    );
  }

  _firstLine(BuildContext context) {
    Widget mainItem = _mainItem(context);
    Widget doubleItems = _doubleItems(context, 'Exercise', 'Running');
    return Row(
      children: <Widget>[mainItem, doubleItems],
    );
  }

  _secondLine(BuildContext context) {
    Widget firstDouble = _doubleItems(context, 'Ball', 'Bike');
    Widget secondDouble = _doubleItems(context, 'Swim', 'Yogo');
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[firstDouble, secondDouble],
      ),
    );
  }

  _doubleItems(BuildContext context, String top, String bottom) {
    Widget topItem = _item(context, top, true);
    Widget bottomItem = _item(context, bottom, false);
    return Column(
      children: <Widget>[topItem, bottomItem],
    );
  }

  _mainItem(BuildContext context) {
    BorderSide borderSide = BorderSide(width: 5, color: Color(0xfff2f2f2));
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        border: Border(right: borderSide),
//        color: Color(0xffe50914),
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xffbe0027), Color(0xffe50914)]),
      ),
      child: _wrapGesture(
          context,
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text(
              'All',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
          'All'),
    );
  }

  _item(BuildContext context, String title, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 5, color: Color(0xfff2f2f2));
    return Container(
      height: 100,
      width: 200,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
//        color: Color(0xffe50914),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffe50914), Color(0xffbe0027)]),
        border: Border(
            right: borderSide, bottom: isFirst ? borderSide : BorderSide.none),
      ),
      child: _wrapGesture(
          context,
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
              softWrap: true,
            ),
          ),
          title),
    );
  }
}
