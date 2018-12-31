import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tesla/tesla.dart';
import 'package:postgres/postgres.dart';

TeslaClient client;
PostgreSQLConnection conn;

_update(Vehicle vehicle) async {
  try {
    var state = await vehicle.getAllVehicleState();
    var vid = state.id;
    await conn.execute(
        "INSERT INTO telemetry (timestamp, vid, state) VALUES (@timestamp, @vid, @state)",
        substitutionValues: {
          "timestamp": new DateTime.now(),
          "vid": vid,
          "state": const JsonEncoder().convert(state.json)
        });
    print("[Updated] ${vid}");
  } catch (e, stack) {
    stderr.writeln("ERROR: ${e}\n${stack}");
    exit(1);
  }

  new Future.delayed(const Duration(seconds: 15), () async {
    await _update(vehicle);
  });
}

main(List<String> args) async {
  conn = new PostgreSQLConnection(args[2], 5432, "nikola",
      username: args[3], password: args[4]);

  await conn.open();

  client = new TeslaClient(args[0], args[1]);

  for (var vehicle in await client.listAccountVehicles()) {
    await vehicle.wake();
    new Future.delayed(const Duration(seconds: 2), () async {
      await _update(vehicle);
    });
  }
}
