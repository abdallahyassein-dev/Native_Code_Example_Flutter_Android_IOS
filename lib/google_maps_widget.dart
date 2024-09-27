import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoogleMapsWidget extends StatelessWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final double? initialZoom;

  const GoogleMapsWidget(
      {super.key,
      this.initialLatitude,
      this.initialLongitude,
      this.initialZoom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Set the desired width
      height: 400, // Set the desired height
      child: UiKitView(
        viewType: 'com.example.google_maps/native_map_view',
        creationParams: {
          'latitude': initialLatitude ?? 0.0,
          'longitude': initialLongitude ?? 0.0,
          'zoom': initialZoom ?? 12,
        },
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
