class Endpoints {
  Endpoints._();

  // authen
  static const String login_email = "/auth/email/login";
  static const String login_phone = "/auth/phone-number/login";
  static const String logout = "/auth/logout";
  static const String register = "/auth/email/register";
  static const String refreshToken = "/auth/refreshToken";
  static const String forgotPassword = "/auth/forgot/password";
  static const String resetPassword = "/auth/reset/password";
  static const String categories = "/categories";
  static const String products = "/products";
  static const String feedback = "/feedbacks";
  static const String feedback_multi = "/feedbacks/create-multiple";

  static const String carts = "/carts";
  static const String users = "/users";
  static const String authMe = "/auth/me";
  static const String stores = "/stores";
  static const String favoriteStores = "/stores/list/favorites";
  static const String addfavoriteStore = "/stores/favorite";
  static const String removefavoriteStore = "/stores/favorite/unlike";
  static String checkIsfavoriteStore(num storeId) =>
      "/stores/favorite/$storeId";
  static const String addresses = "/addresses";

  static String setDefaultAddress(num addressId) =>
      "/addresses/default-address/$addressId";

  static String removeAddress(num addressId) => "/addresses/$addressId";

  static String editAddress(num addressId) => "/addresses/$addressId";
  static const String address_city = "/addresses/cities";
  static const String address_district = "/addresses/districts/";
  static const String address_wards = "/addresses/wards/";
  static const String changePassword = "/auth/me/change-password";
  static const String address = "/addresses";
  static const String address_default = "/addresses/default-address";
  static const String change_password = "/auth/me/change-password";
  static const String orders = "/orders";
  static const String orders_cancel = "/orders/cancel";
  static const String cart_items = "/carts/cart-items";
  static const String cart_item = "/carts/cart-item";
  static const String otp = "/auth/otp";
  static const String feedback_user = "/feedbacks/user";
  static const String no_feedback_user = "/feedbacks/user/no-feedback";

  static const String add_favorite_store="/stores/favorite";
  static const String list_favorite="/stores/list/favorites";
  static const String files_upload="/files/upload";

}
