part of tesla;

abstract class SummonMessage {
  SummonMessage(this.type);

  final String type;
}

abstract class SummonRequestMessage extends SummonMessage {
  SummonRequestMessage(String type) : super(type);

  Map<String, dynamic> get params;
}

class SummonHelloMessage extends SummonMessage {
  SummonHelloMessage(
      {this.autoparkPauseTimeout,
      this.autoparkStopTimeout,
      this.heartbeatFrequency,
      this.connectionTimeout})
      : super("control:hello");

  final int autoparkPauseTimeout;
  final int autoparkStopTimeout;
  final int heartbeatFrequency;
  final int connectionTimeout;
}

class SummonGoodbyeMessage extends SummonMessage {
  SummonGoodbyeMessage({this.reason}) : super("control:goodbye");

  final String reason;
}

class SummonPongMessage extends SummonMessage {
  SummonPongMessage({this.timestamp}) : super("control:pong");

  final DateTime timestamp;
}

class SummonAutoparkCommandResultMessage extends SummonMessage {
  SummonAutoparkCommandResultMessage(
      {this.cmdType, this.failureReason, this.result})
      : super("autopark:cmd_result");

  final String cmdType;
  final String failureReason;
  final bool result;
}

class SummonAutoparkErrorMessage extends SummonMessage {
  SummonAutoparkErrorMessage({this.errorType}) : super("autopark:error");

  final String errorType;
}

class SummonHomelinkCommandResultMessage extends SummonMessage {
  SummonHomelinkCommandResultMessage(
      {this.cmdType, this.failureReason, this.result})
      : super("homelink:cmd_result");

  final String cmdType;
  final String failureReason;
  final bool result;
}

class SummonAutoparkStyleMessage extends SummonMessage {
  SummonAutoparkStyleMessage({this.style}) : super("autopark:style");

  final String style;
}

class SummonAutoparkStatusMessage extends SummonMessage {
  SummonAutoparkStatusMessage({this.state}) : super("autopark:status");

  final String state;
}

class SummonHomelinkStatusMessage extends SummonMessage {
  SummonHomelinkStatusMessage({this.homelinkNearby}) : super("homelink:status");

  final bool homelinkNearby;
}

class SummonVehicleLocationMessage extends SummonMessage {
  SummonVehicleLocationMessage({this.latitude, this.longitude})
      : super("vehicle_data:location");

  final num latitude;
  final num longitude;
}

class SummonAutoparkHeartbeatCarMessage extends SummonMessage {
  SummonAutoparkHeartbeatCarMessage({this.timestamp})
      : super("autopark:heartbeat_car");

  final DateTime timestamp;
}

class SummonAutoparkHeartbeatAppMessage extends SummonRequestMessage {
  SummonAutoparkHeartbeatAppMessage() : super("autopark:heartbeat_app");

  @override
  Map<String, dynamic> get params =>
      {"timestamp": new DateTime.now().millisecondsSinceEpoch};
}

class SummonAutoparkForwardMessage extends SummonRequestMessage {
  SummonAutoparkForwardMessage(this.latitude, this.longitude)
      : super("autopark:cmd_forward");

  final num latitude;
  final num longitude;

  @override
  Map<String, dynamic> get params =>
      {"latitude": latitude, "longitude": longitude};
}

class SummonAutoparkReverseMessage extends SummonRequestMessage {
  SummonAutoparkReverseMessage(this.latitude, this.longitude)
      : super("autopark:cmd_reverse");

  final num latitude;
  final num longitude;

  @override
  Map<String, dynamic> get params =>
      {"latitude": latitude, "longitude": longitude};
}

class SummonAutoparkAbortMessage extends SummonRequestMessage {
  SummonAutoparkAbortMessage() : super("autopark:cmd_abort");

  @override
  Map<String, dynamic> get params => {};
}

class SummonHomelinkTriggerMessage extends SummonRequestMessage {
  SummonHomelinkTriggerMessage(this.latitude, this.longitude)
      : super("homelink:cmd_trigger");

  final num latitude;
  final num longitude;

  @override
  Map<String, dynamic> get params =>
      {"latitude": latitude, "longitude": longitude};
}

class SummonUnknownMessage extends SummonMessage {
  SummonUnknownMessage(String type, this.content) : super(type);

  final Map<String, dynamic> content;
}

class SummonClient {
  SummonClient(this.socket) {
    socket.listen(_onData);
    socket.done.then((_) {
      stopAutoHeartbeat();
      _messageController.close();
    });
  }

  final WebSocket socket;
  final StreamController<SummonMessage> _messageController =
      new StreamController<SummonMessage>();

  Stream<SummonMessage> get onMessage => _messageController.stream;

  Timer _heartbeat;

  void _onData(input) {
    if (input is String) {
      _onMessageReceived(input);
    } else {
      var text = const Utf8Decoder().convert(input);
      _onMessageReceived(text);
    }
  }

  void _onMessageReceived(String input) {
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

  void close() {
    socket.close();
  }

  static Future<SummonClient> connect(
      String email, String token, int vehicleId) async {
    var auth = const Base64Encoder.urlSafe()
        .convert(const Utf8Encoder().convert("${email}:${token}"));

    // ignore: close_sinks
    var socket = await WebSocket.connect(
        "wss://streaming.vn.teslamotors.com/connect/${vehicleId}",
        headers: {"Authorization": "Basic ${auth}"});
    var client = new SummonClient(socket);
    return client;
  }
}
