import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';

import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  ApiController controller;
  AuthController controller1;

  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller1 = Get.put(AuthController());
    controller.getFavoriteCoupon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Favorite".tr,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30.h),
          height: MediaQuery.of(context).size.height,
          child: controller.allfavorite.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Group.png',
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("currently in the favourites".tr),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("You can browse coupons now".tr),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                          width: 350.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: CustomButton("Go Home".tr, () {
                            Get.offAll(HomeScreen());
                          }, Theme.of(context).primaryColor, Colors.white)),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: controller.allfavorite.length,
                  padding: EdgeInsets.only(top: 2),
                  itemBuilder: (context, index) {
                    return ItemCoupon(controller.allfavorite[index]);
                  }),
        ),
      );
    });
  }
}
