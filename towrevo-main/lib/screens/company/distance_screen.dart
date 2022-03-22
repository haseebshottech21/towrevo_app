import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/towrevo_appcolor.dart';
import 'package:towrevo/view_model/view_model.dart';

class DistanceScreen extends StatefulWidget {
  static String a = '';
  static const routeName = '/map-distance';
  const DistanceScreen({Key? key}) : super(key: key);

  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  GoogleMapController? mapController;
  double originLatitude = 24.7436, originLongitude = 69.8061;
  double destLatitude = 24.7014, destLongitude = 70.1783;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBgeFPOQMiMVVrElHYD5l5YSCmNlu8QFXI";
  String totalDistanceAndDuration = "";

  @override
  void initState() {
    super.initState();
  }

  bool init = true;

  @override
  void didChangeDependencies() {
    if (init) {
      locationViewModel =
          Provider.of<GetLocationViewModel>(context, listen: false);
      originLatitude =
          locationViewModel!.myCurrentLocation.placeLocation.latitude;
      originLongitude =
          locationViewModel!.myCurrentLocation.placeLocation.longitude;
      final args = ModalRoute.of(context)!.settings.arguments as LatLng;
      destLatitude = args.latitude;
      destLongitude = args.longitude;

      _addMarker(LatLng(originLatitude, originLongitude), "origin",
          BitmapDescriptor.defaultMarker);

      /// destination marker
      _addMarker(LatLng(destLatitude, destLongitude), "destination",
          BitmapDescriptor.defaultMarkerWithHue(90));
      _getPolyline(locationViewModel!);
      init = false;
    }
    super.didChangeDependencies();
  }

  GetLocationViewModel? locationViewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          actions: [
            TextButton(
              onPressed: () {
                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(originLatitude, originLongitude),
                      tilt: 50.0,
                      zoom: 14.5,
                    ),
                  ),
                );
              },
              child: Text(
                'ORIGIN',
                style: TextStyle(color: AppColors.primaryColor2),
              ),
            ),
            TextButton(
              onPressed: () {
                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(destLatitude, destLongitude),
                      tilt: 50.0,
                      zoom: 14.5,
                    ),
                  ),
                );
              },
              child: Text(
                'DESTINATION',
                style: TextStyle(color: AppColors.primaryColor2),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(originLatitude, originLongitude), zoom: 15),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            // if (totalDistanceAndDuration.isNotEmpty)
            //   Positioned(
            //     top: 20,
            //     // left: 20,
            //     child: Container(
            //       alignment: Alignment.center,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            //       decoration: BoxDecoration(
            //         color: Colors.yellow.shade300,
            //         borderRadius: BorderRadius.circular(20.0),
            //       ),
            //       child: Text(
            //         'totalDistanceAndDuration',
            //         style: const TextStyle(
            //             fontSize: 19.0, fontWeight: FontWeight.w600),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      infoWindow: InfoWindow(
        title: id.toUpperCase(),
      ),
    );
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(GetLocationViewModel mapViewModel) async {
    // await mapViewModel.getDirections(
    //     origin: LatLng(originLatitude, originLongitude),
    //     destination: LatLng(originLatitude, destLongitude));

    // if (mapViewModel.directionsModel.polylinePoints.isNotEmpty) {
    //   mapViewModel.directionsModel.polylinePoints.forEach((PointLatLng point) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   });
    // }

    _addPolyLine();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
    );
    print(result);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      totalDistanceAndDuration = result.status!;
    }
    _addPolyLine();
  }
}
