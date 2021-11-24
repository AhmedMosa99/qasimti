import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';

class Questions extends StatefulWidget {
  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  ApiController controller;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.commnQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Common questions".tr,
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
          return controller.allQuestions.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: GFLoader(
                      type: GFLoaderType.ios,
                    ),
                  ),
                )
              : ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                  itemCount: controller.allQuestions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // padding: EdgeInsets.a,
                      decoration: BoxDecoration(color: Colors.white
                          //   border: Border.all(color: Colors.black),
                          ),
                      child: GFAccordion(
                        expandedTitleBackgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.38),
                        contentBorderRadius: BorderRadius.circular(20),
                        collapsedTitleBackgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.1),
                        title: controller.allQuestions[index].question,
                        content: controller.allQuestions[index].answer,
                      ),
                    );
                  });
        }));
  }
}
