part of tesla;

class AllVehicleState extends Vehicle {
  AllVehicleState(TeslaClient client, Map<String, dynamic>? json)
      : super(client, json);

  DriveState get driveState => DriveState(client, json!["drive_state"]);
  VehicleState get vehicleState => VehicleState(client, json!["vehicle_state"]);
  VehicleConfig get vehicleConfig =>
      VehicleConfig(client, json!["vehicle_config"]);
  ChargeState get chargeState => ChargeState(client, json!["charge_state"]);
  ClimateState get climateState => ClimateState(client, json!["climate_state"]);
  GuiSettings get guiSettings => GuiSettings(client, json!["gui_settings"]);
}
