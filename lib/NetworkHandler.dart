import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
   String baseUrl = "http://10.0.2.2:4000";
  var log = Logger();

  Future get(String url) async {
    url = formatter(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

  Future<dynamic> put(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.put(Uri.parse(url),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
