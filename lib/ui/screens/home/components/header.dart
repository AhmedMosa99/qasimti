import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';

import 'package:qasimati/controller/appLanguage.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  Header({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _HeaderState createState() => _HeaderState();

  @override
  final Size preferredSize;
}

class _HeaderState extends State<Header> {
  var controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      init: ApiController(),
      builder: (controller1) {
        return AppBar(
          shadowColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
              ),
            ),
          ),
          title: Image.asset(
            'assets/images/Logo.png',
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 12,
            color: Colors.white,
          ),
          actions: [
            Container(
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  dropdownColor: Theme.of(context).primaryColor,
                  dropdownButtonColor: Theme.of(context).primaryColor,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  value: controller.dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      controller.dropdownValue = newValue;
                      controller.selectCountry = newValue;
                      print(controller1.selectCountry);
                      controller1.selectCountry = newValue;
                      controller1.getSliders();
                      controller1.getStores();
                      controller1.getCategories();
                    });
                  },
                  items: controller1.allcountries
                      .map((value) => DropdownMenuItem(
                            value: value.shortcut,
                            child: Row(
                              children: [
                                Image(
                                  width: MediaQuery.of(context).size.width / 10,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  image: NetworkImage(value.image),
                                ),
                                Text(
                                  value.shortcut,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Container(
              child: GetBuilder<AppLanguage>(
                  init: AppLanguage(),
                  builder: (controller) {
                    return Container(
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          padding: EdgeInsets.zero,
                          dropdownColor: Theme.of(context).primaryColor,
                          dropdownButtonColor: Theme.of(context).primaryColor,
                          value: Get.locale.toString(),
                          focusColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          elevation: 0,
                          onChanged: (newValue) {
                            controller.changeLanguage(newValue);
                            Get.updateLocale(Locale(newValue));
                            controller1.getCategories();
                            controller1.getCouponsByCategory(
                                controller1.selectCategoryName);
                            controller1.getStores();
                            controller1.getAllCouponInStore();
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text("en"),
                              value: 'en',
                            ),
                            DropdownMenuItem(
                              child: Text("ar"),
                              value: 'ar',
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
        );
      },
    );
  }
}
