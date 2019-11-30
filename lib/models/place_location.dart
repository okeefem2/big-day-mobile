import 'package:big_day_mobile/helpers/location_helper.dart';
import 'package:flutter/material.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  PlaceLocation.fromJson(Map<String, dynamic> map)
      : assert(map['latitude'] != null),
        assert(map['longitude'] != null),
        assert(map['address'] != null),
        latitude = map['latitude'],
        longitude = map['longitude'],
        address = map['address'];

  static Future<PlaceLocation> fromLatLng({double lat, double long}) async {
    final address = await LocationHelper.getAddress(lat: lat, long: long);
    return PlaceLocation(latitude: lat, longitude: long, address: address);
  }
}
