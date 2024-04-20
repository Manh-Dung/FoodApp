import 'package:dio/dio.dart';
import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/networking/api.dart';
import 'package:ints/base/networking/api_response.dart';
import 'package:ints/models/product/attribute_price.dart';
import 'package:ints/models/product/product.dart';
import 'package:ints/models/product/product_option.dart';
import 'package:ints/models/product/product_option_attribute.dart';

import '../../base/networking/constants/endpoints.dart';

class ProductRepositories {
  late ApiService _service;

  ProductRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Options _options = Options(
    headers: {"requiresToken": false},
  );

  Future<APIResponsePaging<List<Product>>> getProducts(
      {num? limit,
      num? page,
      String? sortBy,
      String? orderBy,
      String? search,
      num? categoryId,
      num? storeId}) async {
    try {
      var res = await _service
          .get(Endpoints.products, options: _options, queryParameters: {
        "page": page,
        "limit": limit,
        "sort_by": sortBy,
        "order_by": orderBy,
        "search": search,
        "category_id": categoryId,
        "store_id": storeId,
      });
      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Product.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Product> getProductById({required num id}) async {
    try {
      var res = await _service.get(Endpoints.products + "/$id");
      return Product.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<ProductOption>> getProductOptionByProductId(
      {required num? productId}) async {
    try {
      var res =
          await _service.get(Endpoints.products + "/options/$productId", data: {
        "product_id": productId,
      });
      var productOptionList = APIResponse.fromLJsonListT(
          res, (json) => ProductOption.fromJson(json));
      return productOptionList;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<ProductOptionAttribute>> getProductOptionAttributeByOptionId(
      {required num optionId}) async {
    try {
      var res = await _service
          .get(Endpoints.products + "/option-attributes/$optionId", data: {
        "option_id": optionId,
      });

      var productOptionAttributeList = APIResponse.fromLJsonListT(
          res, (json) => ProductOptionAttribute.fromJson(json));
      return productOptionAttributeList;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<AttributePrice> getProductOptionAttributePrice(
      {required num optionAttributeId}) async {
    try {
      var res = await _service
          .get(Endpoints.products + "/price/$optionAttributeId", data: {
        "option_attributes_id": optionAttributeId,
      });

      return AttributePrice.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
