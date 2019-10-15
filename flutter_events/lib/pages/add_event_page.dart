import 'package:flutter/material.dart';
import 'package:flutter_events/model/user_model.dart';

class AddEventPage extends StatefulWidget{
  final UserModel userModel;

  const AddEventPage({Key key, this.userModel}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Add event'),
      ),
    );
  }
}