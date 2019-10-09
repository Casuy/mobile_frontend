import 'package:flutter_events/model/common_model.dart';
import 'package:flutter_events/model/config_model.dart';
import 'package:flutter_events/model/grid_nav_model.dart';
import 'package:flutter_events/model/recommend_model.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final RecommendModel recommend;


  HomeModel(
      {this.config,
        this.bannerList,
        this.localNavList,
        this.subNavList,
        this.gridNav,
        this.recommend});

  factory HomeModel.fromJson(Map<String,dynamic> json){
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
      localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
    bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
    subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    
    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      recommend: RecommendModel.fromJson(json['recommend'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['localNavList'] = this.localNavList;
    data['bannerList'] = this.bannerList;
    data['subNavList'] = this.subNavList;
    data['config'] = this.config;
    data['gridNav'] = this.gridNav;
    data['recommend'] = this.recommend;

    return data;
  }
}