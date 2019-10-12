import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget{
  final String type;

  const EventsPage({Key key, this.type='All'}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.type),
      ),
    );
  }
}