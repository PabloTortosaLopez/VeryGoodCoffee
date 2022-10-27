library coffee_api;

import 'package:shared_preferences/shared_preferences.dart';

class CoffeeSharedPrefs {
  const CoffeeSharedPrefs();

  // MARK: - Keys

  static const String _favoriteCoffeesKey = 'favoriteCoffees';

  // MARK: - Store Coffee Image
  Future<void> storeFavoriteCoffeeImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      var newList = <String>[];
      newList.add(imageUrl);
      await prefs.setStringList(_favoriteCoffeesKey, newList);
    } else {
      coffeeList.add(imageUrl);
      await prefs.setStringList(_favoriteCoffeesKey, coffeeList);
    }
  }

  // MARK: - Recover Coffee Images
  Future<List<String>> recoverFavoriteCoffeeImages() async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      return [];
    }

    return coffeeList;
  }

  // MARK: - Delete Coffee Image
  Future<bool> deleteFavoriteCoffeeImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      // It should not be possible to delete a Coffee if there is no Coffees stored
      return false;
    } else if (coffeeList.contains(imageUrl)) {
      coffeeList.remove(imageUrl);
      await prefs.setStringList(_favoriteCoffeesKey, coffeeList);
      return true;
    }

    return false;
  }
}
