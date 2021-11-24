import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String title, url;
  bool isLoading = true;
  final key = UniqueKey();
  ApiController controller;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.whoArewe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "About us".tr,
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
          return SingleChildScrollView(
            child: controller.whoAreWe == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: GFLoader(
                        type: GFLoaderType.ios,
                      ),
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                    child: Html(
                      data: '${controller.whoAreWe}',
                      style: {
                        "span": Style(
                            padding: EdgeInsets.all(6),
                            //   fontSize: FontSize.large,
                            //   wordSpacing: 2,
                            fontFamily: 'Jannat'),
                      },
                    ),
                  ),
          );
        }));
  }
}
