import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/towrevo_appcolor.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';

class DistanceScreen extends StatefulWidget {
  static String a = '';
  static const routeName = '/map-distance';
  const DistanceScreen({Key? key}) : super(key: key);

  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  String buttonText = "Pickup - DropOff";

  GoogleMapController? mapController;
  bool dropoff = false;
  double compOriginLatitude = 0.0, compOriginLongitude = 0.0;
  double userPickLatitude = 24.7014, userPickLongitude = 70.1783;
  double userDestLatitude = 24.7014, userDestLongitude = 70.1783;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBgeFPOQMiMVVrElHYD5l5YSCmNlu8QFXI";
  String totalDistanceAndDuration = "";

  Map<String, LatLng> locationRoute = {
    'Origin': const LatLng(0.0, 0.0),
    'Destination': const LatLng(0.0, 0.0),
  };

  @override
  void initState() {
    super.initState();
  }

  bool init = true;

  @override
  void didChangeDependencies() async {
    if (init) {
      locationViewModel =
          Provider.of<GetLocationViewModel>(context, listen: false);
      compOriginLatitude =
          double.parse(await Utilities().getSharedPreferenceValue('latitude'));
      // print(await Utilities().getSharedPreferenceValue('longitude'));
      compOriginLongitude =
          double.parse(await Utilities().getSharedPreferenceValue('longitude'));
      final args = ModalRoute.of(context)!.settings.arguments as LatLng;
      userPickLatitude = args.latitude;
      userPickLongitude = args.longitude;
      // locationRoute = args;

      // company loaction marker
      _addMarker(LatLng(compOriginLatitude, compOriginLongitude), "origin",
          BitmapDescriptor.defaultMarker);

      /// user pick locaion marker
      _addMarker(LatLng(userPickLatitude, userPickLongitude), "destination",
          BitmapDescriptor.defaultMarkerWithHue(90));

      // _addMarker(
      //   LatLng(
      //     locationRoute['Origin']!.latitude,
      //     locationRoute['Origin']!.longitude,
      //   ),
      //   "destination",
      //   BitmapDescriptor.defaultMarkerWithHue(90),
      // );

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
                      target: LatLng(compOriginLatitude, compOriginLongitude),
                      tilt: 50.0,
                      zoom: 12.5,
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
                      target: LatLng(userPickLatitude, userPickLongitude),
                      tilt: 50.0,
                      zoom: 12.5,
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
                target: LatLng(compOriginLatitude, compOriginLongitude),
                zoom: 15,
              ),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            if (totalDistanceAndDuration.isNotEmpty)
              Positioned(
                left: 80,
                right: 80,
                top: 5,
                // left: 20,
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    totalDistanceAndDuration,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 100,
              right: 100,
              bottom: 10,
              // left: 20,
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions),
                  label: Text(buttonText),
                  onPressed: () {
                    setState(() {
                      if (buttonText == "Pickup - DropOff") {
                        buttonText = "Company - Pickup";
                      }
                      // else if (buttonText == "Company - Pickup") {
                      //   buttonText = "Pickup - DropOff";
                      // }
                    });
                  }),
            ),
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
      PointLatLng(compOriginLatitude, compOriginLongitude),
      PointLatLng(userPickLatitude, userPickLongitude),
    );
    print(result);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      totalDistanceAndDuration = result.status!;
    }
    if (compOriginLatitude != 0.0) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(compOriginLatitude, compOriginLongitude),
            tilt: 50.0,
            zoom: 12.5,
          ),
        ),
      );
    }
    _addPolyLine();
  }
}
