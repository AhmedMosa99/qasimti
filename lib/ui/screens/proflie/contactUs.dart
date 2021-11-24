import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';
import 'package:qasimati/ui/widgets/CustomTextFeild.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Contact us".tr,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: ListView(
          children: [
            GetBuilder<AuthController>(builder: (_) {
              return Form(
                key: controller.contactForm,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(

                        // changes position of shadow
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFeild(
                            'Name'.tr, controller.nameController, 'Name'.tr),
                        CustomTextFeild('Email'.tr, controller.emailController,
                            'example@mail.com'),
                        Container(
                          child: CustomTextFeild('Subject'.tr,
                              controller.subjectController, 'Subject'.tr),
                        ),
                        CustomTextFeild('SubjectDes'.tr,
                            controller.bodyController, 'SubjectDes'.tr),
                        Container(
                            width: 360.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("SEND".tr, () {
                              controller.contactUs();
                            }, Theme.of(context).primaryColor, Colors.white)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: 360.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("CANCEL".tr, () {
                              Get.back();
                              controller.emailController.clear();
                              controller.passwordCotroller.clear();
                              controller.nameController.clear();
                            }, Colors.white, Colors.black)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await canLaunch(controller.social.facebook)
                                    ? await launch(controller.social.facebook)
                                    : throw Get.to((OfferPage(
                                        controller.social.facebook)));
                              },
                              icon: SvgPicture.asset(
                                "assets/images/icons8-facebook.svg",
                                width: 35.w,
                                height: 35.h,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            IconButton(
                              onPressed: () async {
                                await canLaunch(controller.social.instagram)
                                    ? await launch(controller.social.instagram)
                                    : throw Get.to((OfferPage(
                                        controller.social.instagram)));
                              },
                              icon: SvgPicture.asset(
                                "assets/images/icons8-instagram.svg",
                                width: 35.w,
                                height: 35.h,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            IconButton(
                              onPressed: () async {
                                await canLaunch(controller.social.twitter)
                                    ? await launch(controller.social.twitter)
                                    : throw Get.to(
                                        (OfferPage(controller.social.twitter)));
                              },
                              icon: SvgPicture.asset(
                                "assets/images/icons8-twitter.svg",
                                width: 35.w,
                                height: 35.h,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            IconButton(
                              onPressed: () async {
                                await canLaunch(controller.social.telegram)
                                    ? await launch(controller.social.telegram)
                                    : throw Get.to((OfferPage(
                                        controller.social.telegram)));
                              },
                              icon: SvgPicture.asset(
                                "assets/images/icons8-telegram.svg",
                                width: 35.w,
                                height: 30.h,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
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
