library tesla.tool;

import 'dart:io';

import 'tesla.dart';
export 'tesla.dart';

const List<String> _emailEnvVars = const <String>[
  "TESLA_EMAIL",
  "TESLA_USERNAME",
  "TESLA_USER"
];

const List<String> _passwordEnvVars = const <String>[
  "TESLA_PASSWORD",
  "TESLA_PASS",
  "TESLA_PWD"
];

String _getEnvKey(List<String> possible) {
  for (var key in possible) {
    if (Platform.environment.containsKey(key) &&
        Platform.environment[key].isNotEmpty) {
      return Platform.environment[key];
    }

    var dartEnvValue = new String.fromEnvironment(key);
    if (dartEnvValue != null) {
      return dartEnvValue;
    }
  }

  throw new Exception(
      "Expected environment variable '${possible.first}' to be present.");
}

TeslaClient getTeslaClient() {
  var email = _getEnvKey(_emailEnvVars);
  var password = _getEnvKey(_passwordEnvVars);

  return new TeslaClient(email, password);
}
