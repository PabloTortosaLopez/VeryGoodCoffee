import 'package:coffee_api/local_client/tools/shared_prefs.dart';
import 'package:coffee_models/coffee_models.dart';

import 'package:flutter/widgets.dart';

class LocalCoffeeClient {
  @protected
  final CoffeeSharedPrefs sharedPrefs;

  LocalCoffeeClient({
    CoffeeSharedPrefs? sharedPrefs,
  }) : sharedPrefs = sharedPrefs ?? const CoffeeSharedPrefs();

  Future<List<Coffee>> getFavoriteCoffees() async {
    final coffeeImageList = await sharedPrefs.recoverFavoriteCoffeeImages();

    return coffeeImageList
        .map((coffeeUrl) => Coffee.fromLocal(coffeeUrl))
        .toList();
  }

  Future<List<Coffee>> saveFavoriteCoffee(Coffee coffee) async {
    final coffeeUrl = coffee.imageUrl;
    await sharedPrefs.storeFavoriteCoffeeImage(coffeeUrl);
    return await getFavoriteCoffees();
  }

  Future<bool> removeFavoriteCoffee(Coffee coffee) async {
    final coffeeUrl = coffee.imageUrl;

    return await sharedPrefs.deleteFavoriteCoffeeImage(coffeeUrl);
  }
}
