import 'dart:convert';

import 'package:coffee_api/live_client/tools/coffee_url_factory.dart';
import 'package:flutter/widgets.dart';

import '../tools/http_wrapper.dart';

class CoffeeClient {
  @protected
  final HttpWrapper http;

  @protected
  final CoffeeURLFactory urlFactory;

  //_TODO add shared prefs
  CoffeeClient({
    this.http = const CoffeeHttp(),
    CoffeeURLFactory? urlFactory,
  }) : urlFactory = urlFactory ?? const CoffeeURLFactory();

  Future<Map<String, dynamic>> recoverLikedCoffess() async {
    final response =
        await http.get(urlFactory.getUrl(endpoint: CoffeeEndpoint.random));

    if (response.statusCode != 200) {
      //_TODO:
      throw Exception();
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
