import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginKey;
  GlobalKey<FormState> singupFromKey;
  GlobalKey<FormState> updateForm;
  TextEditingController emailController,
      passwordCotroller,
      nameController,
      nameEdit,
      passwordEdit,
      emialEdit;

  String name;
  String token;
  String imageUrl = "";
  File imageFile;
  File imageEdit;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordCotroller = TextEditingController();
    nameController = TextEditingController();
    nameEdit = TextEditingController();
    passwordEdit = TextEditingController();
    emialEdit = TextEditingController();
    loginKey = GlobalKey<FormState>();
    singupFromKey = GlobalKey<FormState>();
    updateForm = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print(imageFile);
  }

  String validateName(String value) {
    if (value.trim().isEmpty) {
      return "Username is not Empty".tr;
    }
    return null;
  }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Eamil is not vaild".tr;
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
        if (response.data['status'] == 404) {
          Get.snackbar("خطأ ", " غير موجود");
        } else if (response.data['status'] == 401) {
          Get.snackbar("خطأ ", "كلمة المرور خاطئة");
        } else if (response.data['data']['status'] == 200) {
          saveToken(response.data['data']['access_token'],
              response.data['data']['name'], response.data['data']['id']);
          Get.offAll(HomeScreen());
          Get.snackbar("تم ", "ت  م تسجيل  الدخول بنجاح");
        }
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

  saveName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("name", name);
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
    await pref.remove("id");
    update();
  }

  checkSignUp() async {
    try {
      if (singupFromKey.currentState.validate()) {
        singupFromKey.currentState.save();

        dynamic response = await ApiHelper.apiHelper.register(
            name: nameController.text,
            url: imageFile,
            password: passwordCotroller.text,
            email: emailController.text);
        print(response.data);
        if (response.statusCode == 201) {
          saveToken(response.data['data']['access_token'],
              response.data['data']['name'], response.data['data']['id']);
          Get.offAll(HomeScreen());
          Get.snackbar("تم ", "تسم تسجيل حسابك بنجاح");
          emailController.clear();
          passwordCotroller.clear();
          imageFile = null;
          nameController.clear();
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

  getUser() async {
    dynamic response = await ApiHelper.apiHelper.getUserByToken(token);
    if (response != null) {
      if (response.statusCode == 200) {
        nameEdit.text = response.data['data']['name'];
        emialEdit.text = response.data['data']['email'];
        print(response.data['data']['image']);
        imageUrl = response.data['data']['image'];
        print(response.data);
        update();
      }
    }
  }

  updata() async {
    try {
      dynamic response = await ApiHelper.apiHelper
          .update(nameEdit.text, imageEdit, passwordEdit.text, token);
      print(response.data);
      if (response.statusCode == 200) {
        Get.snackbar("تم ", "تسم تعديل حسابك بنجاح");
        saveName(response.data['name']);
        updata();
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar("خطأ", "تحقق من الإدخال");
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
