library coffee_repositories;

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';

class CoffeeRepository {
  final CoffeeClient coffeeClient;
  final LocalCoffeeClient localCoffeeClient;

  CoffeeRepository({
    required this.coffeeClient,
    required this.localCoffeeClient,
  });

  /// Loads a Random Coffee from the web
  Future<Coffee> loadRandomCoffee() async {
    final coffee = await coffeeClient.loadRandomCoffee();
    return coffee;
  }

  /// Loads user favorite Coffee locally
  Future<List<Coffee>> loadFavoriteCoffees() async {
    return await localCoffeeClient.loadFavoriteCoffees();
  }

  /// Converts a Coffee Image url to File and saves the path locally
  Future<void> addCoffeeToFavorites(Coffee coffee) async {
    final data = await coffeeClient.getImageDataFromCoffee(coffee.image.raw);
    return await localCoffeeClient.addCoffeeToFavorites(coffee, data);
  }
}
