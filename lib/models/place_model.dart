import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;

  final String name;

  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: "مطعم ماكدونالدز دمياط",
      latLng: const LatLng(31.421953381564116, 31.81218888728658)),
  PlaceModel(
      id: 2,
      name: "الصفوة مول",
      latLng: const LatLng(31.4152879668461, 31.79588105778707)),
  PlaceModel(
      id: 3,
      name: "مطعم باب الحارة دمياط القديمة",
      latLng: const LatLng(31.411405693943994, 31.81914117215744)),
];
