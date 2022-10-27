library coffee_repositories;

import 'package:coffee_api/coffee_api.dart';

class CoffeeRepository {
  final CoffeeClient coffeeClient;
  final LocalCoffeeClient localCoffeeClient;

  CoffeeRepository({
    required this.coffeeClient,
    required this.localCoffeeClient,
  });

  //TODO: define all the calls
}
