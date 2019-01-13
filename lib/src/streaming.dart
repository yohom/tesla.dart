part of tesla;

class VehicleStreamEvent {
  final DateTime timestamp;
  final num speed;
  final num odometer;
  final num soc;
  final num elevation;
  final num heading;
  final num estimatedHeading;
  final num estimatedLatitude;
  final num estimatedLongitude;
  final num power;
  final String shiftState;
  final num range;
  final num estimatedRange;

  VehicleStreamEvent(
      {this.timestamp,
      this.speed,
      this.elevation,
      this.estimatedLatitude,
      this.estimatedLongitude,
      this.estimatedHeading,
      this.power,
      this.shiftState,
      this.range,
      this.estimatedRange,
      this.heading,
      this.odometer,
      this.soc});
}

class VehicleStream {
  static const String _streamParameters =
      "speed,odometer,soc,elevation,est_heading,est_lat,est_lng,power,shift_state,range,est_range,heading";

  final HttpClient client;
  final int vehicleId;
  final String email;
  final String token;

  final StreamController<VehicleStreamEvent> _eventController =
      new StreamController<VehicleStreamEvent>();

  Stream<VehicleStreamEvent> get onEvent => _eventController.stream;

  VehicleStream(this.client, this.email, this.token, this.vehicleId);

  Future start() async {
    var url = Uri.parse(
        "https://streaming.vn.teslamotors.com/stream/${vehicleId}/?values=${_streamParameters}");
    var request = await client.getUrl(url);
    var auth = const Base64Encoder.urlSafe()
        .convert(const Utf8Encoder().convert("${email}:${token}"));
    request.headers.set("Authorization", "Basic ${auth}");
    request.bufferOutput = false;
    var response = await request.close();

    if (response.statusCode != 200) {
      throw new Exception("Failed to start vehicle stream.");
    }

    response.listen(_onData, onDone: () {
      _eventController.close();
    }, onError: (e, stack) {
      _eventController.addError(e, stack);
    });
  }

  void _onData(List<int> bytes) {
    var line = const Utf8Decoder().convert(bytes);
    var parts = line.split(",");
    print(parts);
  }
}
