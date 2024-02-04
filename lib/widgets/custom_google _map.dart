import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialCameraPosition =
        CameraPosition(target: LatLng(31.42700154326289, 31.649426087876556));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,

    );
  }
}
