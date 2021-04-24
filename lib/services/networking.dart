import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frases480/auth/keys.dart';

class NetworkHelper {
  NetworkHelper(this.path);

  final String path;
  String? baseUrl = '';

  Map<String, String> headers = {
    "Content-Type": 'application/json; charset=UTF-8',
    "Accept": 'application/json',
    "X-Application-Secret": '',
  };

  Future<http.Response> get() async {
    await loadSecrets();
    return await http
        .get(Uri.parse(baseUrl! + path),
            headers: headers)
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> post(Map<String, dynamic> params) async {
    await loadSecrets();
    return await http
        .post(Uri.parse(baseUrl! + path),
            headers: headers, body: jsonEncode(params))
        .timeout(const Duration(seconds: 10));
  }

  Future loadSecrets() {
    return SecretLoader(secretPath: 'secrets.json').load().then((Secret s) {
      headers['X-Application-Secret'] = s.apiSecret!;
      baseUrl = s.baseUrl;
    });
  }
}
