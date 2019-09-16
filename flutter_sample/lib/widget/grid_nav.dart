import 'package:flutter/material.dart';
import 'package:flutter_sample/model/common_model.dart';
import 'package:flutter_sample/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context)
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.workout != null) {
      items.add(_gridNavItem(context, gridNavModel.workout, true));
    }
    if (gridNavModel.activity != null) {
      items.add(_gridNavItem(context, gridNavModel.activity, false));
    }
    if (gridNavModel.equipment != null) {
      items.add(_gridNavItem(context, gridNavModel.equipment, false));
    }

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItems(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItems(context, gridNavItem.item3, gridNavItem.item4));

    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(
        Expanded(
          child: item,
          flex: 1,
        )
      );
    });

    Color startColor = Color(int.parse('0xff'+gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridNavItem.endColor));

    return Opacity(
      opacity: 0.5,
      child: Container(
        height: 150,
        margin: isFirst ? null : EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
          //color linear gradient
            gradient: LinearGradient(colors: [startColor, endColor])
        ),
        child: Row(children: expandItems),
      ),);

  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
      context,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            height: 100,
            width: 120,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),
            )
          )
        ],
      ),
      model
    );
  }

  _doubleItems(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false),)
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(
      width: 0.8,
      color: Colors.white
    );
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: isFirst ? borderSide : BorderSide.none
          ),
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//              WebView(
//                url: model.url,
//                title: model.title,
//                statusBarColor: model.statusBarColor,
//                hideAppBar: model.hideAppBar,
//              )
//          )
//        );
      },
      child: widget,
    );
  }

}