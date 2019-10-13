class EventItemModel {
  final String title; //Display name
  final String type; //Running
  final String description;

  final String startTime;
  final String endTime;
  final String day;
  final String month;

  final double lat;
  final double lon;
  final String address; //152 La Trobe Street
  final String districtName; //Melbourne VIC
  final String url;

  EventItemModel(
      {this.title,
        this.type,
        this.description,
        this.startTime,
        this.endTime,
        this.day,
        this.month,
        this.lat,
        this.lon,
        this.address,
        this.districtName,
        this.url});

  factory EventItemModel.fromJson(Map<String, dynamic> json) {
    return EventItemModel(
      title: json['title'],
      type: json['type'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      day: json['day'],
      month: json['month'],
      lat: json['lat'],
      lon: json['lon'],
      address: json['address'],
      districtName: json['districtName'],
      url: json['url'],
    );
  }
}