import 'package:flutter/material.dart';
import 'package:flutter_events/model/event_model.dart';

class EventDetailPage extends StatefulWidget {
  final EventItem item;

  const EventDetailPage({Key key, this.item}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Colors.red, Colors.white),
          //TODO: display event detail
          Center(
            child: Text('Event detail ${widget.item.word}'),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    return Container(
      height: 60,
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            //Return button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 26),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            // Title
            Positioned(
              left: 0,
              right: 0,
              top: 28,
              child: Center(
                child: Text(
                  'Detail',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
