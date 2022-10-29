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

  Future<Coffee> loadRandomCoffee() async {
    final coffee = await coffeeClient.getRandomCoffee();
    return coffee;
  }

  Future<List<Coffee>> loadFavoriteCoffees() async {
    return await localCoffeeClient.getFavoriteCoffees();
  }

  Future<List<Coffee>> addCoffeeToFavorites(Coffee coffee) async {
    final data = await coffeeClient.getImageDataFromCoffee(coffee.image.raw);
    return await localCoffeeClient.saveFavoriteCoffee(coffee, data);
  }
}
