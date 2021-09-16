import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/models/StoreModel.dart';
import 'package:qasimati/models/category.dart';
import 'package:qasimati/models/country.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/models/slider.dart';

class ApiController extends GetxController {
  List<StoreModel> allStores = [];
  List<Country> allcountries = [];
  List<SliderModel> allsliders = [];
  List<CategoryModel> allCategories = [];
  List<CouponModel> allCoupons = [];
  List<CouponModel> allCouponStore = [];
  String selectCountry;
  String selectCategoryName;
  String selectedStore;
  int selectCategory;
  String dropdownValue;
  @override
  void onInit() {
    if (this.selectCountry == null) {
      selectCountry = "all";
      update();
    }
    getStores();
    getAllCouponInStore();
    update();
    getCategories();
    getAllCountries();
    getSliders();
    super.onInit();
  }

  // changeCountry() async {
  //   LocalStorage localStorage = LocalStorage();
  //   await localStorage.saveCountry(selectCountry);

  //   selectCountry = await localStorage.countrySelected == null
  //       ? 'all'
  //       : await localStorage.countrySelected;
  //   localStorage.countrySelected.then((value) => print(value));
  //   update();
  // }

  getAllCountries() async {
    try {
      List<dynamic> countries =
          await ApiHelper.apiHelper.getAllCountry(Get.locale.toString());
      allcountries = countries.map((e) => Country.fromJson(e)).toList();
      update();
    } on Exception catch (e) {
      print(e);
    }
  }

  getSliders() async {
    // allsliders = null;
    // update();
    try {
      if (selectCountry == null) {
        List<dynamic> sliders = await ApiHelper.apiHelper.getSliders('all');
        allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();
        update();
      } else if (selectCountry != null) {
        List<dynamic> sliders =
            await ApiHelper.apiHelper.getSliders(selectCountry);
        allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();

        update();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getStores() async {
    try {
      List<dynamic> stores = await ApiHelper.apiHelper
          .getStores(selectCountry, Get.locale.toString());
      allStores = stores.map((e) => StoreModel.fromJson(e)).toList();
      update();
    } on Exception catch (e) {
      Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
      print(e);
    }
  }

  getCategories() async {
    try {
      List<dynamic> categories =
          await ApiHelper.apiHelper.getCategory(Get.locale.toString());
      allCategories = categories.map((e) => CategoryModel.fromJson(e)).toList();

      update();
    } on Exception catch (e) {
      print(e);
    }
    return allCategories;
  }

  getCouponsByCategory(String category) async {
    try {
      if (selectCategoryName == null) {
        List<dynamic> coupons = await ApiHelper.apiHelper
            .getAllCoupon('all', Get.locale.toString());
        allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
        update();
      } else {
        try {
          List<dynamic> coupons = await ApiHelper.apiHelper
              .getCouponsByCategory(
                  category, selectCountry, Get.locale.toString());
          allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
          update();
        } on Exception catch (e) {
          Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
          print(e);
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  getAllCouponInStore() async {
    try {
      if (selectedStore == null) {
        print("selectCategory");
        update();
      } else if (selectedStore != null) {
        List<dynamic> couponsStore = await ApiHelper.apiHelper
            .getAllCouponInStore(
                selectedStore, selectCountry, Get.locale.toString());
        allCouponStore =
            couponsStore.map((e) => CouponModel.fromJson(e)).toList();
        print(allCouponStore);
        update();
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
