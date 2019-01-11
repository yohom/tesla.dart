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
  List<OptionCode> get knownOptionCodes =>
      optionCodes.map(OptionCode.lookup).where((item) => item != null).toList();

  List<String> get unknownOptionCodes =>
      optionCodes.where((x) => OptionCode.lookup(x) == null).toList();

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
