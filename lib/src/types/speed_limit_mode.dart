part of tesla;

class SpeedLimitMode {
  final TeslaClient client;
  final Map<String, dynamic> json;

  SpeedLimitMode(this.client, this.json);

  bool get isActive => json["active"];
  bool get isPinCodeSet => json["pin_code_set"];

  num get currentLimitMph => json["current_limit_mph"];
  num get maxLimitMph => json["max_limit_mph"];
  num get minLimitMph => json["min_limit_mph"];
}
