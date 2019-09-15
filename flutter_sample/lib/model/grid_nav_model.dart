import 'package:flutter_sample/model/common_model.dart';

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
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  factory GridNavItem.fromJson(Map<String,dynamic> json) {
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    data['mainItem'] = this.mainItem;
    data['item1'] = this.item1;
    data['item2'] = this.item2;
    data['item3'] = this.item3;
    data['item4'] = this.item4;

    return data;
  }

}