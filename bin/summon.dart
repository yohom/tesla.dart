import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tesla/tesla.dart';

TeslaClient client;

Future<SummonClient> _begin() async {
  var vehicles = await client.listAccountVehicles();
  var vehicle = vehicles.first;
  var summon = await vehicle.summon();
  summon.onMessage.listen((event) {
    if (event is SummonAutoparkErrorMessage) {
      print("[Autopark Error] ${event.errorType}");
    } else if (event is SummonAutoparkCommandResultMessage) {
      print("[Autopark Result] ${event.cmdType} was success? ${event.result}");
      if (!event.result) {
        print("  Failure Reason: ${event.failureReason}");
      }
    } else if (event is SummonAutoparkStatusMessage) {
      print("[Autopark Status] ${event.state}");
    } else if (event is SummonAutoparkStyleMessage) {
      print("[Autopark Style] ${event.style}");
    } else if (event is SummonGoodbyeMessage) {
      print("[Goodbye] ${event.reason}");
    }
  });
  return summon;
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  var summon = await _begin();
  await for (var line in stdin.transform(const Utf8Decoder()).transform(const LineSplitter())) {
    if (line == "forward") {
      var vehicle = (await client.listAccountVehicles()).first;
      var state = await vehicle.getAllVehicleState();

      await summon.send(new SummonAutoparkForwardMessage(state.driveState.latitude, state.driveState.longitude));
      print("[Sent] Forward");
    } else if (line == "reverse") {
      var vehicle = (await client.listAccountVehicles()).first;
      var state = await vehicle.getAllVehicleState();

      await summon.send(new SummonAutoparkReverseMessage(state.driveState.latitude, state.driveState.longitude));
      print("[Sent] Reverse");
    } else if (line == "abort") {
      await summon.send(new SummonAutoparkAbortMessage());
      print("[Sent] Abort");
    }
  }
}
