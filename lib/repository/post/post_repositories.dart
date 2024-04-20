import 'package:ints/base/networking/api.dart';
import 'package:ints/base/networking/result.dart';

class PostRepositories {
  late ApiService _service;

  PostRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<Result> getDataMember() async {
    try {
      // var res = await _service.get(Endpoints.xxx);
      var res = await _service.get("test-get");
      return Result.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
