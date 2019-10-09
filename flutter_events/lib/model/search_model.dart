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
  final String startTime;
  final String endTime;
  final String day;
  final String month;
  final int lat;
  final int lon;
  final String location; //152 La Trobe Street
  final String districtName; //Melb VIC
  final String url;

  SearchItem(
      {this.word,
      this.type,
      this.startTime,
      this.endTime,
      this.day,
      this.month,
      this.lat,
      this.lon,
      this.location,
      this.districtName,
      this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json['word'],
      type: json['type'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      day: json['day'],
      month: json['month'],
      lat: json['lat'],
      lon: json['lon'],
      location: json['location'],
      districtName: json['districtName'],
      url: json['url'],
    );
  }
}
