import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Store/store_screen.dart';

class AllStores extends StatefulWidget {
  @override
  _AllStoresState createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  ApiController controller;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ApiController>(
        init: ApiController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: c.allStores == null
                ? GFLoader(
                    type: GFLoaderType.ios,
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () async {
                          c.selectedStore = c.allStores[position].name;
                          c.getAllCouponInStore();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreScreen()));
                        },
                        child: Column(
                          children: [
                            GFAvatar(
                                size: MediaQuery.of(context).size.width / 5,
                                backgroundImage:
                                    NetworkImage(c.allStores[position].image)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  c.allStores[position].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: c.allStores.length,
                  ),
          );
        },
      ),
    );
  }
}
