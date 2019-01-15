library tesla.impl.browser;

import 'dart:async';
import 'dart:convert' hide json;
import 'dart:html';

import '../../tesla.dart';
import 'common/http.dart';

class TeslaClientImpl extends TeslaHttpClient {
  TeslaClientImpl(String email, String password, TeslaApiEndpoints endpoints)
      : super(email, password, endpoints);

  @override
  Future<Map<String, dynamic>> sendHttpRequest(String url,
      {bool needsToken: true,
      String extract,
      Map<String, dynamic> body}) async {
    var uri = endpoints.ownersApiUrl.resolve(url);
    var request = new HttpRequest();
    request.open(body == null ? "GET" : "POST", uri.toString());
    if (needsToken) {
      if (!isCurrentTokenValid(true)) {
        await login();
      }
      request.setRequestHeader(
          "Authorization", "Bearer ${token['access_token']}");
    }

    if (body != null) {
      request.setRequestHeader(
          "Content-Type", "application/json; charset=utf-8");
      request.send(const JsonEncoder().convert(body));
    }

    await request.onLoadEnd.first;

    var content = request.responseText;
    if (request.status != 200) {
      throw new Exception(
          "Failed to perform action. (Status Code: ${request.status})\n${content}");
    }
    var result = const JsonDecoder().convert(content);

    if (result is! Map) {
      throw new Exception("Invalid Tesla API response.\n${result}");
    }

    if (extract != null) {
      return result[extract];
    }
    return result;
  }

  @override
  Future<SummonClient> summon(int vehicleId, String token) async {
    throw "Summon is not supported.";
  }

  @override
  Future close() async {}
}
