import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/models/models.dart';
import 'package:http/http.dart' as http;

import '../utilities/env_settings.dart';

class PlaceWebService {
  Future<List<PlacesModel>> getPlaces(String query) async {
    try {
      List<PlacesModel> placesList = [];
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${ENVSettings.mapAPIKey}&input=$query'),
      );

      final loadedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        placesList = (loadedData['predictions'] as List)
            .map((place) => PlacesModel.fromJson(place))
            .toList();
        return placesList;
      } else {
        return placesList;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<PlaceDetailModel> getPlaceDetail(String placeId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?key=${ENVSettings.mapAPIKey}&place_id=$placeId'),
      );

      final loadedData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final placeDetail = PlaceDetailModel.fromJson(loadedData['result']);
        return placeDetail;
      } else {
        return PlaceDetailModel.fromEmptyJson();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return PlaceDetailModel.fromEmptyJson();
    }
  }

  Future<DirectionsModel?> getDirectionsRequest({
    required LatLng origin,
    required LatLng destination,
    TravelMode travelMode = TravelMode.driving,
    List<PolylineWayPoint> wayPoints = const [],
    bool avoidHighways = false,
    bool avoidTolls = false,
    bool avoidFerries = true,
    bool optimizeWaypoints = false,
  }) async {
    try {
      String mode = travelMode.toString().replaceAll('TravelMode.', '');
      final params = {
        "origin": "${origin.latitude},${origin.longitude}",
        "destination": "${destination.latitude},${destination.longitude}",
        "mode": mode,
        "avoidHighways": "$avoidHighways",
        "avoidFerries": "$avoidFerries",
        "avoidTolls": "$avoidTolls",
        "key": ENVSettings.mapAPIKey,
      };

      if (wayPoints.isNotEmpty) {
        List wayPointsArray = [];
        for (var point in wayPoints) {
          wayPointsArray.add(point.location);
        }
        String wayPointsString = wayPointsArray.join('|');
        if (optimizeWaypoints) {
          wayPointsString = 'optimize:true|$wayPointsString';
        }
        params.addAll({"waypoints": wayPointsString});
      }
      Uri uri =
          Uri.https("maps.googleapis.com", "maps/api/directions/json", params);

      final response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body);

        if (parsedJson["status"].toString().toLowerCase() == 'ok' &&
            parsedJson["routes"] != null &&
            (parsedJson["routes"] as List).isNotEmpty) {
          final placeDetail = DirectionsModel.fromMap(parsedJson);
          return placeDetail;
        } else {
          Fluttertoast.showToast(msg: parsedJson["error_message"]);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
