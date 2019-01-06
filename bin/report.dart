import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tesla/tesla.dart';

TeslaClient client;

_update() async {
  try {
    for (var vehicle in await client.listAccountVehicles()) {
      if (vehicle.state == "asleep") {
        continue;
      }
      var state = await vehicle.getAllVehicleState();
      var json = new Map<String, dynamic>.from(state.json);
      json["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
      print(const JsonEncoder().convert(json));
    }
  } catch (e, stack) {
    stderr.writeln("ERROR: ${e}\n${stack}");
  }

  new Timer(const Duration(seconds: 30), _update);
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  await _update();
}
