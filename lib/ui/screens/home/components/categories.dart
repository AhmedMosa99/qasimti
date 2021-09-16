import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:qasimati/controller/ApiController.dart';

// We need stateful widget because we need to change some sate on our category
class Categorylist extends StatefulWidget {
  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  var controller;
  @override
  void initState() {
    var controller = Get.put(ApiController());
    controller.getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      init: ApiController(),
      builder: (c) {
        return c.allCategories == null
            ? Center(
                child: GFLoader(
                type: GFLoaderType.ios,
              ))
            : Container(
                height: MediaQuery.of(context).size.height / 23,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.allCategories.length,
                  itemBuilder: (context, index) =>
                      buildCategory(index, context),
                ),
              );
      },
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GetBuilder<ApiController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              setState(() {
                controller.selectCategory = index;
                controller.selectCategoryName =
                    controller.allCategories[index].name;
                print(controller.selectCategoryName);
                controller
                    .getCouponsByCategory(controller.allCategories[index].name);
              });
            },
            child: controller.allCategories == null
                ? CircularProgressIndicator()
                : Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index == controller.selectCategory
                            ? Colors.blue.withOpacity(.5)
                            : Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Tab(icon: Icon((Icons.add))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          controller.allCategories[index].name ?? "",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
