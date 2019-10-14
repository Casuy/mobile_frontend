import 'package:flutter/material.dart';

const ICONS = ['Recent', 'Joined', 'Nearby', 'Popular'];

class LocalNav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context)
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    ICONS.forEach((name) {
      items.add(_item(context, name));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items
    );
  }

  _item(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
//TODO: navigate to H5?
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//
//          )
//        );
      },
      child: Column(
        children: <Widget>[
          Image(height: 50,width: 50, image: AssetImage(_iconImage(name)),),
          Text(
            name,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  _iconImage(String icon) {
    String path;
    for (final val in ICONS) {
      if (icon.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/local_nav_$path.png';
  }

}