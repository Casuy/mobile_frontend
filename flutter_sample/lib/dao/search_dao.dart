import 'dart:async';
import 'dart:convert';
import 'package:flutter_sample/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //render only when input = server response
      SearchModel model = SearchModel.fromJson(result);
//      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
