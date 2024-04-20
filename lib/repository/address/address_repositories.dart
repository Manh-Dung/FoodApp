import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/networking/api.dart';
import 'package:ints/base/networking/api_response.dart';
import 'package:ints/base/networking/constants/endpoints.dart';
import 'package:ints/models/address/address.dart';
import 'package:ints/models/address/address_district.dart';

import '../../models/address/address_city.dart';
import '../../x_utils/api_error_util.dart';

class AddressRepositories {
  late ApiService _service;

  AddressRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<List<AddressCity>> getAddress() async {
    try {
      var res = await _service.get(Endpoints.address_city);
      var list =
          APIResponse.fromLJsonListT(res, (json) => AddressCity.fromJson(json));
      return list;
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future<List<AddressDistrict>> getAddressDistrict(String codeCity) async {
    try {
      var res = await _service.get(Endpoints.address_district + codeCity);
      var list = APIResponse.fromLJsonListT(
          res, (json) => AddressDistrict.fromJson(json));
      return list;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<AddressDistrict>> getAddressWards(String codeCity) async {
    try {
      var res = await _service.get(Endpoints.address_wards + codeCity);
      var list = APIResponse.fromLJsonListT(
          res, (json) => AddressDistrict.fromJson(json));
      return list;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Address> postAddress(
    String fullName,
    String phoneNumber,
    String province,
    String district,
    String ward,
    String addressDetail,
    num coordinateslat,
    num coordinateslong,
    num type,
  ) async {
    try {
      var res = await _service.post(Endpoints.addresses, data: {
        "full_name": fullName,
        "phone_number": phoneNumber,
        "province": province,
        "district": district,
        "ward": ward,
        "address_detail": addressDetail,
        "coordinates_lat": coordinateslat,
        "coordinates_long": coordinateslong,
        "type": type,
      });
      return Address.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<APIResponsePaging<List<Address>>> getAllAddresses({
    num? limit,
    num? page,
    num? sortBy,
    num? orderBy,
    String? search,
  }) async {
    try {
      var res = await _service.get(Endpoints.addresses, queryParameters: {
        "limit": limit,
        "page": page,
        "sort_by": sortBy,
        "order_by": orderBy,
        "search": search,
      });
      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Address.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Address> getDefaultAddress() async {
    try {
      var res = await _service.get(Endpoints.address_default);
      return Address.fromJson(res);
    } catch (e) {
      return Address();
    }
  }

  Future<void> setDefaultAddress({required id}) async {
    try {
      await _service.patch(Endpoints.setDefaultAddress(id), data: {"id": id});
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw HttpErrorUtil.handleError(e);
    }
  }

  Future<Address> editAddress({
    required num id,
    required String fullName,
    required String phoneNumber,
    required String province,
    required String district,
    required String ward,
    required String detailAddress,
    required num coordinateslat,
    required num coordinateslong,
    required num type,
  }) async {
    try {
      var res = await _service.put(
        Endpoints.editAddress(id),
        data: {
          "full_name": fullName,
          "phone_number": phoneNumber,
          "province": province,
          "district": district,
          "ward": ward,
          "address_detail": detailAddress,
          "coordinates_lat": coordinateslat,
          "coordinates_long": coordinateslong,
          "type": type
        },
      );
      return Address.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> removeAddress({required id}) async {
    try {
      await _service.delete(Endpoints.removeAddress(id), data: {"id": id});
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw HttpErrorUtil.handleError(e);
    }
  }
}
