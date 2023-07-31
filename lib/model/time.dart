class Time {
  int? stTime;
  String? comfortSetting;

  Time({this.stTime, this.comfortSetting});

  Time.fromJson(Map<String, dynamic> json) {
    stTime = json['StTime'];
    comfortSetting = json['ComfortSetting'];
  }

}
