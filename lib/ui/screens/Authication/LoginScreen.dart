import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/Authication/forgetPassword.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';
import 'package:qasimati/ui/widgets/CustomTextFeild.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Get.offAll(HomeScreen());
            },
          ),
        ],
        title: Text(
          "Login".tr,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 24,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            GetBuilder<AuthController>(builder: (_) {
              return Form(
                key: controller.loginKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(

                        // changes position of shadow
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/Logo.png',
                            width: 200.w,
                          ),
                        ),
                        CustomTextFeild('Email'.tr, controller.emailController,
                            'example@mail.com'),
                        CustomTextFeild('password'.tr,
                            controller.passwordCotroller, "********", true),
                        Align(
                          alignment: Get.locale.toString() == "ar"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: TextButton(
                            child: Text(
                              "Forgot your password?".tr,
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Get.to(ForgetPassword());
                            },
                          ),
                        ),
                        Container(
                            width: 350.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("Sign In".tr, () {
                              controller.checkLogin();
                            }, Theme.of(context).primaryColor, Colors.white)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: 350.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("Sign Up".tr, () {
                              Get.offAll(SignUp());
                              controller.emailController.clear();
                              controller.passwordCotroller.clear();
                            }, Colors.white, Colors.black)),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
