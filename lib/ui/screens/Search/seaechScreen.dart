import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Store/store_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiController controller;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = Get.find<ApiController>();
    controller.searchStore("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/Logo.png',
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GetBuilder<ApiController>(
                      init: ApiController(),
                      builder: (controller) {
                        return Container(
                          child: Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: TextFormField(
                                onChanged: (v) {
                                  controller.searchStore(v);

                                  print(v);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Search'.tr,
                                  hintStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: GetBuilder<ApiController>(
                  init: ApiController(),
                  builder: (controller) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: controller.allstoreSearch.isEmpty
                          ? GFLoader(
                              type: GFLoaderType.ios,
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () async {
                                    controller.selectedStore = controller
                                        .allstoreSearch[position].name;
                                    controller.getAllCouponInStore();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoreScreen()));
                                  },
                                  child: Column(
                                    children: [
                                      GFAvatar(
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          backgroundImage: NetworkImage(
                                              controller
                                                  .allstoreSearch[position]
                                                  .image)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                            controller
                                                .allstoreSearch[position].name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller.allstoreSearch.length,
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
