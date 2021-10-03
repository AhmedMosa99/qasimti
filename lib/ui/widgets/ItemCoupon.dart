import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:qasimati/ui/widgets/dialogDetilesCoupon.dart';
import 'package:url_launcher/url_launcher.dart';


class ItemCoupon extends StatelessWidget {
  CouponModel couponModel;
  ItemCoupon(this.couponModel);
  void launchURL() async => await canLaunch(couponModel.store.link)
      ? await launch(couponModel.store.link)
      : throw  Get.to((OfferPage(couponModel.store.link)));

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (couponModel.type == 'coupon') {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: DetialsCopuon(
                    couponModel: couponModel,
                  ),
                );
              });
        } else {
          print(couponModel.store.link);
          if (couponModel.link != null) {
            launchURL();
          }
        }
      },
      child: Container(
        child: GFListTile(
          color: Colors.white,
          avatar: Row(
            children: [
              couponModel.store.image == null
                  ? GFLoader
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.red)),
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.width / 5,

                      //  backgroundColor: Colors.grey.withOpacity(.2),
                      child: Image(
                        image: NetworkImage(
                          couponModel.store.image,
                        ),
                      ),
                    ),
              SizedBox(
                width: 5,
              ),
              FDottedLine(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height / 10,
                strokeWidth: 3.0,
                dottedLength: 10.0,
                space: 2.0,
              ),
            ],
          ),
          title: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                  child: Expanded(
                child: Text(
                  couponModel.store.name ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              )),
            ],
          ),
          icon: couponModel.tag.name == null
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    couponModel.tag.name ?? "",
                    style: TextStyle(color: Colors.black),
                  )),
          subTitle: Text(couponModel.mainTitle ?? ""),
        ),
      ),
    );
  }
}
