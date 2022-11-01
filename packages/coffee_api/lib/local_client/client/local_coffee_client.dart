import 'dart:io';
import 'dart:typed_data';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';

/// A Client that interacts with FileManager and CoffeeSharedPrefs
/// to save and retrieve path images locally.
class LocalCoffeeClient {
  final CoffeeSharedPrefs sharedPrefs;

  /// To mock the static FileManager.write method response,
  /// these parameters will be used in testing to determine
  /// the response of that call on the _write wrapper.
  final bool useStubFileManager;
  final bool imageFileAlwaysNull;

  LocalCoffeeClient({
    CoffeeSharedPrefs? sharedPrefs,
    bool? useStubFileManager,
    bool? imageFileAlwaysNull,
  })  : sharedPrefs = sharedPrefs ?? const CoffeeSharedPrefs(),
        useStubFileManager = useStubFileManager ?? false,
        imageFileAlwaysNull = imageFileAlwaysNull ?? false;

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

    final imageFile = await _write(
      data,
      fileName: coffeeUrl.getFileName(),
    );

    if (imageFile != null) {
      await sharedPrefs.storeFavoriteCoffeeImage(imageFile.path);
    } else {
      throw Exception('The image has not been saved correctly');
    }
  }

  /// Wrapper to mock FileManager.write during test
  Future<File?> _write(Uint8List data, {required String fileName}) async {
    if (useStubFileManager) {
      return Future.value(imageFileAlwaysNull ? null : File(testPath));
    }
    return await FileManager.write(
      data,
      fileName: fileName,
    );
  }
}

extension _UrlFileName on String {
  getFileName() =>
      replaceFirst(RegExp(r'https://coffee.alexflipnote.dev/'), '');
}

const testPath = 'test/path.jpg';
