import 'package:flutter_sample/model/config_model.dart';

class GridNavModel{
  final GridNavItem workout;
  final GridNavItem activity;
  final GridNavItem equipment;

  GridNavModel({this.workout, this.activity, this.equipment});

  factory GridNavModel.fromJson(Map<String,dynamic> json){
    return json != null ?
      GridNavModel(
        workout: GridNavItem.fromJson(json['workout']),
        activity: GridNavItem.fromJson(json['activity']),
        equipment: GridNavItem.fromJson(json['equipment'])
      )
      : null;
  }
}

class GridNavItem{
  final String startColor;
  final String endColor;
  final ConfigModel mainItem;
  final ConfigModel item1;
  final ConfigModel item2;
  final ConfigModel item3;
  final ConfigModel item4;

  GridNavItem(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  factory GridNavItem.fromJson(Map<String,dynamic>json){
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: ConfigModel.fromJson(json['mainItem']),
      item1: ConfigModel.fromJson(json['item1']),
      item2: ConfigModel.fromJson(json['item2']),
      item3: ConfigModel.fromJson(json['item3']),
      item4: ConfigModel.fromJson(json['item4'])

    );
  }

}