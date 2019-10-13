class CommonModel{
  final String icon;
  final String title;
  final bool hideAppBar;

  CommonModel({this.icon, this.title, this.hideAppBar});

  factory CommonModel.fromJson(Map<String,dynamic> json){
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        hideAppBar: json['hideAppBar']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['icon'] = this.icon;
    data['title'] = this.title;
    data['hideAppBar'] = this.hideAppBar;

    return data;
  }
}