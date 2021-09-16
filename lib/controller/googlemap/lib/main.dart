import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  addMarker(Marker marker) {
    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GoogleMap")),
      body: GoogleMap(
        markers: markers,
        onMapCreated: (x) {
          this.googleMapController = x;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(45.521563, -122.677433),
          zoom: 11,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController!.animateCamera((CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(45.521563, -122.677433), zoom: 11))));
          addMarker(Marker(
              markerId: MarkerId("gaza"),
              position: LatLng(45.521563, -122.677433)));
          setState(() {});
        },
      ),
    );
  }
}
