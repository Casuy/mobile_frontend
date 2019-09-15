import 'package:flutter_sample/model/config_model.dart';

class RecommendModel{
  final String icon;
  final String moreUrl;
  final ConfigModel bigCard1;
  final ConfigModel bigCard2;
  final ConfigModel smallCard1;
  final ConfigModel smallCard2;
  final ConfigModel smallCard3;
  final ConfigModel smallCard4;

  RecommendModel(
      {this.icon,
        this.moreUrl,
        this.bigCard1,
        this.bigCard2,
        this.smallCard1,
        this.smallCard2,
        this.smallCard3,
        this.smallCard4});

  factory RecommendModel.fromJson(Map<String,dynamic>json){
    return RecommendModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: ConfigModel.fromJson(json['bigCard1']),
      bigCard2: ConfigModel.fromJson(json['bigCard2']),
      smallCard1: ConfigModel.fromJson(json['smallCard1']),
      smallCard2: ConfigModel.fromJson(json['smallCard2']),
      smallCard3: ConfigModel.fromJson(json['smallCard3']),
      smallCard4: ConfigModel.fromJson(json['smallCard4']),
    );
  }
}