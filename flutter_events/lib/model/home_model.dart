import 'package:flutter_events/model/common_model.dart';
import 'package:flutter_events/model/grid_nav_model.dart';

class HomeModel {
  final List<CommonModel> bannerList;
  final GridNavModel gridNav;

  HomeModel({
    this.bannerList,
    this.gridNav,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();


    return HomeModel(
      bannerList: bannerList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['bannerList'] = this.bannerList;
    data['gridNav'] = this.gridNav;

    return data;
  }
}
