import 'dart:convert';
import 'dart:io';

import 'package:full_delta_sync/modules/constants/temp.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<String> get directoryPath async {
    var directory = await getApplicationDocumentsDirectory();
    if (directory != null) {
      print(directory.path);
      return directory.path;
    } else {
      throw Future.error(Exception("Directory Not Found!"));
    }
  }

  Future<File> get _jsonFile async {
    final path = await directoryPath;
    return File('$path/$kJsonFileName');
  }

  dynamic readJsonFile() async {
    String fileContent = '';

    File file = await _jsonFile;
    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
      return jsonDecode(fileContent);
    }
  }

  writeJsonFile(String skuListData) async {
    try {
      final file = await _jsonFile;
      // dynamic parseValue = jsonDecode(source)
      await file.writeAsString(skuListData);
      print('Write Complete!');
    } catch (e) {
      print(e);
    }
    return skuListData;
  }
}
