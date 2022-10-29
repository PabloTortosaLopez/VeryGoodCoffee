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

    final alreadyExists = await localFile.exists();

    if (alreadyExists) {
      throw AlreadyAddedException();
    } else {
      return await localFile.writeAsBytes(data);
    }
  }
}
