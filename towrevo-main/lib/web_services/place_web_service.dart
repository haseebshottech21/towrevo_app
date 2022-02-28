import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/models/directions_model.dart';
import 'package:towrevo/models/place_detail_model.dart';
import 'package:towrevo/models/places_model.dart';

import 'package:http/http.dart' as http;

class PlaceWebService {
  final String key = "AIzaSyBgeFPOQMiMVVrElHYD5l5YSCmNlu8QFXI";
  Future<List<PlacesModel>> getPlaces(String query) async {
    List<PlacesModel> placesList = [];
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$key&input=$query'),
    );
    print(response.body);
    final loadedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      placesList = (loadedData['predictions'] as List)
          .map((place) => PlacesModel.fromJson(place))
          .toList();
      return placesList;
    } else {
      return placesList;
    }
  }

  Future<PlaceDetailModel> getPlaceDetail(String placeId) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId'),
    );
    print(response.body);
    final loadedData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final placeDetail = PlaceDetailModel.fromJson(loadedData['result']);
      return placeDetail;
    } else {
      return PlaceDetailModel.fromEmptyJson();
    }
  }

  Future<DirectionsModel?> getDirectionsRequest(
      {required LatLng origin, required LatLng destination}) async {
    print('$origin , $destination');

    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?key=$key&destination=${destination.latitude.toString()},${destination.longitude.toString()}&origin=${destination.latitude.toString()},${destination.longitude.toString()}'),
    );
    print(response.body);
    final loadedData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final placeDetail = DirectionsModel.fromMap(loadedData);
      return placeDetail;
    }
  }
}
