part of tesla;

class VehicleInfo {
  final TeslaClient client;
  final Map<String, dynamic> json;

  int get id => json["id"];
  int get vehicleId => json["vehicle_id"];
  String get vin => json["vin"];
  String get displayName => json["display_name"];
  String get optionCodes => json["option_codes"];
  String get color => json["color"];
  List<String> get tokens => json["tokens"].cast<String>();
  String get state => json["state"];
  bool get isInService => json["in_service"];
  String get idString => json["id_s"];
  bool get isCalendarEnabled => json["calendar_enabled"];
  int get apiVersion => json["api_version"];
  String get backseatToken => json["backseat_token"];
  String get backseatTokenUpdatedAt => json["backseat_token_updated_at"].toString();

  VehicleInfo(this.client, this.json);

  Future<AllVehicleState> getAllVehicleState() async {
    return await client.getAllVehicleState(id);
  }

  Future<ChargeState> getChargeState() async {
    return await client.getChargeState(id);
  }

  Future<VehicleInfo> wake() async {
    return await client.wake(id);
  }

  Future<bool> sendCommand(String command, {Map<String, dynamic> params, bool assertCommand: false}) async {
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
    await sendCommand("remote_start_drive", params: {
      "password": client.password
    }, assertCommand: true);
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
    await sendCommand("set_charge_limit", params: {
      "percent": percent
    }, assertCommand: true);
  }

  Future startCharge() async {
    await sendCommand("charge_start", assertCommand: true);
  }

  Future stopCharge() async {
    await sendCommand("charge_stop", assertCommand: true);
  }

  Future actuateTrunk({String trunk: "rear"}) async {
    await sendCommand("actuate_trunk", params: {
      "which_trunk": trunk
    }, assertCommand: true);
  }

  Future<SummonClient> summon() async {
    return await client.summon(tokens.first, vehicleId);
  }

  Future<VehicleStream> startStream() async {
    var stream = new VehicleStream(client.client, client.email, tokens.first, vehicleId);
    await stream.start();
    return stream;
  }
}

class AllVehicleState extends VehicleInfo {
  final TeslaClient client;

  AllVehicleState(this.client, Map<String, dynamic> json) : super(client, json);

  DriveState get driveState => new DriveState(client, json["drive_state"]);
  VehicleState get vehicleState => new VehicleState(client, json["vehicle_state"]);
  ChargeState get chargeState => new ChargeState(client, json["charge_state"]);
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
  DateTime get timestampTime => new DateTime.fromMillisecondsSinceEpoch(timestamp);
  String get vehicleName => json["vehicle_name"];
  bool get isValetMode => json["valet_mode"];
  bool get isValetPinNeeded => json["valet_pin_needed"];
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
  DateTime get timestampTime => new DateTime.fromMillisecondsSinceEpoch(timestamp);
}
