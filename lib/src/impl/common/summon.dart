library tesla.impl.common.summon;

import 'dart:async';
import 'dart:convert';

import '../../../tesla.dart';

abstract class SummonCommonClient implements SummonClient {
  final StreamController<SummonMessage> _messageController =
      StreamController<SummonMessage>();

  Timer? _heartbeat;

  @override
  Stream<SummonMessage> get onMessage => _messageController.stream;

  @override
  void close() {
    _messageController.close();
  }

  void onMessageReceived(String input) {
    var message = const JsonDecoder().convert(input);

    if (message is! Map) {
      return;
    }

    String? msgType = message.remove("msg_type");

    SummonMessage event;

    if (msgType == "control:hello") {
      stopAutoHeartbeat();

      var frequency = message["autopark"]["heartbeat_frequency"];
      _heartbeat = Timer.periodic(Duration(milliseconds: frequency), (_) {
        sendHeartbeat();
      });
      event = SummonHelloMessage(
          autoparkPauseTimeout: message["autopark"]["autopark_pause_timeout"],
          autoparkStopTimeout: message["autopark"]["autopark_stop_timeout"],
          heartbeatFrequency: message["autopark"]["heartbeat_frequency"],
          connectionTimeout: message["connection_timeout"]);
    } else if (msgType == "control:goodbye") {
      event = SummonGoodbyeMessage(reason: message["reason"]);
    } else if (msgType == "vehicle_data:location") {
      event = SummonVehicleLocationMessage(
          latitude: message["latitude"], longitude: message["longitude"]);
    } else if (msgType == "autopark:status") {
      event = SummonAutoparkStatusMessage(state: message["autopark_state"]);
    } else if (msgType == "autopark:cmd_result") {
      event = SummonAutoparkCommandResultMessage(
          cmdType: message["cmd_type"],
          failureReason: message["reason"],
          result: message["result"]);
    } else if (msgType == "homelink:cmd_result") {
      event = SummonHomelinkCommandResultMessage(
          cmdType: message["command_type"],
          failureReason: message["failure_reason"],
          result: message["result"]);
    } else if (msgType == "homelink:status") {
      event = SummonHomelinkStatusMessage(
          homelinkNearby: message["homelink_nearby"]);
    } else if (msgType == "autopark:error") {
      event = SummonAutoparkErrorMessage(errorType: message["error_type"]);
    } else if (msgType == "autopark:style") {
      event = SummonAutoparkStyleMessage(style: message["autopark_style"]);
    } else if (msgType == "autopark:heartbeat_car") {
      event = SummonAutoparkHeartbeatCarMessage(
          timestamp: DateTime.fromMillisecondsSinceEpoch(message["timestamp"]));
    } else if (msgType == "autopark:smart_summon_viz") {
      event = SummonVisualizationMessage(
          path: (message["path"] as List<dynamic>).cast<double>());
    } else {
      event = SummonUnknownMessage(msgType, message as Map<String, dynamic>);
    }

    _messageController.add(event);
  }

  void sendHeartbeat() {
    send(SummonAutoparkHeartbeatAppMessage());
  }

  void stopAutoHeartbeat() {
    if (_heartbeat != null) {
      _heartbeat!.cancel();
      _heartbeat = null;
    }
  }
}
