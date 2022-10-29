import 'dart:typed_data';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter/widgets.dart';

//TODO guardar el path al convertir la URL en file
class LocalCoffeeClient {
  @protected
  final CoffeeSharedPrefs sharedPrefs;

  LocalCoffeeClient({
    CoffeeSharedPrefs? sharedPrefs,
  }) : sharedPrefs = sharedPrefs ?? const CoffeeSharedPrefs();

  Future<List<Coffee>> getFavoriteCoffees() async {
    final coffeeImageList = await sharedPrefs.recoverFavoriteCoffeeImages();

    return coffeeImageList
        .map((coffeePath) => Coffee.fromLocal(coffeePath))
        .toList();
  }

  Future<List<Coffee>> saveFavoriteCoffee(Coffee coffee, Uint8List data) async {
    final coffeeUrl = coffee.image.raw;

    final imageFile = await FileManager.write(
      data,
      fileName: coffeeUrl.getFileName(),
    );

    if (imageFile != null) {
      await sharedPrefs.storeFavoriteCoffeeImage(imageFile.path);
    }

    return await getFavoriteCoffees();
  }

  Future<bool> removeFavoriteCoffee(Coffee coffee) async {
    final coffeeUrl = coffee.image.raw;

    return await sharedPrefs.deleteFavoriteCoffeeImage(coffeeUrl);
  }
}

//TODO: make url constant to share with http wrapper
extension _UrlFileName on String {
  getFileName() =>
      replaceFirst(RegExp(r'https://coffee.alexflipnote.dev/'), '');
}
