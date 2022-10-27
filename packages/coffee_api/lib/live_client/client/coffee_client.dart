import 'dart:convert';

import 'package:coffee_api/live_client/tools/coffee_url_factory.dart';
import 'package:coffee_models/coffee/coffee.dart';
import 'package:flutter/widgets.dart';

import 'coffee_api_errors.dart';
import '../tools/http_wrapper.dart';

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
}
