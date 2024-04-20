import 'package:get/get.dart';
import 'package:ints/views/chat_page/chat_page_binding.dart';
import 'package:ints/views/chat_page/chat_page_noti.dart';
import 'package:ints/views/chat_page/chat_page_screen.dart';
import 'package:ints/views/checkout/checkout_binding.dart';
import 'package:ints/views/checkout/checkout_screen.dart';
import 'package:ints/views/expanded_list_view/expanded_list_view_screen.dart';
import 'package:ints/views/favorite_store/favorite_store_binding.dart';
import 'package:ints/views/feedback_product/feedback_product_binding.dart';
import 'package:ints/views/feedback_product/feedback_product_screen.dart';
import 'package:ints/views/flash_sale/flash_sale_binding.dart';
import 'package:ints/views/flash_sale/flash_sale_screen.dart';
import 'package:ints/views/forgot_password/forgot_password_binding.dart';
import 'package:ints/views/forgot_password/forgot_password_screen.dart';
import 'package:ints/views/home/home_binding.dart';
import 'package:ints/views/home/pages/cart_page.dart';
import 'package:ints/views/information/information_screen.dart';
import 'package:ints/views/language/language_binding.dart';
import 'package:ints/views/login/login_screen.dart';
import 'package:ints/views/map/map_binding.dart';
import 'package:ints/views/map/map_screen.dart';
import 'package:ints/views/nearby_product/nearby_product_binding.dart';
import 'package:ints/views/nearby_product/nearby_product_screen.dart';
import 'package:ints/views/order/order_binding.dart';
import 'package:ints/views/order/order_screen.dart';
import 'package:ints/views/address_selection/address_selection_binding.dart';
import 'package:ints/views/order_detail/order_detail_screen.dart';
import 'package:ints/views/order_successfully/order_successfully_binding.dart';
import 'package:ints/views/order_successfully/order_successfully_screen.dart';
import 'package:ints/views/portfolio/portfolio_binding.dart';
import 'package:ints/views/portfolio/portfolio_screen.dart';
import 'package:ints/views/register/register_binding.dart';
import 'package:ints/views/register/register_screen.dart';
import 'package:ints/views/search_order/search_order_binding.dart';
import 'package:ints/views/search_order/search_order_screen.dart';
import 'package:ints/views/store_detail/store_detail_binding.dart';
import 'package:ints/views/store_detail/store_detail_screen.dart';
import 'package:ints/views/test/test_binding.dart';
import 'package:ints/views/update_full_name/update_full_name_binding.dart';
import 'package:ints/views/update_profile/update_profile_binding.dart';
import 'package:ints/views/update_profile/update_profile_screen.dart';
import 'package:ints/views/wait_for_delivery/wait_for_delivery_binding.dart';

import '../views/about_us/about_us_binding.dart';
import '../views/about_us/about_us_screen.dart';
import '../views/account_setting/account_setting_binding.dart';
import '../views/account_setting/account_setting_screen.dart';
import '../views/address_selection/address_selection_screen.dart';
import '../views/category_detail/category_detail_binding.dart';
import '../views/category_detail/category_detail_screen.dart';
import '../views/create_address/create_address_binding.dart';
import '../views/create_address/create_address_screen.dart';
import '../views/expanded_list_view/expanded_list_view_binding.dart';
import '../views/favorite_store/favorite_store_screen.dart';
import '../views/feedback/feedback_binding.dart';
import '../views/feedback/feedback_screen.dart';
import '../views/home/home_screen.dart';
import '../views/language/language_screen.dart';
import '../views/list_feedback/list_feedback_binding.dart';
import '../views/list_feedback/list_feedback_screen.dart';
import '../views/login/choose_login_signup/choose_login_signup_screem.dart';
import '../views/login/creat_new_password/change_password_succes.dart';
import '../views/login/creat_new_password/creat_new_password.dart';
import '../views/login/login_binding.dart';
import '../views/login/otp/otp_screen.dart';
import '../views/notification/notification_binding.dart';
import '../views/notification/notification_screen.dart';
import '../views/order_detail/order_detail_binding.dart';
import '../views/pickup_address/pickup_address_binding.dart';
import '../views/pickup_address/pickup_address_screen.dart';
import '../views/product_detail/product_detail_binding.dart';
import '../views/product_detail/product_detail_screen.dart';
import '../views/search_product/search_product_binding.dart';
import '../views/search_product/search_product_screen.dart';
import '../views/test/test_screen.dart';
import '../views/update_full_name/update_full_name_screen.dart';
import '../views/wait_for_delivery/wait_for_delivery_screen.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
          name: RouterName.home,
          page: () => HomeScreen(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.test,
          page: () => TestScreen(),
          binding: TestBinding()),
      GetPage(
          name: RouterName.portfolio,
          page: () => PortfolioScreen(),
          binding: PortfolioBinding()),
      GetPage(
          name: RouterName.login,
          page: () => LoginScreen(),
          binding: LoginBinding()),
      GetPage(
          name: RouterName.register,
          page: () => RegisterScreen(),
          binding: RegisterBinding()),
      GetPage(
          name: RouterName.forgot_password,
          page: () => ForgotPasswordScreen(),
          binding: ForgotPasswordBinding()),
      GetPage(
          name: RouterName.category_detail,
          page: () => CategoryDetailScreen(),
          binding: CategoryDetailBinding()),
      GetPage(
          name: RouterName.store_detail,
          page: () => StoreDetailScreen(),
          binding: StoreDetailBinding()),
      GetPage(
          name: RouterName.product_detail,
          page: () => ProductDetailScreen(),
          binding: ProductDetailBinding()),
      GetPage(
          name: RouterName.search_product,
          page: () => SearchProductScreen(),
          binding: SearchProductBinding()),
      GetPage(
          name: RouterName.expanded_list_view,
          page: () => ExpandedListViewScreen(),
          binding: ExpandedListViewBinding()),
      GetPage(
          name: RouterName.cart,
          page: () => CartPage(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.checkout,
          page: () => CheckoutScreen(),
          binding: CheckoutBinding()),
      GetPage(
          name: RouterName.update_profile,
          page: () => UpdateProfileScreen(),
          binding: UpdateProfileBinding()),
      GetPage(
          name: RouterName.select_address,
          page: () => AddressSelectionScreen(),
          binding: AddressSelectionBinding()),
      GetPage(
          name: RouterName.create_address,
          page: () => CreateAddressScreen(),
          binding: CreateAddressBinding()),
      GetPage(
          name: RouterName.account_setting,
          page: () => AccountSettingScreen(),
          binding: AccountSettingBinding()),
      GetPage(
          name: RouterName.notification,
          page: () => NotificationScreen(),
          binding: NotificationBinding()),
      GetPage(
          name: RouterName.order,
          page: () => OrderScreen(),
          binding: OrderBinding()),
      GetPage(
          name: RouterName.search_order,
          page: () => SearchOrderScreen(),
          binding: SearchOrderBinding()),
      GetPage(
          name: RouterName.favorite_store,
          page: () => FavoriteStoreScreen(),
          binding: FavoriteStoreBinding()),
      GetPage(
          name: RouterName.pickup_address,
          page: () => PickUpAddressScreen(),
          binding: PickUpAddressBinding()),
      GetPage(
          name: RouterName.about_us,
          page: () => AboutUsScreen(),
          binding: AboutUsBinding()),
      GetPage(
          name: RouterName.information,
          page: () => InformationScreen(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.language,
          page: () => LanguageScreen(),
          binding: LanguageBinding()),
      GetPage(
          name: RouterName.choose_login_signup,
          page: () => LoginOrSignUpScreen(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.opt_screen,
          page: () => OtpScreen(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.create_new_password,
          page: () => CreateNewPassword(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.change_password_success,
          page: () => ChangePasswordSuccess(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.chat_page,
          page: () => ChatPage(),
          binding: ChatPageBinding()),
      GetPage(
          name: RouterName.chat_page_noti,
          page: () => ChatPageNotification(),
          binding: ChatPageBinding()),
      GetPage(
          name: RouterName.wait_for_delivery,
          page: () => WaitForDeliveryScreen(),
          binding: WaitForDeliveryBinding()),
      GetPage(
          name: RouterName.list_feedback,
          page: () => ListFeedbackScreen(),
          binding: ListFeedbackBinding()),
      GetPage(
          name: RouterName.feedback_product,
          page: () => FeedBackProductScreen(),
          binding: FeedBackProductBinding()),
      GetPage(
          name: RouterName.feedback,
          page: () => FeedbackScreen(),
          binding: FeedbackBinding()),
      GetPage(
          name: RouterName.successful_order,
          page: () => OrderSuccessfullyScreen(),
          binding: OrderSuccessfullyBinding()),
      GetPage(
          name: RouterName.map, page: () => MapScreen(), binding: MapBinding()),
      GetPage(
          name: RouterName.order_detail,
          page: () => OrderDetailScreen(),
          binding: OrderDetailBinding()),
      GetPage(
          name: RouterName.update_full_name,
          page: () => UpdateFullNameScreen(),
          binding: UpdateFullNameBinding()),
      GetPage(
          name: RouterName.nearby_product,
          page: () => NearByProductScreen(),
          binding: NearByProductBinding()),
      GetPage(
          name: RouterName.flash_sale,
          page: () => FlashSaleScreen(),
          binding: FlashSaleBinding()),
    ];
  }
}
