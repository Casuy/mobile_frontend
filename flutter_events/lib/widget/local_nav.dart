import 'package:flutter/material.dart';
import 'package:flutter_events/pages/events_page.dart';

const ICONS = ['Recent', 'Joined', 'Nearby', 'Popular'];
const URL = 'http://10.0.2.2:5000/';

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
//TODO: navigate to different pages (google map for nearby) (joined: userId)
        String url = URL + name.toLowerCase();
        print(url);
//        if(name.contains('Nearby')){

//        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  EventsPage(eventsUrl: url, hideIcon: false,)
              )
          );
//        }
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