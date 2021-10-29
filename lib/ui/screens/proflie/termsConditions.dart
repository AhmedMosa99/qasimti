import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditions extends StatefulWidget {
  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
          'assets/images/Logo.png',
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 12,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl:
            "https://qasimati.com/terms-conditions?lang=${Get.locale.toString()}&webview=1",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
