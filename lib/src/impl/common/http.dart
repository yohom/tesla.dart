library tesla.impl.common.http;

import 'dart:async';

import '../../../tesla.dart';

abstract class TeslaHttpClient implements TeslaClient {
  TeslaHttpClient(this.email, this.password, this.endpoints);

  @override
  final String email;

  @override
  final String password;

  @override
  final TeslaApiEndpoints endpoints;

  Map<String, dynamic> _token;

  @override
  Map<String, dynamic> get token => _token;

  bool isCurrentTokenValid(bool refreshable) {
    if (_token == null) {
      return false;
    }

    if (refreshable) {
      int createdAtMs = _token["created_at"];
      int lifetimeMs = _token["expires_in"];
      var time = new DateTime.fromMillisecondsSinceEpoch(createdAtMs);
      var endOfLifetime = time.add(new Duration(milliseconds: lifetimeMs));
      var differenceFromNow = endOfLifetime.difference(new DateTime.now());

      return differenceFromNow.inSeconds >= -60;
    }
    return true;
  }

  @override
  bool get isAuthorized => isCurrentTokenValid(true);

  @override
  Future login() async {
    if (!isCurrentTokenValid(false)) {
      _token = await sendHttpRequest("/oauth/token",
          body: {
            "grant_type": "password",
            "client_id": endpoints.clientId,
            "client_secret": endpoints.clientSecret,
            "email": email,
            "password": password
          },
          needsToken: false);
      return;
    }

    _token = await sendHttpRequest("/oauth/token",
        body: {
          "grant_type": "refresh_token",
          "client_id": endpoints.clientId,
          "client_secret": endpoints.clientSecret,
          "refresh_token": _token["refresh_token"]
        },
        needsToken: false);
  }

  @override
  Future<List<Vehicle>> listVehicles() async {
    var vehicles = <Vehicle>[];

    var result = await sendHttpRequest("/api/1/vehicles");

    for (var item in result["response"]) {
      vehicles.add(new Vehicle(this, item));
    }

    return vehicles;
  }

  @override
  Future<Vehicle> getVehicle(int id) async {
    return new Vehicle(this,
        await sendHttpRequest("/api/1/vehicles/${id}", extract: "response"));
  }

  @override
  Future<AllVehicleState> getAllVehicleState(int id) async {
    return new AllVehicleState(
        this,
        await sendHttpRequest("/api/1/vehicles/${id}/vehicle_data",
            extract: "response"));
  }

  @override
  Future<ChargeState> getChargeState(int id) async {
    return new ChargeState(
        this,
        await sendHttpRequest("/api/1/vehicles/${id}/data_request/charge_state",
            extract: "response"));
  }

  @override
  Future<DriveState> getDriveState(int id) async {
    return new DriveState(
        this,
        await sendHttpRequest("/api/1/vehicles/${id}/data_request/drive_state",
            extract: "response"));
  }

  @override
  Future<ClimateState> getClimateState(int id) async {
    return new ClimateState(
        this,
        await sendHttpRequest(
            "/api/1/vehicles/${id}/data_request/climate_state",
            extract: "response"));
  }

  @override
  Future<VehicleConfig> getVehicleConfig(int id) async {
    return new VehicleConfig(
        this,
        await sendHttpRequest(
            "/api/1/vehicles/${id}/data_request/vehicle_config",
            extract: "response"));
  }

  @override
  Future<GuiSettings> getGuiSettings(int id) async {
    return new GuiSettings(
        this,
        await sendHttpRequest("/api/1/vehicles/${id}/data_request/gui_settings",
            extract: "response"));
  }

  @override
  Future sendVehicleCommand(int vehicleId, String command,
      {Map<String, dynamic> params}) async {
    var result = await sendHttpRequest(
        "/api/1/vehicles/${vehicleId}/command/${command}",
        body: params == null ? {} : params);
    if (result["response"] == false) {
      var reason = result["reason"];
      if (reason is String && reason.trim().isNotEmpty) {
        throw new Exception("Failed to send command '${command}': ${reason}");
      } else {
        throw new Exception("Failed to send command '${command}'");
      }
    }
  }

  @override
  Future<Vehicle> wake(int id) async {
    return new Vehicle(
        this,
        await sendHttpRequest("/api/1/vehicles/${id}/wake_up",
            body: {}, extract: "response"));
  }

  Future<Map<String, dynamic>> sendHttpRequest(String url,
      {bool needsToken: true, String extract, Map<String, dynamic> body});
}
