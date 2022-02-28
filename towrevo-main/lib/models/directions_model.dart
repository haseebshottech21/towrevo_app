import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  DirectionsModel({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    // if ((map['routes'] as List).isEmpty)

    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    String distance = data['legs'][0]['distance']['text'];
    String duration = data['legs'][0]['duration']['text'];
    print(data['overview_polyline']);
    return DirectionsModel(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
  //empty direction model
  factory DirectionsModel.empty() {
    return DirectionsModel(
      bounds: LatLngBounds(
        northeast: const LatLng(0, 0),
        southwest: const LatLng(0, 0),
      ),
      polylinePoints: [],
      totalDistance: '',
      totalDuration: '',
    );
  }
}
