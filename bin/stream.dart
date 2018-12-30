import 'dart:async';
import 'dart:io';

import 'package:tesla/tesla.dart';

TeslaClient client;

_update() async {
  try {
    for (var vehicle in await client.listAccountVehicles()) {
      var stream = await vehicle.startStream();
      await for (var event in stream.onEvent) {
        print(event);
      }
      print("Closed.");
    }
  } catch (e, stack) {
    stderr.writeln("ERROR: ${e}\n${stack}");
  }
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  await _update();
}
