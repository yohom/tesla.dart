import 'dart:async';

import 'package:tesla/tool.dart';

Future main() async {
  var client = getTeslaClient();
  for (var vehicle in await client.listVehicles()) {
    print("- ${vehicle.displayName}");
  }
}
