import 'package:flutter_events/model/user_model.dart';

class SignupModel {

  final int errno;
  final UserModel data;

  SignupModel({this.errno, this.data});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'];
    UserModel userModel;

    if (dataJson != null) {
      userModel = UserModel.fromJson(json['data']);
    }

    return SignupModel(errno: json['errno'], data: userModel);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['errno'] = this.errno;
    data['data'] = this.data;

    return data;
  }
}
