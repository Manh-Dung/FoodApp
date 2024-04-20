import 'package:ints/base/base_controller.dart';
import 'package:ints/models/address/address.dart';

import '../../base/api_response_paging.dart';

class PickUpAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PickUpAddressController());
  }
}

class PickUpAddressController extends BaseController {
  Rx<bool> rxShimmerLoading = Rx(true);
  RxList<Address> rxListAddress = RxList();
  RxList<bool> isBeingEdited = RxList();

  RxInt rxPage = RxInt(1);
  RxInt rxLimit = RxInt(8);

  @override
  void onInit() {
    withScrollController = true;

    super.onInit();
    getAllAddresses(page: rxPage.value, limit: rxLimit.value).then((res) {
      rxListAddress.value = res.data ?? [];
      isBeingEdited = RxList.filled(rxListAddress.length, false);
    });
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    rxPage.value = 1;
    showLoadingDialog();
    await getAllAddresses(page: rxPage.value, limit: rxLimit.value).then((res) {
      rxListAddress.value = res.data ?? [];
      isBeingEdited = RxList.filled(rxListAddress.length, false);
    });
    hideDialog();
  }

  @override
  void onLoadMore() async {
    super.onLoadMore();
    rxPage.value++;
    showLoadingDialog();

    await getAllAddresses(page: rxPage.value, limit: rxLimit.value).then((res) {
      rxListAddress.addAll(res.data ?? []);
      isBeingEdited = RxList.filled(rxListAddress.length, false);
    });
    hideDialog();
  }

  Future<APIResponsePaging<List<Address>>> getAllAddresses(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await addressRepositories.getAllAddresses(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);
      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get addresses');
    }
  }

  void removeAddress(num addressId) async {
    showLoadingDialog();
    try {
      await addressRepositories.removeAddress(id: addressId);
      hideDialog();
      getAllAddresses(page: rxPage.value, limit: rxLimit.value).then((res) {
        rxListAddress.value = res.data ?? [];
        isBeingEdited = RxList.filled(rxListAddress.length, false);
      });

      handleSuccessStringShowToast(message: 'Xoá địa chỉ  thành công');
    } catch (e) {
      hideDialog();

      if (e == 'ERROR : Must not delete default address') {
        handleErrorStringShowToast(error: "Không thể xoá địa chỉ mặc định");
      } else {
        handleErr(e);
      }
    }
  }

  void updateEditStatus(int index) {
    isBeingEdited[index] = !isBeingEdited[index];
    print(isBeingEdited[index]);
  }
}
