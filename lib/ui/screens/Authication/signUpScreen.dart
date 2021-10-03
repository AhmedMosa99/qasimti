import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qasimati/controller/AuthController.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController controller;
  File _image;
  imgFromGallery() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile image = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);

        controller.imageFile = _image;
        print("${controller.imageFile}");
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    controller = Get.find<AuthController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Sign Up",
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
            GetBuilder<AuthController>(
              builder: (controller) {
                return Form(
                  key: controller.singupFromKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                          GestureDetector(
                            onTap: () {
                              imgFromGallery();
                            },
                            child: Center(
                              child: GFAvatar(
                                radius: 50,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: _image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          _image,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: controller.nameController,
                            validator: (v) {
                              return controller.validateName(v);
                            },
                            onSaved: (s) {
                              controller.nameController.text = s;
                            },
                            decoration: InputDecoration(
                              labelText: "UserName".tr,
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (v) {
                              return controller.validateEmail(v);
                            },
                            onSaved: (s) {
                              controller.emailController.text = s;
                            },
                            decoration: InputDecoration(
                              labelText: "Email".tr,
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.passwordCotroller,
                            validator: (v) {
                              return controller.validatePassword(v);
                            },
                            onSaved: (s) {
                              controller.passwordCotroller.text = s;
                            },
                            decoration: InputDecoration(
                              labelText: "password".tr,
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                  "Sign Up".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  controller.checkSignUp();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
