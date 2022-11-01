import 'dart:convert';
import 'dart:typed_data';

import 'package:coffee_models/coffee_models.dart';

import '../../coffee_api.dart';

/// A Client that makes API calls to https://coffee.alexflipnote.dev
/// to get random coffee images and to get the bytes of a coffee url image.
class CoffeeClient {
  final HttpWrapper http;

  final CoffeeURLFactory urlFactory;

  CoffeeClient({
    this.http = const CoffeeHttp(),
    CoffeeURLFactory? urlFactory,
  }) : urlFactory = urlFactory ?? const CoffeeURLFactory();

  Future<Coffee> loadRandomCoffee() async {
    final response =
        await http.get(urlFactory.getUrl(endpoint: CoffeeEndpoint.random));

    if (response.statusCode != 200) {
      throw HttpException(code: response.statusCode, body: response.body);
    }

    return Coffee.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Uint8List> getImageDataFromCoffee(String coffeeUrl) async {
    final response = await http.get(coffeeUrl);

    if (response.statusCode != 200) {
      throw HttpException(code: response.statusCode, body: response.body);
    }
    return response.bodyBytes;
  }
}
