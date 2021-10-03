import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


// ignore: must_be_immutable
class OfferPage extends StatelessWidget {
String url;
OfferPage(this.url);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
