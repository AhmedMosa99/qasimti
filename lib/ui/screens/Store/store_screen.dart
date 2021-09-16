import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/appLanguage.dart';
import 'package:qasimati/ui/screens/home/components/header.dart';
import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  ApiController controller;
  AppLanguage controller1;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.getAllCouponInStore();
    controller1 = Get.find<AppLanguage>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: Header(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: controller.allCouponStore.isEmpty
              ? GFLoader()
              : ListView.builder(
                  itemCount: controller.allCouponStore.length,
                  padding: EdgeInsets.only(top: 2),
                  itemBuilder: (context, index) {
                    return ItemCoupon(controller.allCouponStore[index]);
                  }),
        ),
      );
    });
  }
}
