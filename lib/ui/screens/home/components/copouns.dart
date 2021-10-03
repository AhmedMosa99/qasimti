import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class Copouns extends StatefulWidget {
  @override
  _CopounsState createState() => _CopounsState();
}

class _CopounsState extends State<Copouns> {
  var controller;
  @override
  void initState() {
    var controller = Get.put(ApiController());
    controller.getCouponsByCategory(controller.selectCategoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allCoupons.isEmpty
            ? Center(
                child: Container(
                height: MediaQuery.of(context).size.height,
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: controller.allCoupons.length,
                    itemBuilder: (context, index) {
                      return ItemCoupon(controller.allCoupons[index]);
                    }),
              );
      },
    );
  }
}
