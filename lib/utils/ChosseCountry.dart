import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/appLanguage.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';

class ChoseCountry extends StatefulWidget {
  const ChoseCountry({Key key}) : super(key: key);

  @override
  _ChoseCountryState createState() => _ChoseCountryState();
}

class _ChoseCountryState extends State<ChoseCountry> {
  int choseCountry = 0;
  int choseLang = 0;
  var controllerApi;
  final controllerLang = Get.put(AppLanguage());
  List lang = ["اللغة العربية", "English"];

  @override
  void initState() {
    controllerApi = Get.put(ApiController());
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      if (choseCountry == 0) {
        controllerApi.dropdownValue = controllerApi.allcountries.first.shortcut;
        controllerApi.saveCountry();
        //   controllerApi.getCountry();
      }
    });
    // controllerApi.getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 12.h),
            child: Column(
              //padding: EdgeInsets.zero,
              children: [
                Center(
                    child: Text(
                  "اختر الدولة ",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                    child: Text(
                        'يرجى اختيار الدولة التي تريد, يمكنك تغيرها لاحقا')),
                GetBuilder<ApiController>(
                    init: ApiController(),
                    builder: (controller) {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            //  physics:NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: controller.allcountries.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: GFListTile(
                                      margin: EdgeInsets.only(
                                          right: 20.w, top: 5.h, left: 20.w),
                                      padding: EdgeInsets.zero,
                                      onTap: () {
                                        choseCountry = index;
                                        controller.dropdownValue = controller
                                            .allcountries[index].shortcut;
                                        // controller.getCountry();
                                        setState(() {});
                                        // controller.saveCountry();
                                        //    controller.getCountry();
                                      },
                                      title: Row(
                                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            controller
                                                .allcountries[index].image,
                                            width: 50.w,
                                            height: 50.h,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                              child: Text(controller
                                                  .allcountries[index].name)),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          choseCountry == index
                                              ? GFAvatar(
                                                  size: 15.w,
                                                  child: Icon(
                                                    Icons.done,
                                                    size: 15.w,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      subTitle: Divider(),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }),
                Center(
                    child: Text(
                  "اختر اللغة ",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                    child: Text(
                        'يرجى اختيار اللغة التي تريد, يمكنك تغيرها لاحقا')),
                SizedBox(
                  height: 12.h,
                ),
                GetBuilder<AppLanguage>(
                    init: AppLanguage(),
                    builder: (controller) {
                      return Container(
                        height: 100.h,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: lang.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: GFListTile(
                                      margin: EdgeInsets.only(
                                          right: 20.w, top: 5.h),
                                      padding: EdgeInsets.zero,
                                      onTap: () {
                                        choseLang = index;
                                        if (choseLang == 0) {
                                          controller.changeLanguage('ar');
                                          controller.appLocal = "ar";
                                          Get.updateLocale(Locale("ar"));
                                          controllerApi.getCategories();
                                          //   controllerApi.getAllCouponInStore();
                                          //   controllerApi.getCouponsByCategory(
                                          // controllerApi.selectCategoryName);
                                          controllerApi.commnQuestion();
                                          controllerApi.termsCondtions();
                                          controllerApi.policy();
                                          controllerApi.whoArewe();
                                        } else if (choseLang == 1) {
                                          controller.appLocal = 'en';
                                          controller.changeLanguage('en');
                                          controller.appLocal = "en";
                                          Get.updateLocale(Locale("en"));
                                          controllerApi.getCategories();
                                          //      controllerApi.getAllCouponInStore();
                                          //       controllerApi.getCouponsByCategory(
                                          //            controllerApi.selectCategoryName);
                                          controllerApi.commnQuestion();
                                          controllerApi.termsCondtions();
                                          controllerApi.policy();
                                          controllerApi.whoArewe();
                                        }

                                        setState(() {});
                                      },
                                      title: Row(
                                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              lang[index],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          choseLang == index
                                              ? GFAvatar(
                                                  size: 15.w,
                                                  child: Icon(
                                                    Icons.done,
                                                    size: 15.w,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      subTitle: Divider(),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<ApiController>(builder: (logic) {
                  return SizedBox(
                      height: 48.h,
                      width: double.infinity,
                      child: CustomButton('حفظ', () {
                        Get.off(HomeScreen());
                        logic.saveCountry();
                        logic.getCountry();
                      }, Theme.of(context).primaryColor, Colors.white));
                }),
                SizedBox(
                  height: 20.h,
                ),
                // ListView.builder(
                //     itemCount: 2,
                //     itemBuilder: (context,index){
                //   return GFListTile(
                //
                //   );
                // })
              ],
            ),
          ))),
    );
  }
}
