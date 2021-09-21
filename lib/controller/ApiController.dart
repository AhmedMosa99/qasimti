import 'dart:async';

import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/models/StoreModel.dart';
import 'package:qasimati/models/category.dart';
import 'package:qasimati/models/country.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/models/slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController {
  List<StoreModel> allStores = [];
  List<Country> allcountries = [];
  List<SliderModel> allsliders = [];
  List<CategoryModel> allCategories = [];
  List<CouponModel> allCoupons = [];
  List<CouponModel> allCouponStore = [];
  List<StoreModel> allstoreSearch = [];
  String selectCountry;
  String selectCategoryName;
  String selectedStore;
  int selectCategory;
  String dropdownValue;

  @override
  void onInit() {
    getCountry();
    Timer.periodic(Duration(seconds: 2), (x) {
      getStores();

      update();
      getCategories();
      getAllCountries();
      getSliders();
    });
    super.onInit();
  }

  saveCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("Country", selectCountry);

    print(dropdownValue);

    update();
  }

  getCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dropdownValue = pref.get("Country");

    update();
  }

  getAllCountries() async {
    try {
      List<dynamic> countries =
          await ApiHelper.apiHelper.getAllCountry(Get.locale.toString());
      if (countries != null) {
        allcountries = countries.map((e) => Country.fromJson(e)).toList();
      }
      update();
    } on Exception catch (e) {
      print(e);
    }
  }

  getSliders() async {
    try {
      if (dropdownValue == null) {
        List<dynamic> sliders = await ApiHelper.apiHelper.getSliders('all');
        if (sliders != null) {
          allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();
          update();
        } else {
          Get.snackbar("Eroor", "No EnterNet");
        }
      } else if (dropdownValue != null) {
        List<dynamic> sliders =
            await ApiHelper.apiHelper.getSliders(selectCountry);
        if (sliders != null) {
          allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();
          update();
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getStores() async {
    try {
      if (dropdownValue == null) {
        List<dynamic> stores =
            await ApiHelper.apiHelper.getStores('all', Get.locale.toString());
        if (stores != null) {
          allStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      } else {
        List<dynamic> stores = await ApiHelper.apiHelper
            .getStores(dropdownValue, Get.locale.toString());
        if (stores != null) {
          allStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      }
    } on Exception catch (e) {
      Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
      print(e);
    }
  }

  getCategories() async {
    try {
      List<dynamic> categories =
          await ApiHelper.apiHelper.getCategory(Get.locale.toString());
      if (categories != null) {
        allCategories =
            categories.map((e) => CategoryModel.fromJson(e)).toList();

        update();
      }
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
        if (coupons != null) {
          allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
          update();
        } else {
          Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
        }

        update();
      } else {
        List<dynamic> coupons = await ApiHelper.apiHelper.getCouponsByCategory(
            category, dropdownValue, Get.locale.toString());
        if (coupons != null) {
          allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
          update();
        } else {
          Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  getAllCouponInStore() async {
    allCouponStore = [];
    try {
      if (selectedStore == null) {
        print('notselected');
        update();
      } else {
        if (dropdownValue == null) {
          List<dynamic> couponsStore = await ApiHelper.apiHelper
              .getAllCouponInStore(selectedStore, "all", Get.locale.toString());
          if (couponsStore.isNotEmpty) {
            allCouponStore =
                couponsStore.map((e) => CouponModel.fromJson(e)).toList();

            update();
          } else {
            print("error");
          }
        } else {
          List<dynamic> couponsStore = await ApiHelper.apiHelper
              .getAllCouponInStore(
                  selectedStore, dropdownValue, Get.locale.toString());
          if (couponsStore != null) {
            allCouponStore =
                couponsStore.map((e) => CouponModel.fromJson(e)).toList();

            update();
          } else {
            print("error");
          }
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  voteCoupon(String type, int id) async {
    try {
      dynamic response = await ApiHelper.apiHelper.vaildCoupon(type, id);
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  searchStore(String query) async {
    allstoreSearch = [];
    try {
      if (dropdownValue == null) {
        List<dynamic> storeSearch = await ApiHelper.apiHelper
            .search('all', Get.locale.toString(), query);

        if (storeSearch != null) {
          allstoreSearch =
              storeSearch.map((e) => StoreModel.fromJson(e)).toList();

          update();
        } else {
          print('error');
        }
      } else {
        List<dynamic> storeSearch = await ApiHelper.apiHelper
            .search(dropdownValue, Get.locale.toString(), query);

        if (storeSearch != null) {
          allstoreSearch =
              storeSearch.map((e) => StoreModel.fromJson(e)).toList();

          update();
        } else {
          print('error');
        }
      }
    } on Exception catch (e) {
      Get.snackbar("خطأ", "لايوجد اتصال بالانترنت");
      print(e);
    }
  }
}
