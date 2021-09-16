import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
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
    return InkWell(
      onTap: () {
        print(controller.selectedStore);
      },
      child: GetBuilder<ApiController>(
        builder: (controller) {
          return controller.allStores == null
              ? GFLoader(
                  type: GFLoaderType.ios,
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
                            print(controller.selectedStore);
                            controller.getAllCouponInStore();
                            Get.to(StoreScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              child: Image(
                                width: MediaQuery.of(context).size.width / 4.5,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    controller.allStores[index].image),
                              ),
                            ),
                          ),
                        );
                      }),
                );
        },
      ),
    );
  }
}
