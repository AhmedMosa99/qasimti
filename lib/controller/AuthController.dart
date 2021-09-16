import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> singupFromKey = GlobalKey<FormState>();
  TextEditingController emailController, passwordCotroller, nameController;
  String name;
  String token;

  File imageFile;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordCotroller = TextEditingController();
    nameController = TextEditingController();
    loginKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print(imageFile);
  }

  String validateName(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Username is not vaild";
    }
    return null;
  }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Eamil is not vaild";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length <= 6) {
      return "password must be of 6";
    }
    return null;
  }

  checkLogin() async {
    try {
      if (loginKey.currentState.validate()) {
        loginKey.currentState.save();
        dynamic response = await ApiHelper.apiHelper
            .login(passwordCotroller.text, emailController.text);
        print(response.data);
        if (response.data['status'] == 401) {
          Get.snackbar("خطأ ", " غير موجود");
        } else if (response.statusCode == 200) {
          if (response.data['data']['status'] == 200) {
            saveToken(response.data['data']['access_token'],
                response.data['data']['name'], response.data['data']['id']);
            Get.offAll(HomeScreen());
            Get.snackbar("تم ", "تسم تسجيل  الدخول بنجاح");
          }
        } else {
          Get.snackbar(" خطأ ", "عذرا البريد او كلمة مرور خاطئة");
        }
      } else {
        print('');
      }
      emailController.text = '';
      passwordCotroller.text = '';
    } on Exception catch (e) {
      print(e);
    }
  }

  saveToken(String token, String name, int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
    await pref.setString("name", name);
    await pref.setInt('id', id);

    update();
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.get('token');
    name = pref.get('name');
    update();
  }

  removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('name');
    update();
  }

  checkSignUp() async {
    try {
      if (singupFromKey.currentState.validate()) {
        singupFromKey.currentState.save();
        dynamic response = await ApiHelper.apiHelper.register(
            nameController.text,
            imageFile,
            passwordCotroller.text,
            emailController.text);
        print(response.data);
        if (response.statusCode == 201) {
          saveToken(response.data['data']['access_token'],
              response.data['data']['name'], response.data['data']['id']);
          Get.offAll(HomeScreen());
          Get.snackbar("تم ", "تسم تسجيل حسابك بنجاح");
        } else {
          Get.snackbar(" خطأ ", "تم تسجيل بهذا الايميل مسبقا");
        }
      } else {
        print('');
      }
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordCotroller.dispose();

    super.onClose();
  }
}
