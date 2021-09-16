import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Dio dio = Dio();

  static String baseUrl = 'https://qasimati.com/api';

  getAllCountry(String lang) async {
    // try {
    //   Response response = await dio.get('$baseUrl/$lang/countries');
    //   return response.data['data'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getSliders(String country) async {
    // try {
    //   Response response = await dio.get('$baseUrl/$country/countries/sliders');
    //   return response.data['sliders'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getStores(String country, String lang) async {
    // try {
    //   if (country == null) {
    //     print('error');
    //   } else {
    //     Response response = await dio.get('$baseUrl/stores/$country-$lang',
    //         options: Options(headers: {'device': "w"}));

    //     return response.data['data'];
    //   }
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getAllCouponInStore(String store, String country, String lang) async {
    // try {
    //   Response response =
    //       await dio.get('$baseUrl/stores/$store/coupons/$country-$lang');
    //   return response.data['coupons'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getCategory(String lang) async {
    // try {
    //   Response response = await dio.get(
    //     '$baseUrl/$lang/categories',
    //   );
    //   return response.data['data'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getCouponsByCategory(String category, String country, String lang) async {
    // try {
    //   Response response =
    //       await dio.get('$baseUrl/categories/$category/coupons/$country-$lang',
    //           options: Options(
    //             headers: {'device': "w"},
    //           ));

    //   return response.data['coupons'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  getAllCoupon(String country, String lang) async {
    // try {
    //   Response response = await dio.get("$baseUrl/coupons/$country-$lang",
    //       options: Options(headers: {'device': "w"}));

    //   return response.data['data'];
    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  register(String name, File url, String password, String email) async {
    String path = url.path.split('/').last;

    // try {
    //   var formData = FormData.fromMap({
    //     'name': 'name',
    //     'password': password,
    //     'url': MultipartFile.fromFileSync(url.path, filename: path),
    //     'email': email,
    //   });

    //   Response response = await dio.post('$baseUrl/register',
    //       data: formData,
    //       options: Options(
    //         responseType: ResponseType.json,
    //         followRedirects: false,
    //         validateStatus: (status) {
    //           return status < 500;
    //         },
    //         headers: {
    //           'Content-Type': 'multipart/form',
    //           'Accept': 'application/json',
    //         },
    //       ));
    //   return response;
    // } on DioError catch (e) {
    //   if (e.response.statusCode == 422) {
    //     print('ahmed');
    //   }
    // }
  }

  login(String password, String email) async {
    // try {
    //   var data = {
    //     'password': password,
    //     'email': email,
    //   };
    //   Response response = await dio.post('$baseUrl/login',
    //       data: data,
    //       options: Options(
    //         followRedirects: false,
    //         validateStatus: (status) {
    //           return status < 500;
    //         },
    //         headers: {
    //           'Content-Type': 'multipart/form',
    //           'Accept': 'application/json',
    //         },
    //       ));

    //   return response;
    // } on DioError catch (e) {
    //   if (e.response.statusCode == 422) {
    //     print('ahmed');
    //   }
    // }
  }

  addCoupon(
      {String nameStore,
      String linkstore,
      File urlStore,
      String countries,
      String code,
      String descrption,
      String startDate,
      String endDate,
      int id,
      String type}) async {
    try {
      String path = urlStore.path.split('/').last;

      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.get('token');
      var formData = FormData.fromMap({
        'name_store': nameStore,
        'link_store': linkstore,
        'url_store': MultipartFile.fromFileSync(urlStore.path, filename: path),
        'countries': countries,
        'code': code,
        'type': type,
        'title_coupon': descrption,
        'start_date': startDate,
        'end_date': endDate,
        'user_id': id,
      });

      Response response = await dio.post('$baseUrl/coupons/create',
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            },
            headers: {
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
              'Authorization': "Bearer $token"
            },
          ));

      return response.data;
    } on Exception catch (e) {
      print(e);
    }
  }
}
