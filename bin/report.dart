import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tesla/tesla.dart';

TeslaClient client;

_updateVehicle(Vehicle vehicle, [int schedulerTime = 30]) async {
  try {
    vehicle = await client.getAccountVehicle(vehicle.id);

    if (vehicle.state != "online") {
      schedulerTime = 10;

      var json = new Map<String, dynamic>.from(vehicle.json);
      json["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
      print(const JsonEncoder().convert(json));
    } else {
      schedulerTime = 30;
      var state = await vehicle.getAllVehicleState();

      if (state.driveState.shiftState == null) {
        schedulerTime = 500;
      }

      var json = new Map<String, dynamic>.from(state.json);
      json["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
      print(const JsonEncoder().convert(json));
    }
  } catch (e, stack) {
    stderr.writeln("ERROR: ${e}\n${stack}");
  }

  new Timer(new Duration(seconds: schedulerTime), () {
    _updateVehicle(vehicle, schedulerTime);
  });
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  for (var vehicle in await client.listAccountVehicles()) {
    new Future(() async {
      await _updateVehicle(vehicle);
    });
  }
}
