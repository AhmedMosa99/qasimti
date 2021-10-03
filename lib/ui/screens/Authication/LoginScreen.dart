import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Login".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
        child: ListView(
          children: [
            GetBuilder<AuthController>(builder: (_) {
              return Form(
                key: controller.loginKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ], // changes position of shadow
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (v) {
                            return controller.validateEmail(v);
                          },
                          onSaved: (value) {
                            controller.emailController.text = value;
                          },
                          decoration: InputDecoration(
                            labelText: "Email".tr,
                            labelStyle: TextStyle(fontSize: 16),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (v) {
                            return controller.validatePassword(v);
                          },
                          onSaved: (value) {
                            controller.passwordCotroller.text = value;
                          },
                          decoration: InputDecoration(
                            labelText: "password".tr,
                            labelStyle: TextStyle(fontSize: 16),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: GFButton(
                              shape: GFButtonShape.pills,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Sign In".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              onPressed: () {
                                controller.checkLogin();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("New User ? ".tr),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Container(
                                  child: Text(
                                    "Sign Up".tr,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
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
