part of tesla;

class TeslaClient {
  final HttpClient client;
  final String email;
  final String password;

  Map<String, dynamic> _token;

  TeslaClient(this.email, this.password, {HttpClient client}) :
    this.client = client == null ? new HttpClient() : client;

  bool _isCurrentTokenValid(bool refreshable) {
    if (_token == null) {
      return false;
    }

    if (refreshable) {
      int createdAtMs = _token["created_at"];
      int lifetimeMs = _token["expires_in"];
      var time = new DateTime.fromMillisecondsSinceEpoch(createdAtMs);
      return time.add(new Duration(milliseconds: lifetimeMs)).difference(new DateTime.now()).inSeconds >= -60;
    }
    return true;
  }

  Future authorize() async {
    if (!_isCurrentTokenValid(false)) {
      _token = await _post("/oauth/token", {
        "grant_type": "password",
        "client_id": _teslaClientId,
        "client_secret": _teslaClientSecret,
        "email": email,
        "password": password
      }, needsToken: false);
      return;
    }

    _token = await _post("/oauth/token", {
      "grant_type": "refresh_token",
      "client_id": _teslaClientId,
      "client_secret": _teslaClientSecret,
      "refresh_token": _token["refresh_token"]
    }, needsToken: false);
  }

  Future<Map<String, dynamic>> _get(String url, {bool needsToken: true, String extract: null}) async {
    var uri = _teslaOwnersUrl.resolve(url);
    var request = await client.getUrl(uri);
    request.headers.set("User-Agent", "Tesla.dart");
    if (needsToken) {
      if (_token == null) {
        await authorize();
      }
      request.headers.add("Authorization", "Bearer ${_token['access_token']}");
    }
    var response = await request.close();
    var content = await response.transform(const Utf8Decoder()).join();
    var result = const JsonDecoder().convert(content);
    if (extract != null) {
      return result[extract];
    }
    return result;
  }

  Future<Map<String, dynamic>> _post(String url, Map<String, dynamic> input, {bool needsToken: true, String extract: null}) async {
    var uri = _teslaOwnersUrl.resolve(url);
    var request = await client.postUrl(uri);
    request.headers.set("User-Agent", "Tesla.dart");
    if (needsToken) {
      if (!_isCurrentTokenValid(true)) {
        await authorize();
      }
      request.headers.add("Authorization", "Bearer ${_token['access_token']}");
    }
    request.headers.contentType = ContentType.JSON;
    request.write(const JsonEncoder().convert(input));
    var response = await request.close();
    var content = await response.transform(const Utf8Decoder()).join();
    if (response.statusCode != 200) {
      throw new Exception("Failed to perform action.\n${content}");
    }
    var result = const JsonDecoder().convert(content);
    if (extract != null) {
      return result[extract];
    }
    return result;
  }

  Future close() async {
    await client.close();
  }

  Future<List<VehicleInfo>> listAccountVehicles() async {
    var vehicles = <VehicleInfo>[];

    var result = await _get("/api/1/vehicles");

    for (var item in result["response"]) {
      vehicles.add(new VehicleInfo(this, item));
    }

    return vehicles;
  }

  Future<AllVehicleState> getAllVehicleState(int id) async {
    return new AllVehicleState(this, await _get("/api/1/vehicles/${id}/vehicle_data", extract: "response"));
  }

  Future<ChargeState> getChargeState(int id) async {
    return new ChargeState(this, await _get("/api/1/vehicles/${id}/data_request/charge_state", extract: "response"));
  }

  Future<bool> sendVehicleCommand(int vehicleId, String command, {Map<String, dynamic> params}) async {
    var result = await _post("/api/1/vehicles/${vehicleId}/command/${command}", params == null ? {} : params);
    if (result["response"] is bool) {
      return result["response"];
    }
    return false;
  }

  Future<VehicleInfo> wake(int vehicleId) async {
    return new VehicleInfo(this, await _post("/api/1/vehicles/${vehicleId}/wake_up", {}, extract: "response"));
  }
}
