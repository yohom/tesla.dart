part of tesla;

class MediaState {
  final TeslaClient client;
  final Map<String, dynamic> json;

  MediaState(this.client, this.json);

  bool get isRemoteControlEnabled => json["remote_control_enabled"];
}
