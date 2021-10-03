import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:getwidget/direction/gf_shimmer_direction.dart';
import 'package:qasimati/controller/ApiController.dart';

import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  ApiController controller;

  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.getFavoriteCoupon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Image.asset(
            'assets/images/Logo.png',
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 12,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: controller.allfavorite.isEmpty
              ? Center(
                  child: GFShimmer(
                    direction: Get.locale.toString() == "ar"
                        ? GFShimmerDirection.rightToLeft
                        : GFShimmerDirection.leftToRight,
                    mainColor: GFColors.DARK,
                    secondaryColor: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 5),
                    child:
                        Text("favourites".tr, style: TextStyle(fontSize: 18)),
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
