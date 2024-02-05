import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late Location location;

  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(
        target: LatLng(31.424516876428225, 31.816308759942583), zoom: 12);
    location = Location();
    // initMarkers();
    // initPolyLines();
    //  initPolygons();
    // initCircle();
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night-map_style.json");
    googleMapController.setMapStyle(nightMapStyle);
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          polylines: polyLines,
          markers: markers,
          polygons: polygons,
          circles: circles,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
            initMapStyle();
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              googleMapController.animateCamera(CameraUpdate.newLatLng(
                  const LatLng(25.65703109425309, 32.7008381671593)));
            },
            child: const Text("change Location "),
          ),
        )
      ],
    );
  }

  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // show error
      }
    }
  }

  Future<bool> checkLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {}
      return false;
    }
    return true;
  }

  getLocationData() {
    location.onLocationChanged.listen((locationData) {
      print(locationData.latitude);
      print(locationData.longitude);
    });
  }

  Future<void> updateLocation() async {
    await checkAndRequestLocationService();

    bool hasPermission = await checkLocationPermission();
    if (hasPermission) {
      getLocationData();
    } else {
      // u don't have permission to get your current  location
    }
  }

// 1 request location service
// 2 request  location permission
// 3 get location
// 4 display location

// void initMarkers() async {
//   var markerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(
//         size: Size.fromHeight(250),
//       ),
//       "assets/images/marker2.png");
//
//   Set<Marker> myMarkers = places
//       .map(
//         (placeModel) => Marker(
//             icon: markerIcon,
//             infoWindow: InfoWindow(
//               title: placeModel.name,
//             ),
//             markerId: MarkerId(
//               placeModel.id.toString(),
//             ),
//             position: placeModel.latLng),
//       )
//       .toSet();
//   markers.addAll(myMarkers);
//   setState(() {});
// }
//
// void initPolyLines() async {
//   Polyline polyline = const Polyline(
//       polylineId: PolylineId("1"),
//       color: Colors.red,
//       points: [
//         LatLng(31.40129638076429, 31.814892553717076),
//         LatLng(31.40785290736025, 31.806051993642733),
//         LatLng(31.41261434343824, 31.81957032579525),
//         LatLng(31.413456726202956, 31.822102330865086),
//         LatLng(31.413786352182377, 31.79961469261772),
//       ],
//       width: 5,
//       zIndex: 1,
//       patterns: [PatternItem.dot]);
//   Polyline polyline2 = const Polyline(
//     polylineId: PolylineId("2"),
//     color: Colors.black,
//     points: [
//       LatLng(31.42565211641022, 31.81926991858101),
//       LatLng(31.424699980881698, 31.796739364993478),
//       LatLng(31.416240198428568, 31.793391968460472),
//       LatLng(31.408695333233467, 31.79300573039897),
//     ],
//     width: 5,
//     zIndex: 1,
//   );
//   polyLines.add(polyline);
//   polyLines.add(polyline2);
// }
//
// void initPolygons() async {
//   Polygon polygon = Polygon(
//     holes: const [
//       [
//         LatLng(31.419463062671756, 31.815493368646333),
//         LatLng(31.415397840657672, 31.821115278208175),
//         LatLng(31.412577718288038, 31.807382369354823),
//       ],
//       [
//         LatLng(31.406754080465102, 31.8157937760275),
//         LatLng(31.405655240344114, 31.804292464862815),
//         LatLng(31.409757511145504, 31.81931283392117),
//       ]
//     ],
//     strokeWidth: 3,
//     strokeColor: Colors.orange,
//     polygonId: const PolygonId("1"),
//     fillColor: Colors.black.withOpacity(0.5),
//     points: const [
//       LatLng(31.4410314276751, 31.81227471813383),
//       LatLng(31.397962999246047, 31.781547334574455),
//       LatLng(31.411149312277868, 31.864631433137248),
//     ],
//     zIndex: 1,
//   );
//
//   polygons.add(polygon);
// }
//
// void initCircle() async {
//   Circle circle = Circle(
//     circleId: CircleId("id"),
//     center: LatLng(31.4410314276751, 31.81227471813383),
//     fillColor: Colors.black.withOpacity(.5),
//     strokeColor: Colors.orange,
//     strokeWidth: 5,
//     radius: 1000,
//   );
//   circles.add(circle);
// }
}
