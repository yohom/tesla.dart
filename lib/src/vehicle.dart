part of tesla;

class Vehicle {
  final TeslaClient client;
  final Map<String, dynamic> json;

  int get id => json["id"];
  int get vehicleId => json["vehicle_id"];
  String get vin => json["vin"];
  String get displayName => json["display_name"];
  String get rawOptionCodes => json["option_codes"];
  List<String> get optionCodes => rawOptionCodes.split(",");
  List<OptionCode> get knownOptionCodes => optionCodes
    .map(OptionCode.lookup)
    .where((item) => item != null)
    .toList();

  List<String> get unknownOptionCodes => optionCodes
    .where((x) => OptionCode.lookup(x) == null)
    .toList();

  String get color => json["color"];
  List<String> get tokens => json["tokens"].cast<String>();
  String get state => json["state"];
  bool get isInService => json["in_service"];
  String get idString => json["id_s"];
  bool get isCalendarEnabled => json["calendar_enabled"];
  int get apiVersion => json["api_version"];
  String get backseatToken => json["backseat_token"];
  String get backseatTokenUpdatedAt =>
      json["backseat_token_updated_at"].toString();

  Vehicle(this.client, this.json);

  Future<AllVehicleState> getAllVehicleState() async {
    return await client.getAllVehicleState(id);
  }

  Future<ChargeState> getChargeState() async {
    return await client.getChargeState(id);
  }

  Future<DriveState> getDriveState() async {
    return await client.getDriveState(id);
  }

  Future<VehicleConfig> getVehicleConfig() async {
    return await client.getVehicleConfig(id);
  }

  Future<ClimateState> getClimateState() async {
    return await client.getClimateState(id);
  }

  Future<GuiSettings> getGuiSettings() async {
    return await client.getGuiSettings(id);
  }

  Future<Vehicle> wake({bool retry: true}) async {
    if (!retry) {
      return await client.wake(id);
    }

    for (var i = 1; i <= 20; i++) {
      var result = await client.wake(id);
      if (result.state == "online") {
        return result;
      }
      await new Future.delayed(const Duration(seconds: 2));
    }

    throw new Exception("Failed to wake up vehicle.");
  }

  Future<bool> sendCommand(String command,
      {Map<String, dynamic> params, bool assertCommand: false}) async {
    var result = await client.sendVehicleCommand(id, command, params: params);
    if (assertCommand && !result) {
      throw new Exception("Failed to perform command '${command}'");
    }
    return result;
  }

  Future flashLights() async {
    await sendCommand("flash_lights", assertCommand: true);
  }

  Future honkHorn() async {
    await sendCommand("honk_horn", assertCommand: true);
  }

  Future remoteStartDrive() async {
    await sendCommand("remote_start_drive",
        params: {"password": client.password}, assertCommand: true);
  }

  Future unlock() async {
    await sendCommand("door_unlock", assertCommand: true);
  }

  Future lock() async {
    await sendCommand("door_lock", assertCommand: true);
  }

  Future openChargePort() async {
    await sendCommand("charge_port_door_open", assertCommand: true);
  }

  Future closeChargePort() async {
    await sendCommand("charge_port_door_close", assertCommand: true);
  }

  Future setChargeLimitStandard() async {
    await sendCommand("charge_standard", assertCommand: true);
  }

  Future setChargeLimitMaxRange() async {
    await sendCommand("charge_max_range", assertCommand: true);
  }

  Future setChargeLimit(int percent) async {
    await sendCommand("set_charge_limit",
        params: {"percent": percent}, assertCommand: true);
  }

  Future startCharge() async {
    await sendCommand("charge_start", assertCommand: true);
  }

  Future stopCharge() async {
    await sendCommand("charge_stop", assertCommand: true);
  }

  Future actuateTrunk({String trunk: "rear"}) async {
    await sendCommand("actuate_trunk",
        params: {"which_trunk": trunk}, assertCommand: true);
  }

  Future startAutoConditioning() async {
    await sendCommand("auto_conditioning_start", assertCommand: true);
  }

  Future stopAutoConditioning() async {
    await sendCommand("auto_conditioning_stop", assertCommand: true);
  }

  Future setAutoConditioningTemps(num driver, num passenger) async {
    await sendCommand("set_temps",
        params: {"driver_temp": driver, "passenger_temp": passenger},
        assertCommand: true);
  }

  Future sendNavigationRequest(String input) async {
    await sendCommand("navigation_request",
        params: {
          "type": "share_ext_content_raw",
          "value": {"android.intent.extra.TEXT": input},
          "locale": "en-US",
          "timestamp_ms": new DateTime.now().millisecondsSinceEpoch.toString()
        },
        assertCommand: true);
  }

  Future mediaTogglePlayback() async {
    await sendCommand("media_toggle_playback", assertCommand: true);
  }

  Future mediaNextTrack() async {
    await sendCommand("media_next_track", assertCommand: true);
  }

  Future mediaPreviousTrack() async {
    await sendCommand("media_prev_track", assertCommand: true);
  }

  Future mediaPreviousFavorite() async {
    await sendCommand("media_prev_fav", assertCommand: true);
  }

  Future mediaNextFavorite() async {
    await sendCommand("media_next_fav", assertCommand: true);
  }

  Future mediaVolumeUp() async {
    await sendCommand("media_volume_up", assertCommand: true);
  }

  Future mediaVolumeDown() async {
    await sendCommand("media_volume_down", assertCommand: true);
  }

  Future setValetMode({bool enabled: true, String pin: ""}) async {
    await sendCommand("set_valet_mode",
        params: {"on": enabled, "password": pin}, assertCommand: true);
  }

  Future resetValetPin() async {
    await sendCommand("reset_valet_pin", assertCommand: true);
  }

  Future setSteeringWheelHeater(bool enabled) async {
    await sendCommand("remote_steering_wheel_heater_request",
        params: {"on": enabled}, assertCommand: true);
  }

  Future setSeatHeater(SeatHeater heater, int level) async {
    await sendCommand("remote_seat_heater_request",
        params: {"heater": heater.id, "level": level}, assertCommand: true);
  }

  Future setSpeedLimit(int mph) async {
    await sendCommand("speed_limit_set_limit",
        params: {"limit_mph": mph}, assertCommand: true);
  }

  Future controlSunroof(bool vent) async {
    await sendCommand("sun_roof_control",
        params: {"state": vent ? "vent" : "close"}, assertCommand: true);
  }

  Future speedLimitActivate({String pin: ""}) async {
    await sendCommand("speed_limit_activate",
        params: {"pin": pin}, assertCommand: true);
  }

  Future speedLimitDeactivate(String pin) async {
    await sendCommand("speed_limit_deactivate",
        params: {"pin": pin}, assertCommand: true);
  }

  Future speedLimitClearPin(String pin) async {
    await sendCommand("speed_limit_clear_pin",
        params: {"pin": pin}, assertCommand: true);
  }

  Future<SummonClient> summon() async {
    return await client.summon(tokens.first, vehicleId);
  }

  Future<VehicleStream> startStream() async {
    var stream =
        new VehicleStream(client.client, client.email, tokens.first, vehicleId);
    await stream.start();
    return stream;
  }
}

class AllVehicleState extends Vehicle {
  final TeslaClient client;

  AllVehicleState(this.client, Map<String, dynamic> json) : super(client, json);

  DriveState get driveState => new DriveState(client, json["drive_state"]);
  VehicleState get vehicleState =>
      new VehicleState(client, json["vehicle_state"]);
  VehicleConfig get vehicleConfig =>
      new VehicleConfig(client, json["vehicle_config"]);
  ChargeState get chargeState => new ChargeState(client, json["charge_state"]);
  ClimateState get climateState =>
      new ClimateState(client, json["climate_state"]);
  GuiSettings get guiSettings => new GuiSettings(client, json["gui_settings"]);
}

class VehicleState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  VehicleState(this.client, this.json);

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

  SpeedLimitMode get speedLimitMode =>
      new SpeedLimitMode(client, json["speed_limit_mode"]);
  MediaState get mediaState => new MediaState(client, json["media_state"]);
}

class VehicleConfig {
  final TeslaClient client;
  final Map<String, dynamic> json;

  VehicleConfig(this.client, this.json);

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

class MediaState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  MediaState(this.client, this.json);

  bool get isRemoteControlEnabled => json["remote_control_enabled"];
}

class ClimateState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  ClimateState(this.client, this.json);

  bool get batteryHeater => json["battery_heater"];
  bool get batteryHeaterNoPower => json["battery_heater_no_power"];
  num get driverTemperatureSetting => json["driver_temp_setting"];
  int get fanStatus => json["fan_status"];
  num get insideTemperature => json["inside_temp"];
  bool get isAutoConditioningOn => json["is_auto_conditioning_on"];
  bool get isClimateOn => json["is_climate_on"];
  bool get isFrontDefrosterOn => json["is_front_defroster_on"];
  bool get isPreconditioning => json["is_preconditioning"];
  bool get isRearDefrosterOn => json["is_rear_defroster_on"];
  num get leftTemperatureDirection => json["left_temp_direction"];
  num get maxAvailableTemperature => json["max_avail_temp"];
  num get minAvailableTemperature => json["min_avail_temp"];
  num get outsideTemperature => json["outside_temp"];
  num get passengerTemperatureSetting => json["passenger_temp_setting"];
  bool get isRemoteHeaterControlEnabled =>
      json["remote_heater_control_enabled"];
  num get rightTemperatureDirection => json["right_temp_direction"];
  int get seatHeaterLeft => json["seat_heater_left"];
  int get seatHeaterRearCenter => json["seat_heater_rear_center"];
  int get seatHeaterRearLeft => json["seat_heater_rear_left"];
  int get seatHeaterRearRight => json["seat_heater_rear_right"];
  int get seatHeaterRight => json["seat_heater_right"];
  bool get hasSideMirrorHeaters => json["side_mirror_heaters"];
  bool get hasSmartPreconditioning => json["smart_preconditioning"];
  bool get hasSteeringWheelHeater => json["steering_wheel_heater"];
  bool get hasWiperBladeHeater => json["wiper_blade_heater"];

  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
}

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

class ChargeState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  ChargeState(this.client, this.json);

  bool get isBatteryHeaterOn => json["battery_heater_on"];

  num get batteryLevel => json["battery_level"];
  num get usableBatteryLevel => json["usable_battery_level"];

  num get batteryRange => json["battery_range"];

  num get chargeCurrentRequest => json["charge_current_request"];
  num get chargeCurrentRequestMax => json["charge_current_requyest_max"];
  bool get chargeEnableRequest => json["charge_enable_request"];
  num get chargeEnergyAdded => json["charge_energy_added"];
  num get chargeLimitSoc => json["charge_limit_soc"];
  num get chargeLimitSocMax => json["charge_limit_soc_max"];
  num get chargeLimitSocMin => json["charge_limit_soc_min"];
  num get chargeLimitSocStd => json["charge_limit_soc_std"];

  num get chargeMilesAddedIdeal => json["charge_miles_added_ideal"];
  num get chargeMilesAddedRated => json["charge_miles_added_rated"];

  bool get isChargePortDoorOpen => json["charge_port_door_open"];
  String get chargePortLatch => json["charge_port_latch"];

  num get chargeRate => json["charge_rate"];
  bool get chargeToMaxRange => json["charge_to_max_range"];

  num get chargerActualCurrent => json["charger_actual_current"];
  num get chargerPilotCurrent => json["charger_pilot_current"];

  String get chargingState => json["charging_state"];
  num get estimatedBatteryRange => json["est_battery_range"];
  num get idealBatteryRange => json["ideal_battery_range"];

  bool get isNotEnoughPowerToHeat => json["not_enough_power_to_heat"];
  bool get isTripCharging => json["trip_charging"];

  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
}

class DriveState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  DriveState(this.client, this.json);

  int get gpsAsOf => json["gps_as_of"];
  DateTime get gpsAsOfTime => new DateTime.fromMillisecondsSinceEpoch(gpsAsOf);

  num get heading => json["heading"];
  num get latitude => json["latitude"];
  num get longitude => json["longitude"];

  int get nativeLocationSupported => json["native_location_supported"];
  num get nativeLatitude => json["native_latitide"];
  num get nativeLongitude => json["native_longitude"];
  String get nativeType => json["native_type"];

  num get power => json["power"];
  String get shiftState => json["shift_state"];
  num get speed => json["speed"];

  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
}

class GuiSettings {
  final TeslaClient client;
  final Map<String, dynamic> json;

  GuiSettings(this.client, this.json);

  bool get is24HourTime => json["gui_24_hour_time"];
  String get chargeRateUnits => json["gui_charge_rate_units"];
  String get distanceUnits => json["gui_distance_units"];
  String get rangeDisplay => json["gui_range_display"];
  String get temperatureUnits => json["gui_temperature_units"];

  int get timestamp => json["timestamp"];
  DateTime get timestampTime =>
      new DateTime.fromMillisecondsSinceEpoch(timestamp);
}
