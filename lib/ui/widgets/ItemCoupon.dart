import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:qasimati/ui/widgets/dialogDetilesCoupon.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ItemCoupon extends StatefulWidget {
  CouponModel couponModel;

  ItemCoupon(this.couponModel);

  @override
  State<ItemCoupon> createState() => _ItemCouponState();
}

class _ItemCouponState extends State<ItemCoupon> {
  var controller;

  @override
  void initState() {
    controller = Get.find<ApiController>();
    super.initState();
  }

  void launchURL() async => await canLaunch(widget.couponModel.store.link)
      ? await launch(widget.couponModel.store.link)
      : throw Get.to((OfferPage(widget.couponModel.store.link)));

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, right: 20, left: 20),
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(
            Get.locale.toString() == "ar"
                ? 'assets/images/background.png'
                : "assets/images/backgroundRight.png",
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.couponModel.type == 'coupon') {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: DetialsCoupon(
                      couponModel: widget.couponModel,
                    ),
                  );
                });
          } else {
            if (widget.couponModel.link != null) {
              launchURL();
            }
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Get.locale.toString() == "en"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.network(
                  widget.couponModel.store.image,
                  width: MediaQuery.of(context).size.width / 5,
                ),
              ),
            ),
            widget.couponModel.tag.name != null
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(widget.couponModel.tag.name),
                    ),
                  )
                : Container(),
            Positioned(
              top: MediaQuery.of(context).size.width / 9,
              right: Get.locale.toString() == "ar"
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width / 9,
              left: Get.locale.toString() == "en"
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width / 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  widget.couponModel.mainTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
