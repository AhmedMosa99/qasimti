import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';

class TermsConditions extends StatefulWidget {
  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  String title, url;
  bool isLoading = true;
  ApiController controller;
  @override
  void initState() {
    controller = Get.put(ApiController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Terms & Conditions".tr,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: GetBuilder<ApiController>(builder: (controller) {
          return controller.terms == null
              ? Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: GFLoader(
                      type: GFLoaderType.ios,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                    child: Html(
                      data: '${controller.terms}',
                      style: {
                        "span": Style(
                            padding: EdgeInsets.all(6),
                            // fontSize: FontSize.em(.95),
                            //   wordSpacing: 2,
                            fontFamily: 'Jannat'),
                      },
                    ),
                  ),
                );
        }));
  }
}
