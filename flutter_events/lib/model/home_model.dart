import 'package:flutter_events/model/common_model.dart';
import 'package:flutter_events/model/grid_nav_model.dart';

class HomeModel {
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;

  HomeModel({
    this.bannerList,
    this.localNavList,
    this.gridNav,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();


    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['localNavList'] = this.localNavList;
    data['bannerList'] = this.bannerList;
    data['gridNav'] = this.gridNav;

    return data;
  }
}
