class Time {
  int? stTime;
  String? comfortSetting;

  Time({this.stTime, this.comfortSetting});

  Time.fromJson(Map<String, dynamic> json) {
    stTime = json['StTime'];
    comfortSetting = json['ComfortSetting'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StTime'] = this.stTime;
    data['ComfortSetting'] = this.comfortSetting;
    return data;
  }
  Map<String, dynamic> toMap() {
    return {
      'StTime': stTime,
      'ComfortSetting': comfortSetting,
    };
  }
}
