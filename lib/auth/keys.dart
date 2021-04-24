import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String? apiSecret;
  final String? baseUrl;

  Secret({this.apiSecret = "", this.baseUrl = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
        apiSecret: jsonMap["api_secret"], baseUrl: jsonMap["base_url"]);
  }
}

class SecretLoader {
  final String? secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath!,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
