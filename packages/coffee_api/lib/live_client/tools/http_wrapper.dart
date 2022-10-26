import 'package:http/http.dart' as http;

abstract class HttpWrapper {
  Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body});
  Future<http.Response> get(String url, {Map<String, String>? headers});
}

class CoffeeHttp implements HttpWrapper {
  const CoffeeHttp();

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

// void testApi() async {
  //   // This example uses the Google Books API to search for books about http.
  //   // https://developers.google.com/books/docs/overview
  //   var url = Uri.https('coffee.alexflipnote.dev', '/random.json');

  //   // Await the http get response, then decode the json-formatted response.
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     var file = jsonResponse['file'];
  //     print('This is the image cofee: $file.');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }