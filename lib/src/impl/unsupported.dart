library tesla.impl.unsupported;

import '../../tesla.dart';

class TeslaClientImpl implements TeslaClient {
  TeslaClientImpl(String email, String password, TeslaApiEndpoints endpoints) {
    _fail();
  }

  @override
  String get email => _fail();

  @override
  String get password => _fail();

  @override
  Map<String, dynamic> get token => _fail();

  @override
  bool get isAuthorized => _fail();

  @override
  TeslaApiEndpoints get endpoints => _fail();

  @override
  Future<AllVehicleState> getAllVehicleState(int id) {
    return _fail();
  }

  @override
  Future<ChargeState> getChargeState(int id) {
    return _fail();
  }

  @override
  Future<ClimateState> getClimateState(int id) {
    return _fail();
  }

  @override
  Future<DriveState> getDriveState(int id) {
    return _fail();
  }

  @override
  Future<GuiSettings> getGuiSettings(int id) {
    return _fail();
  }

  @override
  Future<Vehicle> getVehicle(int id) {
    return _fail();
  }

  @override
  Future<VehicleConfig> getVehicleConfig(int id) {
    return _fail();
  }

  @override
  Future<List<Vehicle>> listVehicles() {
    return _fail();
  }

  @override
  Future login() {
    return _fail();
  }

  @override
  Future sendVehicleCommand(int id, String command,
      {Map<String, dynamic> params}) {
    return _fail();
  }

  @override
  Future<SummonClient> summon(int vehicleId, String token) {
    return _fail();
  }

  @override
  Future<Vehicle> wake(int id) {
    return _fail();
  }

  @override
  Future close() {
    return _fail();
  }

  static dynamic _fail() {
    throw "This platform is not supported.";
  }
}
