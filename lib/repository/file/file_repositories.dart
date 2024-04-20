import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ints/base/networking/api.dart';

import '../../base/networking/constants/endpoints.dart';
import '../../models/file/files.dart';

class FileRepositories {
  late ApiService _service;

  FileRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<List<Files>> postFiles({required List<File?> files}) async {
    try {
      FormData formData = FormData();

      for (int i = 0; i < files.length; i++) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          files[i]!.path,
          filename: files[i]!.path.split('/').last,
        );
        formData.files.add(MapEntry('files', multipartFile));
      }

      var res = await _service.post(Endpoints.files_upload, data: formData);

      return res.map((json) => Files.fromJson(json)).toList().cast<Files>();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
