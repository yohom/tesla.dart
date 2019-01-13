part of tesla;

class MediaState {
  MediaState(this.client, this.json);

  final TeslaClient client;
  final Map<String, dynamic> json;

  bool get isRemoteControlEnabled => json["remote_control_enabled"];
}
