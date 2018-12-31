import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tesla/tesla.dart';

TeslaClient client;

_handleEvent(event) {
  if (event is SummonAutoparkErrorMessage) {
    print("[Autopark Error] ${event.errorType}");
  } else if (event is SummonAutoparkCommandResultMessage) {
    if (!event.result) {
      print("[Autopark Failure] ${event.cmdType} failed: ${event.failureReason}");
    } else {
      print("[Autopark Success] ${event.cmdType}");
    }
  } else if (event is SummonAutoparkStatusMessage) {
    print("[Autopark Status] ${event.state}");
  } else if (event is SummonAutoparkStyleMessage) {
    print("[Autopark Style] ${event.style}");
  } else if (event is SummonGoodbyeMessage) {
    print("[Goodbye] ${event.reason}");
  } else {
    print("[Unknown Event] ${event.runtimeType}");
  }
}

Future<SummonClient> _begin() async {
  var vehicles = await client.listAccountVehicles();
  var vehicle = vehicles.first;
  var summon = await vehicle.summon();
  summon.onMessage.listen(_handleEvent);
  return summon;
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  var summon = await _begin();
  stdout.write("> ");
  await for (var line in stdin.transform(const Utf8Decoder()).transform(const LineSplitter())) {
    if (line == "forward") {
      var vehicle = (await client.listAccountVehicles()).first;
      var state = await vehicle.getAllVehicleState();

      await summon.send(new SummonAutoparkForwardMessage(
        state.driveState.latitude,
        state.driveState.longitude
      ));
      print("[Sent] Forward");
    } else if (line == "reverse") {
      var vehicle = (await client.listAccountVehicles()).first;
      var state = await vehicle.getAllVehicleState();

      await summon.send(new SummonAutoparkReverseMessage(
        state.driveState.latitude,
        state.driveState.longitude
      ));
      print("[Sent] Reverse");
    } else if (line == "abort") {
      await summon.send(new SummonAutoparkAbortMessage());
      print("[Sent] Abort");
    }
    stdout.write("> ");
  }
}
