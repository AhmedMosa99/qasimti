import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/ui/widgets/dialogDetilesCoupon.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCoupon extends StatelessWidget {
  CouponModel couponModel;
  ItemCoupon(this.couponModel);
  void launchURL() async => await canLaunch(couponModel.store.link)
      ? await launch(couponModel.store.link)
      : throw 'Could not launch ${couponModel.store.link}';

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
      child: GFListTile(
        color: Colors.white,
        avatar: Row(
          children: [
            GFAvatar(
              size: GFSize.LARGE,
              shape: GFAvatarShape.circle,
              backgroundImage: NetworkImage(
                couponModel.store.image,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            FDottedLine(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height / 13,
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
                child: Text(
              couponModel.store.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ],
        ),
        icon: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              border: Border.all(color: Colors.red),
            ),
            child: Text(
              couponModel.tag.name,
              style: TextStyle(color: Colors.black),
            )),
        subTitle: Text(couponModel.mainTitle),
      ),
    );
  }
}
