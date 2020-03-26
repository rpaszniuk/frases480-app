import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
    NetworkHelper(this.path);

    final String path;
    static const String baseUrl = 'https://api.frases480.com/v1';

    Map<String, String> get headers => {
        "Content-Type": 'application/json; charset=UTF-8',
        "Accept": 'application/json',
        "X-Application-Secret": '116af3f80baa15bfd5d32f047e9e9438cb5f833847963b39588bf0e383c7fee38fcf395352a494eacea2e2e0c4e2c6d8957b7949bcd39d40361edf9847d846dc',
    };

    Future<http.Response> get() async {
        return await http.get(baseUrl + path, headers: headers);
    }

    Future<http.Response> post(Map<String, dynamic>  params) async {
        return await http.post(
            baseUrl + path,
            headers: headers,
            body: jsonEncode(params)
        );
    }
}