import 'package:flutter/cupertino.dart';
import 'package:qasimati/ui/screens/home/components/categories.dart';
import 'package:qasimati/ui/screens/home/components/copouns.dart';
import 'package:qasimati/ui/screens/home/components/slider.dart';
import 'package:qasimati/ui/screens/home/components/stores.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Sliders(),
          StoresComponet(),
          SizedBox(
            height: 10,
          ),
          Categorylist(),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Copouns(),
          ),
        ],
      ),
    );
  }
}
