import 'package:flutter_sample/model/common_model.dart';
import 'package:flutter_sample/model/config_model.dart';
import 'package:flutter_sample/model/grid_nav_model.dart';
import 'package:flutter_sample/model/recommend_model.dart';

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

}