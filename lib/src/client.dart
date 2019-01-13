part of tesla;

abstract class TeslaApiEndpoints {
  factory TeslaApiEndpoints.standard() {
    return new TeslaStandardApiEndpoints();
  }

  Uri get ownersApiUrl;
  Uri get summonConnectUrl;
  String get clientId;
  String get clientSecret;
}

class TeslaStandardApiEndpoints implements TeslaApiEndpoints {
  @override
  final Uri ownersApiUrl = Uri.parse("https://owner-api.teslamotors.com/");

  @override
  final Uri summonConnectUrl =
      Uri.parse("wss://streaming.vn.teslamotors.com/connect/");

  @override
  final String clientId =
      "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384";

  @override
  final String clientSecret =
      "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3";
}

abstract class TeslaClient {
  factory TeslaClient(String email, String password,
      {TeslaApiEndpoints endpoints}) {
    return new TeslaClientImpl(email, password,
        endpoints == null ? new TeslaApiEndpoints.standard() : endpoints);
  }

  String get email;
  String get password;

  Map<String, dynamic> get token;
  bool get isAuthorized;

  TeslaApiEndpoints get endpoints;

  Future login();

  Future<List<Vehicle>> listVehicles();
  Future<Vehicle> getVehicle(int id);
  Future<AllVehicleState> getAllVehicleState(int id);
  Future<ChargeState> getChargeState(int id);
  Future<DriveState> getDriveState(int id);
  Future<ClimateState> getClimateState(int id);
  Future<VehicleConfig> getVehicleConfig(int id);
  Future<GuiSettings> getGuiSettings(int id);

  Future sendVehicleCommand(int id, String command,
      {Map<String, dynamic> params});
  Future<Vehicle> wake(int id);

  Future<SummonClient> summon(int vehicleId, String token);

  Future close();
}
