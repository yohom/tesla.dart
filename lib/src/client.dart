part of tesla;

HttpClient _createHttpClient() {
  var client = new HttpClient();
  client.userAgent = "Tesla.dart";
  return client;
}

/// The Tesla API client.
class TeslaClient {
  final HttpClient client;
  final String email;
  final String password;

  Map<String, dynamic> _token;
  Map<String, dynamic> get token => _token;

  TeslaClient(this.email, this.password,
      {HttpClient client, Map<String, dynamic> token})
      : this.client = client == null ? _createHttpClient() : client,
        this._token = token;

  bool _isCurrentTokenValid(bool refreshable) {
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

  Future authorize() async {
    if (!_isCurrentTokenValid(false)) {
      _token = await _post(
          "/oauth/token",
          {
            "grant_type": "password",
            "client_id": _teslaClientId,
            "client_secret": _teslaClientSecret,
            "email": email,
            "password": password
          },
          needsToken: false);
      return;
    }

    _token = await _post(
        "/oauth/token",
        {
          "grant_type": "refresh_token",
          "client_id": _teslaClientId,
          "client_secret": _teslaClientSecret,
          "refresh_token": _token["refresh_token"]
        },
        needsToken: false);
  }

  Future<Map<String, dynamic>> _get(String url,
      {bool needsToken: true, String extract: null}) async {
    var uri = _teslaOwnersUrl.resolve(url);
    var request = await client.getUrl(uri);
    if (needsToken) {
      if (_token == null) {
        await authorize();
      }
      request.headers.add("Authorization", "Bearer ${_token['access_token']}");
    }
    var response = await request.close();
    var content = await response.transform(const Utf8Decoder()).join();
    if (response.statusCode != 200) {
      throw new Exception(
          "Failed to fetch data. (Status Code: ${response.statusCode})\n${content}");
    }
    var result = const JsonDecoder().convert(content);
    if (extract != null) {
      return result[extract];
    }
    return result;
  }

  Future<Map<String, dynamic>> _post(String url, Map<String, dynamic> input,
      {bool needsToken: true, String extract: null}) async {
    var uri = _teslaOwnersUrl.resolve(url);
    var request = await client.postUrl(uri);
    request.headers.set("User-Agent", "Tesla.dart");
    if (needsToken) {
      if (!_isCurrentTokenValid(true)) {
        await authorize();
      }
      request.headers.add("Authorization", "Bearer ${_token['access_token']}");
    }
    request.headers.contentType =
        new ContentType("application", "json", charset: "utf-8");
    request.write(const JsonEncoder().convert(input));
    var response = await request.close();
    var content = await response.transform(const Utf8Decoder()).join();
    if (response.statusCode != 200) {
      throw new Exception(
          "Failed to perform action. (Status Code: ${response.statusCode})\n${content}");
    }
    var result = const JsonDecoder().convert(content);

    if (result is! Map) {
      throw new Exception("Invalid Tesla API response.\n${result}");
    }

    if (extract != null) {
      return result[extract];
    }
    return result;
  }

  Future close() async {
    await client.close();
  }

  Future<List<Vehicle>> listAccountVehicles() async {
    var vehicles = <Vehicle>[];

    var result = await _get("/api/1/vehicles");

    for (var item in result["response"]) {
      vehicles.add(new Vehicle(this, item));
    }

    return vehicles;
  }

  Future<Vehicle> getAccountVehicle(int id) async {
    return new Vehicle(
        this, await _get("/api/1/vehicles/${id}", extract: "response"));
  }

  Future<AllVehicleState> getAllVehicleState(int id) async {
    return new AllVehicleState(this,
        await _get("/api/1/vehicles/${id}/vehicle_data", extract: "response"));
  }

  Future<ChargeState> getChargeState(int id) async {
    return new ChargeState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/charge_state",
            extract: "response"));
  }

  Future<DriveState> getDriveState(int id) async {
    return new DriveState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/drive_state",
            extract: "response"));
  }

  Future<ClimateState> getClimateState(int id) async {
    return new ClimateState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/climate_state",
            extract: "response"));
  }

  Future<VehicleConfig> getVehicleConfig(int id) async {
    return new VehicleConfig(
        this,
        await _get("/api/1/vehicles/${id}/data_request/vehicle_config",
            extract: "response"));
  }

  Future<GuiSettings> getGuiSettings(int id) async {
    return new GuiSettings(
        this,
        await _get("/api/1/vehicles/${id}/data_request/gui_settings",
            extract: "response"));
  }

  Future<bool> sendVehicleCommand(int vehicleId, String command,
      {Map<String, dynamic> params}) async {
    var result = await _post("/api/1/vehicles/${vehicleId}/command/${command}",
        params == null ? {} : params);
    if (result["response"] == false) {
      var reason = result["reason"];
      if (reason is String && reason.trim().isNotEmpty) {
        throw new Exception("Failed to send command '${command}': ${reason}");
      } else {
        throw new Exception("Failed to send command '${command}'");
      }
    }
    return false;
  }

  Future<Vehicle> wake(int vehicleId) async {
    return new Vehicle(
        this,
        await _post("/api/1/vehicles/${vehicleId}/wake_up", {},
            extract: "response"));
  }

  Future<SummonClient> summon(String token, int vehicleId) async {
    return await SummonClient.connect(email, token, vehicleId);
  }
}
