import 'package:tesla/tool.dart';

main() async {
  var client = getTeslaClient();

  for (var vehicle in await client.listAccountVehicles()) {
    await vehicle.wake();
    var state = await vehicle.getAllVehicleState();
    print("${state.displayName}:");
    print("  VIN: ${state.vin}");
    print("  State: ${state.state}");
    print(
        "  Location: ${state.driveState.latitude} LAT, ${state.driveState.longitude} LONG");
    print(
        "  Codes:\n${state.knownOptionCodes.map((x) => '    ${x}').join('\n')}");
  }

  client.close();
}
