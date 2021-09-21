import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Dio dio = Dio();

  static String baseUrl = 'https://qasimati.com/api';

  getAllCountry(String lang) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$lang/countries',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print("not enternet");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getSliders(String country) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$country/countries/sliders',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['sliders'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getStores(String country, String lang) async {
    try {
      if (country == null) {
        print('error');
      } else {
        Response response = await dio.get('$baseUrl/stores/$country-$lang',
            options: Options(
              headers: {'device': "w"},
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              },
            ));
        if (response.statusCode == 200) {
          return response.data['data'];
        } else {
          return [];
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getAllCouponInStore(String store, String country, String lang) async {
    try {
      Response response = await dio.get(
        '$baseUrl/stores/$store/coupons/$country-$lang',
        options: Options(
          headers: {'device': "w", 'Connection': "keep-alive"},
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['coupons'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCategory(String lang) async {
    try {
      Response response = await dio.get(
        '$baseUrl/$lang/categories',
        options: Options(
          headers: {'Accept': 'application/json', 'Connection': "keep-alive"},
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCouponsByCategory(String category, String country, String lang) async {
    try {
      Response response =
          await dio.get('$baseUrl/categories/$category/coupons/$country-$lang',
              options: Options(
                headers: {
                  'device': "w",
                  'Accept': 'application/json',
                  'Connection': "keep-alive"
                },
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                },
              ));
      if (response.statusCode == 200) {
        return response.data['coupons'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getAllCoupon(String country, String lang) async {
    try {
      Response response = await dio.get("$baseUrl/coupons/$country-$lang",
          options: Options(
            headers: {
              'device': "w",
              'Accept': 'application/json',
              'Connection': "keep-alive"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  register(String name, File url, String password, String email) async {
    String path = url.path.split('/').last;

    try {
      var formData = FormData.fromMap({
        'name': 'name',
        'password': password,
        'url': MultipartFile.fromFileSync(url.path, filename: path),
        'email': email,
      });

      Response response = await dio.post('$baseUrl/register',
          data: formData,
          options: Options(
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              'Connection': "keep-alive",
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
            },
          ));
      return response;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        print('ahmed');
      }
    }
  }

  login(String password, String email) async {
    try {
      var data = {
        'password': password,
        'email': email,
      };
      Response response = await dio.post('$baseUrl/login',
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              'Content-Type': 'multipart/form',
              'Accept': 'application/json',
            },
          ));

      return response;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        return "";
      }
    }
  }

  addCoupon(
      {String nameStore,
      String linkstore,
      File urlStore,
      String countries,
      String code,
      String link,
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
        'link': link,
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
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on Exception catch (e) {
      print(e);
      return "";
    }
  }

  vaildCoupon(String type, int id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.get('token');
      var data = {
        'coupon_id': id,
        'type_vote': type,
      };
      Response response = await dio.post('$baseUrl/coupons/vote',
          data: data,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              'Connection': "keep-alive",
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

  search(String country, String lang, String store) async {
    try {
      Response response =
          await dio.get('$baseUrl/stores/$country-$lang?se=$store',
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                },
                headers: {'device': "w", 'Connection': "keep-alive"},
              ));
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserByToken(String token) async {
    try {
      Response response = await dio.get(
        '$baseUrl/user',
        options: Options(headers: {
          'Connection': "keep-alive",
          'Content-Type': 'multipart/form',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        }),
      );
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }
}
