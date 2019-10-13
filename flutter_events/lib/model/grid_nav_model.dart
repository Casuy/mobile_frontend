import 'package:flutter_events/model/common_model.dart';

class GridNavModel {
  final GridNavItem all;

  GridNavModel({this.all});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GridNavModel(
            all: GridNavItem.fromJson(json['all']),
          )
        : null;
  }
}

class GridNavItem {
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;
  final CommonModel item5;
  final CommonModel item6;

  GridNavItem({
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
    this.item6,
  });

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
      item5: CommonModel.fromJson(json['item5']),
      item6: CommonModel.fromJson(json['item6']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['mainItem'] = this.mainItem;
    data['item1'] = this.item1;
    data['item2'] = this.item2;
    data['item3'] = this.item3;
    data['item4'] = this.item4;
    data['item5'] = this.item5;
    data['item6'] = this.item6;

    return data;
  }
}
