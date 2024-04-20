import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static String _localPath = '';

  static Future<String> get localPath async {
    if (_localPath == '') {
      Directory _localPathDic = (Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory())!;

      _localPath = _localPathDic.path;
    }

    return _localPath;
  }

  static Future<File> localFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }
}
