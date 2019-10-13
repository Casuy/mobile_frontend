import 'package:flutter/material.dart';
import 'package:flutter_events/model/common_model.dart';
import 'package:flutter_events/model/grid_nav_model.dart';
import 'package:flutter_events/pages/events_page.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: _gridNavItems(context));
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.all != null) {
      items.add(
        _gridNavItem1(context, gridNavModel.all, true),
      );
      items.add(
        _gridNavItem2(context, gridNavModel.all, false),
      );
    }
    return items;
  }

  _gridNavItem1(BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItems(context, gridNavItem.item1, gridNavItem.item2));

    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    return Container(
      height: 300,
      margin: isFirst ? null : EdgeInsets.only(top: 15),
      color: Colors.red,
      child: Row(children: expandItems),
    );
  }

  _gridNavItem2(BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_doubleItems(context, gridNavItem.item3, gridNavItem.item4));
    items.add(_doubleItems(context, gridNavItem.item5, gridNavItem.item6));

    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    return Container(
      height: 300,
      margin: isFirst ? null : EdgeInsets.only(top: 7),
      color: Colors.red,
      child: Row(children: expandItems),
    );
  }

  _doubleItems(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(child: _item(context, topItem, true)),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Container(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Image.network(
                model.icon,
                fit: BoxFit.contain,
                height: 200,
                width: 120,
                alignment: AlignmentDirectional.bottomEnd,
              ),
              Container(
                  margin: EdgeInsets.only(top: 11),
                  child: Text(
                    model.title,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ))
            ],
          ),
        ),
        model);
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.5, color: Color(0xfff2f2f2));
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderSide,
              right: borderSide,
              bottom: isFirst ? borderSide : BorderSide.none),
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsPage(
                      type: model.title,
                    )));
      },
      child: widget,
    );
  }
}
