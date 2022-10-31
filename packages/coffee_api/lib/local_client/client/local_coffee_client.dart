import 'dart:typed_data';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:flutter/widgets.dart';

/// A Client that interacts with FileManager and CoffeeSharedPrefs
/// to save and retrieve path images locally.
class LocalCoffeeClient {
  @protected
  final CoffeeSharedPrefs sharedPrefs;

  LocalCoffeeClient({
    CoffeeSharedPrefs? sharedPrefs,
  }) : sharedPrefs = sharedPrefs ?? const CoffeeSharedPrefs();

  Future<List<Coffee>> loadFavoriteCoffees() async {
    final coffeePaths = await sharedPrefs.recoverFavoriteCoffeeImages();

    final coffeePathsValidated =
        await FileManager.validatePaths(pathList: coffeePaths);

    return coffeePathsValidated
        .map((coffeePath) => Coffee.fromLocal(coffeePath))
        .toList();
  }

  Future<void> addCoffeeToFavorites(Coffee coffee, Uint8List data) async {
    final coffeeUrl = coffee.image.raw;

    final imageFile = await FileManager.write(
      data,
      fileName: coffeeUrl.getFileName(),
    );

    if (imageFile != null) {
      await sharedPrefs.storeFavoriteCoffeeImage(imageFile.path);
    } else {
      throw Exception('The image has not been saved correctly');
    }
  }
}

extension _UrlFileName on String {
  getFileName() =>
      replaceFirst(RegExp(r'https://coffee.alexflipnote.dev/'), '');
}
