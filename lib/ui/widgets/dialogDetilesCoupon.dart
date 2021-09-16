import 'package:clipboard/clipboard.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:qasimati/models/coupon.dart';

class DetialsCopuon extends StatefulWidget {
  CouponModel couponModel;
  DetialsCopuon({this.couponModel});
  @override
  _DetialsCopuonState createState() => _DetialsCopuonState();
}

class _DetialsCopuonState extends State<DetialsCopuon> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool iscopy = false;
  bool isfavarite = false;
  bool isvaild = false;
  bool isNotvaild = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFAvatar(
              size: MediaQuery.of(context).size.width / 5,
              backgroundImage: NetworkImage(widget.couponModel.store.image),
              shape: GFAvatarShape.circle),
          Text(
            widget.couponModel.store.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("show now".tr),
                Icon(Icons.link_rounded),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(),
          Column(
            children: [
              Text(
                "offer".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text("10%",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Text(
                "Derails".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text("10% off",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Last Valid use:".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  isvaild ? formattedDate : "Less Than hour",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  FlutterClipboard.copy('hello flutter friends')
                      .then((value) => print("copeid"));
                  iscopy = !iscopy;

                  setState(() {});
                },
                child: Container(
                  width: 180,
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: iscopy == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.couponModel.code,
                                  style: TextStyle(fontSize: 18)),
                              FDottedLine(
                                color: Colors.white,
                                height: 50,
                                strokeWidth: 3.0,
                                dottedLength: 10.0,
                                space: 2.0,
                              ),
                              Text(
                                "Coppy",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        : Text("Copeid"),
                    onPressed: () {
                      iscopy = !iscopy;

                      setState(() {});
                    },
                  ),
                )),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoActionSheet(
                  actions: [
                    GestureDetector(
                      onTap: () {
                        isvaild = !isvaild;
                        if (isvaild) {
                          isNotvaild = false;
                        }
                        setState(() {});
                      },
                      child: Container(
                        color: isvaild
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    Icons.thumb_up,
                                    color: isvaild ? Colors.blue : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Valid".tr,
                                    style: TextStyle(
                                        color: isvaild
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoActionSheet(
                  actions: [
                    GestureDetector(
                      onTap: () {
                        isNotvaild = !isNotvaild;

                        if (isNotvaild) {
                          isvaild = false;
                        } else {
                          isvaild = true;
                        }

                        setState(() {});
                      },
                      child: Container(
                        color: isNotvaild
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    Icons.thumb_down,
                                    color:
                                        isNotvaild ? Colors.blue : Colors.grey,
                                  ),
                                  Text(
                                    "invalid".tr,
                                    style: TextStyle(
                                        color: isNotvaild
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
