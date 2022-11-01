library coffee_api;

import 'package:shared_preferences/shared_preferences.dart';

class CoffeeSharedPrefs {
  const CoffeeSharedPrefs();

  /// Keys
  static const String _favoriteCoffeesKey = 'favoriteCoffees';

  /// Store Coffee path Image
  Future<void> storeFavoriteCoffeeImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      var newList = <String>[];
      newList.add(imagePath);
      await prefs.setStringList(_favoriteCoffeesKey, newList);
    } else {
      coffeeList.add(imagePath);
      await prefs.setStringList(_favoriteCoffeesKey, coffeeList);
    }
  }

  /// Recover Coffee path Images
  Future<List<String>> recoverFavoriteCoffeeImages() async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      return [];
    }

    return coffeeList;
  }

  /// Delete Coffee path Image - NOT USED YET
  Future<bool> deleteFavoriteCoffeeImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    final coffeeList = prefs.getStringList(_favoriteCoffeesKey);

    if (coffeeList == null || coffeeList.isEmpty) {
      assert(false,
          ' It should not be possible to delete a Coffee if there is no Coffees stored');
      return false;
    } else if (coffeeList.contains(imagePath)) {
      coffeeList.remove(imagePath);
      await prefs.setStringList(_favoriteCoffeesKey, coffeeList);
      return true;
    }

    return false;
  }
}
