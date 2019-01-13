import 'dart:async';

import 'package:tesla/tool.dart';

Future main() async {
  var client = getTeslaClient();

  for (var vehicle in await client.listAccountVehicles()) {
    await vehicle.wake();
    var state = await vehicle.getAllVehicleState();
    print("${state.displayName}:");
    print("  VIN: ${state.vin}");
    print("  State: ${state.state}");
    print("  Software Version: ${state.vehicleState.carVersion}");
    print(
        "  Location: ${state.driveState.latitude} LAT, ${state.driveState.longitude} LONG");
  }

  client.close();
}
