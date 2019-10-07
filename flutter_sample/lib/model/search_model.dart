class SearchModel {
  String keyword;
  final List<SearchItem> data;

  SearchModel({this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<SearchItem> data =
        dataJson.map((i) => SearchItem.fromJson(i)).toList();
    return SearchModel(data: data);
  }
}

class SearchItem {
  final String word; //Display name
  final String type; //Running
  final String time;
  final String location;
  final String districtName; //上海
  final String url;

  SearchItem(
      {this.word,
      this.type,
      this.time,
      this.location,
      this.districtName,
      this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json['word'],
      type: json['type'],
      time: json['time'],
      location: json['location'],
      districtName: json['districtName'],
      url: json['url'],
    );
  }
}
