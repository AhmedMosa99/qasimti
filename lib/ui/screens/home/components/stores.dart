import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Store/store_screen.dart';

class StoresComponet extends StatefulWidget {
  @override
  _StoresComponetState createState() => _StoresComponetState();
}

class _StoresComponetState extends State<StoresComponet> {
  var controller = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allStores.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height / 9,
              )
            : Container(
                height: MediaQuery.of(context).size.height / 9,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.allStores.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedStore =
                              controller.allStores[index].name;

                          controller.getAllCouponInStore();
                          Get.to(StoreScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFAvatar(
                            shape: GFAvatarShape.square,
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.white,
                            size: MediaQuery.of(context).size.width / 5,
                            child: Image(
                              image: NetworkImage(
                                  controller.allStores[index].image),
                            ),
                          ),
                        ),
                      );
                    }),
              );
      },
    );
  }
}
