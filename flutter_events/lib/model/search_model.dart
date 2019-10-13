import 'event_item_model.dart';

class SearchModel {
  String keyword;
  final List<EventItemModel> data;

  SearchModel({this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<EventItemModel> data = dataJson.map((i) => EventItemModel.fromJson(i)).toList();
    return SearchModel(data: data);
  }
}


