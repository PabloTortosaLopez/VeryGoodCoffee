import 'dart:convert';
import 'dart:typed_data';

import 'package:coffee_models/coffee_models.dart';
import 'package:flutter/widgets.dart';

import '../../coffee_api.dart';

class CoffeeClient {
  @protected
  final HttpWrapper http;

  @protected
  final CoffeeURLFactory urlFactory;

  CoffeeClient({
    this.http = const CoffeeHttp(),
    CoffeeURLFactory? urlFactory,
  }) : urlFactory = urlFactory ?? const CoffeeURLFactory();

  Future<Coffee> getRandomCoffee() async {
    final response =
        await http.get(urlFactory.getUrl(endpoint: CoffeeEndpoint.random));

    if (response.statusCode != 200) {
      throw HttpException(code: response.statusCode, body: response.body);
    }

    return Coffee.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Uint8List> getImageDataFromCoffee(String coffeeUrl) async {
    final response = await http.get(coffeeUrl);
    return response.bodyBytes;
  }
}
