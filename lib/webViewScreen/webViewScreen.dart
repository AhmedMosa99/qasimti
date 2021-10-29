import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebScreen extends StatelessWidget {
  String link;
  WebScreen({this.link});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: WebView(
          initialUrl: link,
        ),
      ),
    );
  }
}
