import 'package:ints/base/networking/api.dart';
import 'package:ints/repository/address/address_repositories.dart';
import 'package:ints/repository/auth/auth_repositories.dart';
import 'package:ints/repository/category/category_repositories.dart';
import 'package:ints/repository/feedback/feedback_product_repositories.dart';
import 'package:ints/repository/order/order_repositories.dart';
import 'package:ints/repository/post/post_repositories.dart';
import 'package:ints/repository/product/product_repositories.dart';
import 'package:ints/repository/store/store_repositories.dart';
import 'package:ints/repository/user/user_repositories.dart';

import 'cart/cart_repositories.dart';
import 'favorite/favorite_repositories.dart';
import 'feedback/feedback_repositories.dart';
import 'file/file_repositories.dart';

///
/// --------------------------------------------
/// In this class where the [Function]s correspond to the API.
/// Which function here you will make it and you will consume it.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class Repositories {
  late AuthRepositories authRepositories;
  late PostRepositories postRepositories;
  late CategoryRepositories categoryRepositories;
  late ProductRepositories productRepositories;
  late CartRepositories cartRepositories;
  late StoreRepositories storeRepositories;
  late AddressRepositories addressRepositories;
  late UserRepositories userRepositories;
  late OrderRepositories orderRepositories;
  late FeedbackProductRepositories feedbackProductRepositories;
  late FavoriteRepositories favoriteRepositories;
  late FeedbackRepositories feedbackRepositories;
  late FileRepositories fileRepositories;

  initBaseRepositories({required ApiService apiService}) {
    postRepositories = PostRepositories(apiService: apiService);
    authRepositories = AuthRepositories(apiService: apiService);
    categoryRepositories = CategoryRepositories(apiService: apiService);
    productRepositories = ProductRepositories(apiService: apiService);
    cartRepositories = CartRepositories(apiService: apiService);
    storeRepositories = StoreRepositories(apiService: apiService);
    addressRepositories = AddressRepositories(apiService: apiService);
    userRepositories = UserRepositories(apiService: apiService);
    orderRepositories = OrderRepositories(apiService: apiService);
    feedbackProductRepositories = FeedbackProductRepositories(apiService: apiService);
    favoriteRepositories = FavoriteRepositories(apiService: apiService);
    feedbackRepositories = FeedbackRepositories(apiService: apiService);
    fileRepositories = FileRepositories(apiService: apiService);
  }
}
