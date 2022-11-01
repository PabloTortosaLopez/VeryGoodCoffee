import 'package:http/http.dart' as http;

abstract class HttpWrapper {
  Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body});
  Future<http.Response> get(String url, {Map<String, String>? headers});
}

class CoffeeHttp implements HttpWrapper {
  const CoffeeHttp();

  /// Not in use
  @override
  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) {
    return http.post(Uri.parse(url), headers: headers, body: body);
  }

  @override
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
  }) {
    return http.get(Uri.parse(url), headers: headers);
  }
}
