import 'dart:io';

import 'package:tesla/tool.dart';

TeslaClient client;

Future _update() async {
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

Future main(List<String> args) async {
  client = getTeslaClient();

  await _update();
}
