import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:qasimati/ui/screens/Authication/editScreen.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          "My Account",
        ),
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return Container(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.to(EditScreen());
                },
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                title: Text('Edit Account',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.only(top: 10),
                subtitle: Divider(
                  height: 10,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                title: Text('Favarite ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                subtitle: Divider(
                  height: 10,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.removeToken();
                  Get.offAll(Login());
                },
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                title: Text('Log Out ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                subtitle: Divider(
                  height: 10,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
