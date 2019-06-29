part of tesla;

class VehicleState implements TeslaObject {
  VehicleState(this.client, this.json);

  @override
  final TeslaClient client;

  @override
  final Map<String, dynamic> json;

  int get apiVersion => json["api_version"];
  String get autoparkStateV2 => json["autopark_state_v2"];
  String get autoparkStyle => json["autopark_style"];
  bool get isCalendarEnabled => json["calendar_enabled"];
  String get carVersion => json["car_version"];
  int get centerDisplayState => json["center_display_state"];
  int get df => json["df"];
  int get dr => json["dr"];
  int get ft => json["ft"];
  bool get isHomeLinkNearby => json["homelink_nearby"];
  bool get isUserPresent => json["is_user_present"];
  String get lastAutoparkError => json["last_autopark_error"];
  bool get isLocked => json["locked"];
  num get odometer => json["odometer"];
  bool get isNotificationsSupported => json["notifications_supported"];
  bool get isParsedCalendarSupported => json["parsed_calendar_supported"];
  int get pf => json["pf"];
  int get pr => json["pr"];
  bool get isRemoteStart => json["remote_start"];
  bool get isRemoteStartSupported => json["remote_start_supported"];
  int get rt => json["rt"];
  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
  String get vehicleName => json["vehicle_name"];
  bool get isValetMode => json["valet_mode"];
  bool get isValetPinNeeded => json["valet_pin_needed"];
  bool get isSentryMode => json["sentry_mode"];

  SpeedLimitMode get speedLimitMode =>
      new SpeedLimitMode(client, json["speed_limit_mode"]);

  MediaState get mediaState => new MediaState(client, json["media_state"]);
}

class VehicleConfig implements TeslaObject {
  VehicleConfig(this.client, this.json);

  @override
  final TeslaClient client;

  @override
  final Map<String, dynamic> json;

  bool get canAcceptNavigationRequests =>
      json["can_accept_navigation_requests"];
  bool get canActuateTrunks => json["can_actuate_trunks"];
  String get carSpecialType => json["car_special_type"];
  String get carType => json["car_type"];
  String get chargePortType => json["charge_port_type"];
  bool get isEuVehicle => json["eu_vehicle"];
  String get exteriorColor => json["exterior_color"];
  bool get hasAirSuspension => json["has_air_suspension"];
  bool get hasLudicrousMode => json["has_ludicrous_mode"];
  bool get hasMotorizedChargePort => json["motorized_charge_port"];
  String get performanceConfig => json["perf_config"];
  bool get plg => json["plg"];
  int get rearSeatHeaters => json["rear_seat_heaters"];
  int get rearSeatType => json["rear_seat_type"];
  bool get rhd => json["rhd"];
  String get roofColor => json["roof_color"];
  int get seatType => json["seat_type"];
  String get spoilerType => json["spoiler_type"];
  int get sunroofInstalled => json["sun_roof_installed"];
  String get thirdRowSeats => json["third_row_seats"];
  String get trimBadging => json["trim_badging"];
  String get wheelType => json["wheel_type"];

  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
}
