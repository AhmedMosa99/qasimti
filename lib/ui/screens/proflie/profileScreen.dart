import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/controller/appLanguage.dart';
import 'package:qasimati/ui/screens/AddProduct/AddProduchSccreen.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:qasimati/ui/screens/proflie/favoriteScreen.dart';
import 'package:qasimati/ui/screens/Authication/my_acountScreen.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';
import 'package:qasimati/ui/screens/proflie/aboutUs.dart';
import 'package:qasimati/ui/screens/proflie/contactUs.dart';
import 'package:qasimati/ui/screens/proflie/privacy.dart';
import 'package:qasimati/ui/screens/proflie/questions.dart';
import 'package:qasimati/ui/screens/proflie/termsConditions.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool toggleValue = false;
  int inial;

  AuthController controller;
  AppLanguage controller1;
  ApiController controller2;
  @override
  void initState() {
    controller = Get.find<AuthController>();
    controller1 = Get.find<AppLanguage>();
    controller2 = Get.find<ApiController>();
    controller.getUser();
    controller.getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text("Profile".tr),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.name == null
                      ? Container(
                          margin: EdgeInsets.only(top: 30.h, bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(SignUp());
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      GFAvatar(
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.2),
                                        foregroundColor:
                                            Theme.of(context).primaryColor,
                                        size: 70.w,
                                        child: Image.asset(
                                            'assets/images/AddUser.png'),
                                      ),
                                      Text(
                                        "Sign Up".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(Login());
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      GFAvatar(
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.2),
                                        foregroundColor:
                                            Theme.of(context).primaryColor,
                                        size: 70.w,
                                        child: Image.asset(
                                            'assets/images/Light-Profile.png'),
                                      ),
                                      Text(
                                        "Sign In".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(MyAccount());
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 30.h, bottom: 10.h),
                            child: Column(
                              children: [
                                GFAvatar(
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2),
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  size: 70.w,
                                  child: Image.asset(
                                      'assets/images/Light-Profile.png'),
                                ),
                                Text(
                                  controller.name,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.name == null) {
                              Get.defaultDialog(
                                title: "Sorry".tr,
                                titleStyle: TextStyle(color: Colors.black87),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Content".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.w)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(Login());
                                              },
                                              child: Text(
                                                "Sign In".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(SignUp());
                                              },
                                              child: Text(
                                                "Sign Up".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else if (controller.verify == "A") {
                              Get.snackbar(
                                  'Sorry'.tr, "Check your verify account".tr);
                            } else if (controller.name != null &&
                                controller.verify != "A") {
                              controller.getUser();
                              Get.to(AddCoubon());
                            }
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Image.asset(
                                "assets/images/Stroke 7.png",
                                width: 50.w,
                              ),
                            ),
                            title: Text(
                              "Add Coupon".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontFamily: 'Jannat',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GetBuilder<AppLanguage>(builder: (contrller1) {
                          return Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  Icons.language,
                                  size: 30.w,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "Language".tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Get.locale.toString() == "en"
                                      ? 10.w
                                      : 30.w,
                                ),
                                ToggleSwitch(
                                  changeOnTap: false,
                                  minWidth: 90.0.w,
                                  minHeight: 50.h,
                                  initialLabelIndex: controller1.inial ?? 0,
                                  cornerRadius: 30.0,
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.white,
                                  inactiveFgColor: Colors.black,
                                  totalSwitches: 2,
                                  radiusStyle: true,
                                  labels: ['العربية', 'English'],
                                  fontSize: 15.sp,
                                  activeBgColors: [
                                    [Theme.of(context).primaryColor],
                                    [Theme.of(context).primaryColor],
                                  ],
                                  onToggle: (index) {
                                    if (index == 1) {
                                      controller1.inial = 1;
                                      controller1.changeLanguage("en");
                                      Get.updateLocale(Locale("en"));
                                      controller2.getCategories();
                                      controller2.getAllCouponInStore();
                                      controller2.getCouponsByCategory(
                                          controller2.selectCategoryName);
                                    } else if (index == 0) {
                                      controller1.inial = 0;
                                      controller1.changeLanguage("ar");
                                      Get.updateLocale(Locale("ar"));
                                      controller2.getCategories();
                                      controller2.getAllCouponInStore();
                                      controller2.getCouponsByCategory(
                                          controller2.selectCategoryName);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ));
                        }),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(Favorite());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  Icons.favorite_outline,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                                  size: 30.w,
                                ),
                              ),
                            ),
                            title: Text(
                              "Favorite".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //       child: ListTile(
                        //     leading: Container(
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(15.w),
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(.2)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: FaIcon(
                        //           Icons.star_rate_outlined,
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(.7),
                        //           size: 30.w,
                        //         ),
                        //       ),
                        //     ),
                        //     title: Text(
                        //       "Rate Us".tr,
                        //       style: TextStyle(
                        //           fontSize: 16.sp,
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     trailing: Icon(Icons.arrow_forward_ios),
                        //   )),
                        // ),
                        // Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(AboutUs());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  Icons.info_rounded,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                                  size: 30.w,
                                ),
                              ),
                            ),
                            title: Text(
                              "About us".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(ContactUs());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  Icons.email_outlined,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                                  size: 30.w,
                                ),
                              ),
                            ),
                            title: Text(
                              "Contact us".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),

                        GestureDetector(
                          onTap: () {
                            Get.to(Questions());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/question.png",
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.8),
                                  )),
                            ),
                            title: Text(
                              "Common questions".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(TermsConditions());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/Iconly-Light-Paper.png",
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.8),
                                  )),
                            ),
                            title: Text(
                              "Terms & Conditions".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(Privacy());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  Icons.privacy_tip,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                                  size: 30.w,
                                ),
                              ),
                            ),
                            title: Text(
                              "Privacy policy".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
