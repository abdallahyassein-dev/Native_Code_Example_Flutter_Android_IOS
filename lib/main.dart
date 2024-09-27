import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:write_native_code_exampel/google_maps_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NativeGoogleMapView(),
    );
  }
}

class NativeGoogleMapView extends StatefulWidget {
  @override
  _NativeGoogleMapViewState createState() => _NativeGoogleMapViewState();
}

class _NativeGoogleMapViewState extends State<NativeGoogleMapView> {
  @override
  Widget build(BuildContext context) {
    // Example start position for the camera (San Francisco)
    final double initialLatitude = 37.7749;
    final double initialLongitude = -122.4194;
    final double initialZoom = 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Native iOS Integration'),
      ),
      body: Center(
          child: GoogleMapsWidget(
        initialLatitude: initialLatitude,
        initialLongitude: initialLongitude,
        initialZoom: initialZoom,
      )),
    );
  }
}
