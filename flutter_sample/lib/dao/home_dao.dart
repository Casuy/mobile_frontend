import 'dart:async';
import 'dart:convert';
import 'package:flutter_sample/model/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'https://raw.githubusercontent.com/Casuy/mobile_frontend/master/flutter_sample/lib/data/home_page.json?token=AJZUEJZBO3HJTP64YJ4GMJ25Q3464';

class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}