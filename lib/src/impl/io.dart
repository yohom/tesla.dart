library tesla.impl.io;

import 'dart:async';
import 'dart:convert' hide json;
import 'dart:io';

import '../../tesla.dart';

HttpClient _createHttpClient() {
  var client = new HttpClient();
  client.userAgent = "Tesla.dart";
  return client;
}

class TeslaClientImpl implements TeslaClient {
  TeslaClientImpl(this.email, this.password, this.endpoints,
      {HttpClient client})
      : this.client = client == null ? _createHttpClient() : client;
  final HttpClient client;

  @override
  final String email;

  @override
  final String password;

  @override
  final TeslaApiEndpoints endpoints;

  Map<String, dynamic> _token;

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

  @override
  Future login() async {
    if (!_isCurrentTokenValid(false)) {
      _token = await _post(
          "/oauth/token",
          {
            "grant_type": "password",
            "client_id": endpoints.clientId,
            "client_secret": endpoints.clientSecret,
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
          "client_id": endpoints.clientId,
          "client_secret": endpoints.clientSecret,
          "refresh_token": _token["refresh_token"]
        },
        needsToken: false);
  }

  Future<Map<String, dynamic>> _get(String url,
      {bool needsToken: true, String extract}) async {
    var uri = endpoints.ownersApiUrl.resolve(url);
    var request = await client.getUrl(uri);
    if (needsToken) {
      if (_token == null) {
        await login();
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
      {bool needsToken: true, String extract}) async {
    var uri = endpoints.ownersApiUrl.resolve(url);
    var request = await client.postUrl(uri);
    request.headers.set("User-Agent", "Tesla.dart");
    if (needsToken) {
      if (!_isCurrentTokenValid(true)) {
        await login();
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

  @override
  Future<List<Vehicle>> listVehicles() async {
    var vehicles = <Vehicle>[];

    var result = await _get("/api/1/vehicles");

    for (var item in result["response"]) {
      vehicles.add(new Vehicle(this, item));
    }

    return vehicles;
  }

  @override
  Future<Vehicle> getVehicle(int id) async {
    return new Vehicle(
        this, await _get("/api/1/vehicles/${id}", extract: "response"));
  }

  @override
  Future<AllVehicleState> getAllVehicleState(int id) async {
    return new AllVehicleState(this,
        await _get("/api/1/vehicles/${id}/vehicle_data", extract: "response"));
  }

  @override
  Future<ChargeState> getChargeState(int id) async {
    return new ChargeState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/charge_state",
            extract: "response"));
  }

  @override
  Future<DriveState> getDriveState(int id) async {
    return new DriveState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/drive_state",
            extract: "response"));
  }

  @override
  Future<ClimateState> getClimateState(int id) async {
    return new ClimateState(
        this,
        await _get("/api/1/vehicles/${id}/data_request/climate_state",
            extract: "response"));
  }

  @override
  Future<VehicleConfig> getVehicleConfig(int id) async {
    return new VehicleConfig(
        this,
        await _get("/api/1/vehicles/${id}/data_request/vehicle_config",
            extract: "response"));
  }

  @override
  Future<GuiSettings> getGuiSettings(int id) async {
    return new GuiSettings(
        this,
        await _get("/api/1/vehicles/${id}/data_request/gui_settings",
            extract: "response"));
  }

  @override
  Future sendVehicleCommand(int vehicleId, String command,
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
  }

  @override
  Future<Vehicle> wake(int id) async {
    return new Vehicle(this,
        await _post("/api/1/vehicles/${id}/wake_up", {}, extract: "response"));
  }

  @override
  Future<SummonClient> summon(int vehicleId, String token) async {
    return await SummonClientImpl.connect(
        endpoints.summonConnectUrl.resolve(vehicleId.toString()), email, token);
  }

  @override
  Future close() async {
    await client.close();
  }
}

class SummonClientImpl implements SummonClient {
  SummonClientImpl(this.socket) {
    socket.listen(_onData);
    socket.done.then((_) {
      stopAutoHeartbeat();
      _messageController.close();
    });
  }

  final WebSocket socket;
  final StreamController<SummonMessage> _messageController =
      new StreamController<SummonMessage>();

  @override
  Stream<SummonMessage> get onMessage => _messageController.stream;

  Timer _heartbeat;

  void _onData(input) {
    if (input is String) {
      onMessageReceived(input);
    } else {
      var text = const Utf8Decoder().convert(input);
      onMessageReceived(text);
    }
  }

  void onMessageReceived(String input) {
    var message = const JsonDecoder().convert(input);

    if (message is! Map) {
      return;
    }

    String msgType = message.remove("msg_type");

    SummonMessage event;

    if (msgType == "control:hello") {
      stopAutoHeartbeat();

      var frequency = message["autopark"]["heartbeat_frequency"];
      _heartbeat =
          new Timer.periodic(new Duration(milliseconds: frequency), (_) {
        sendHeartbeat();
      });
      event = new SummonHelloMessage(
          autoparkPauseTimeout: message["autopark"]["autopark_pause_timeout"],
          autoparkStopTimeout: message["autopark"]["autopark_stop_timeout"],
          heartbeatFrequency: message["autopark"]["heartbeat_frequency"],
          connectionTimeout: message["connection_timeout"]);
    } else if (msgType == "control:goodbye") {
      event = new SummonGoodbyeMessage(reason: message["reason"]);
    } else if (msgType == "vehicle_data:location") {
      event = new SummonVehicleLocationMessage(
          latitude: message["latitude"], longitude: message["longitude"]);
    } else if (msgType == "autopark:status") {
      event = new SummonAutoparkStatusMessage(state: message["autopark_state"]);
    } else if (msgType == "autopark:cmd_result") {
      event = new SummonAutoparkCommandResultMessage(
          cmdType: message["cmd_type"],
          failureReason: message["reason"],
          result: message["result"]);
    } else if (msgType == "homelink:cmd_result") {
      event = new SummonHomelinkCommandResultMessage(
          cmdType: message["command_type"],
          failureReason: message["failure_reason"],
          result: message["result"]);
    } else if (msgType == "homelink:status") {
      event = new SummonHomelinkStatusMessage(
          homelinkNearby: message["homelink_nearby"]);
    } else if (msgType == "autopark:error") {
      event = new SummonAutoparkErrorMessage(errorType: message["error_type"]);
    } else if (msgType == "autopark:style") {
      event = new SummonAutoparkStyleMessage(style: message["autopark_style"]);
    } else if (msgType == "autopark:heartbeat_car") {
      event = new SummonAutoparkHeartbeatCarMessage(
          timestamp:
              new DateTime.fromMillisecondsSinceEpoch(message["timestamp"]));
    } else {
      event = new SummonUnknownMessage(msgType, message);
    }

    _messageController.add(event);
  }

  @override
  void send(SummonRequestMessage message) {
    var output = const JsonEncoder().convert(
        <String, dynamic>{"msg_type": message.type}..addAll(message.params));
    socket.add(output);
  }

  void sendHeartbeat() {
    send(new SummonAutoparkHeartbeatAppMessage());
  }

  void stopAutoHeartbeat() {
    if (_heartbeat != null) {
      _heartbeat.cancel();
      _heartbeat = null;
    }
  }

  @override
  void close() {
    socket.close();
  }

  static Future<SummonClient> connect(
      Uri url, String email, String token) async {
    var auth = const Base64Encoder.urlSafe()
        .convert(const Utf8Encoder().convert("${email}:${token}"));

    // ignore: close_sinks
    var socket = await WebSocket.connect(url.toString(),
        headers: {"Authorization": "Basic ${auth}"});
    var client = new SummonClientImpl(socket);
    return client;
  }
}
