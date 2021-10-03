import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Questions extends StatefulWidget {
  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
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
            "https://sad-albattani-37dce1.netlify.app/fqa?lang=${Get.locale.toString()}&webview=1",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
