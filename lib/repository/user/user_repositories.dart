import 'package:ints/base/networking/api.dart';

import '../../base/networking/constants/endpoints.dart';
import '../../x_utils/api_error_util.dart';

class UserRepositories {
  late ApiService _service;

  UserRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<void> updateUser({required String fullName, required List<String> paths}) async {
    try {
      await _service.patch(Endpoints.users, data: {
        "fullName": fullName,
        "image": paths
      });
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw HttpErrorUtil.handleError(e);
    }
  }

  Future<void> deleteUser() async {
    try {
      await _service.delete(Endpoints.authMe);
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw HttpErrorUtil.handleError(e);
    }
  }
}
