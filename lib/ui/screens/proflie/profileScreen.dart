import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/AddProduct/AddProduchSccreen.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:qasimati/ui/screens/Authication/favoriteScreen.dart';
import 'package:qasimati/ui/screens/Authication/my_acountScreen.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';
import 'package:qasimati/ui/screens/proflie/aboutUs.dart';
import 'package:qasimati/ui/screens/proflie/contactUs.dart';
import 'package:qasimati/ui/screens/proflie/privacy.dart';
import 'package:qasimati/ui/screens/proflie/questions.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var controller;
  @override
  void initState() {
    controller = Get.find<AuthController>();
    controller.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: new BorderRadius.vertical(
                            bottom: new Radius.elliptical(
                                MediaQuery.of(context).size.width / 2, 80.0)),
                      ),
                      child: Center(
                          child: Image.asset(
                        'assets/images/Logo.png',
                        width: MediaQuery.of(context).size.width / 2,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          controller.name == null
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(Login());
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                19,
                                          ),
                                          Text(
                                            "Sign In".tr,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Get.to(MyAccount());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              19,
                                        ),
                                        Text(
                                          controller.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
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
                                              fontSize: 18, color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                    BorderRadius.circular(15)),
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
                              } else if (controller.name != null) {
                                Get.to(AddCoubon());
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      Icons.add_circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Add Copoun".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Favorite());
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Favorite".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(AboutUs());
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "About us".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(ContactUs());
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Contact us".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Privacy());
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.privacy_tip_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Privacy policy".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Divider(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Questions());
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/question.png',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Common questions".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
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
