class EventModel {
  String keyword;
  final List<EventItem> data;

  EventModel({this.data});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<EventItem> data =
        dataJson.map((i) => EventItem.fromJson(i)).toList();
    return EventModel(data: data);
  }
}

class EventItem {
  final String word; //Display name
  final String type; //Running
  final String startTime;
  final String endTime;
  final String day;
  final String month;
  final int lat;
  final int lon;
  final String location; //152 La Trobe Street
  final String districtName; //Melbourne VIC
  final String url;

  EventItem(
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

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
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
