import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/bindings.dart';
import 'package:qasimati/translation.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => HomeScreen()),
      ],
      color: Colors.white,
      translations: Translation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF5F57A0),
        accentColor: Colors.cyan[600],
      ),
      home: HomeScreen(),
    );
  }
}
