import 'package:tesla/tesla.dart';

TeslaClient client;

_run() async {
  var vehicles = await client.listAccountVehicles();
  var vehicle = vehicles.first;
  var summon = await vehicle.summon();
  summon.onMessage.listen((event) {
    print("${event.runtimeType}");
  });
}

main(List<String> args) async {
  client = new TeslaClient(args[0], args[1]);

  await _run();
}
