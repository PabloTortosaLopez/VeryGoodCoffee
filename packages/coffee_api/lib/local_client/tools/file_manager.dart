import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../../coffee_api.dart';

class FileManager {
  FileManager._();

  static Future<File?> write(
    Uint8List data, {
    required String fileName,
  }) async {
    final localPath = (await getApplicationDocumentsDirectory()).path;
    final localFile = File('$localPath/$fileName');

    final alreadyAddedd = await localFile.exists();

    if (alreadyAddedd) {
      throw AlreadyAddedException();
    } else {
      return await localFile.writeAsBytes(data);
    }
  }

  /// Check if the paths exist to avoid loading a non-existent file later on.
  ///
  static Future<List<String>> validatePaths({
    required List<String> pathList,
  }) async {
    List<String> validatedPaths = [];

    for (var path in pathList) {
      final exists = await File(path).exists();

      if (exists) {
        validatedPaths.add(path);
      }
    }

    return validatedPaths;
  }
}
