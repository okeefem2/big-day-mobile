import 'package:http/http.dart';
import 'google_maps_config.dart';
import 'dart:convert';

class LocationHelper {
  static String generateLocationPreviewImage({lat: double, long: double}) {
    final apiKey = GoogleMapsConfig.GOOGLE_MAPS_API_KEY;
    final baseUrl = GoogleMapsConfig.GOOGLE_MAPS_BASE_URL;
    return '$baseUrl$lat,$long&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$long&key=$apiKey';
  }

  static Future<String> getAddress({lat: double, long: double}) async {
    final baseUrl = GoogleMapsConfig.GEOCODING_URL_BASE;
    final key = 'key=${GoogleMapsConfig.GOOGLE_MAPS_API_KEY}';
    final url =
        '$baseUrl/json?latlng=$lat,$long&key=${GoogleMapsConfig.GOOGLE_MAPS_API_KEY}';
    final response = await get(url);
    // returns all addresses that match ordered by relevance
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
