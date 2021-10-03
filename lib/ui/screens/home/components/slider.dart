import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:qasimati/controller/ApiController.dart';

// ignore: must_be_immutable
class Sliders extends StatefulWidget {
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  var controller = Get.put(ApiController());
  @override
  void initState() {
    setState(() {
      controller.getSliders();
      controller.getStores();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allsliders.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: controller.allStores == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: controller.allsliders.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GFImageOverlay(
                              width: MediaQuery.of(context).size.width / 1.08,
                              image: NetworkImage(
                                  controller.allsliders[index].image),
                            ),
                          );
                        }),
              );
      },
    );
  }
}
