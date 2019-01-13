import 'package:tesla/tool.dart';

Future main() async {
  var client = getTeslaClient();

  for (var vehicle in await client.listAccountVehicles()) {
    await vehicle.scheduleSoftwareUpdate();
  }

  client.close();
}
