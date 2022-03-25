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
  bool fromCompanyToPickupLocation = true;

  GoogleMapController? mapController;
  bool dropoff = false;
  double compOriginLatitude = 0.0, compOriginLongitude = 0.0;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBgeFPOQMiMVVrElHYD5l5YSCmNlu8QFXI";
  String totalDistanceAndDuration = "";

  Map<String, LatLng> locationRoute = {
    'origin': const LatLng(0.0, 0.0),
    // 'destination': const LatLng(0.0, 0.0),
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
      compOriginLongitude =
          double.parse(await Utilities().getSharedPreferenceValue('longitude'));
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, LatLng>;

      locationRoute = args;

      _getPolyline(
          locationViewModel!,
          LatLng(compOriginLatitude, compOriginLongitude),
          LatLng(locationRoute['origin']!.latitude,
              locationRoute['origin']!.longitude));
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
                if (fromCompanyToPickupLocation) {
                  animateTo(LatLng(compOriginLatitude, compOriginLongitude));
                } else {
                  animateTo(LatLng(locationRoute['origin']!.latitude,
                      locationRoute['origin']!.longitude));
                }
              },
              child: Text(
                'ORIGIN',
                style: TextStyle(color: AppColors.primaryColor2),
              ),
            ),
            TextButton(
              onPressed: () {
                if (fromCompanyToPickupLocation) {
                  animateTo(LatLng(locationRoute['origin']!.latitude,
                      locationRoute['origin']!.longitude));
                } else {
                  animateTo(LatLng(locationRoute['destination']!.latitude,
                      locationRoute['destination']!.longitude));
                }
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
            if (locationRoute['destination'] != null)
              Positioned(
                left: 95,
                right: 95,
                bottom: 12,
                // left: 20,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    primary: AppColors.primaryColor,
                  ),
                  icon: const Icon(Icons.directions),
                  label: Text(!fromCompanyToPickupLocation
                      ? 'DropOff Location'
                      : 'PickUp Location'),
                  onPressed: () {
                    setState(() => fromCompanyToPickupLocation =
                        !fromCompanyToPickupLocation);
                    if (fromCompanyToPickupLocation) {
                      _getPolyline(
                        locationViewModel!,
                        LatLng(compOriginLatitude, compOriginLongitude),
                        LatLng(locationRoute['origin']!.latitude,
                            locationRoute['origin']!.longitude),
                      );
                    } else {
                      _getPolyline(
                        locationViewModel!,
                        LatLng(locationRoute['origin']!.latitude,
                            locationRoute['origin']!.longitude),
                        LatLng(locationRoute['destination']!.latitude,
                            locationRoute['destination']!.longitude),
                      );
                    }
                  },
                ),
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

  _getPolyline(GetLocationViewModel mapViewModel, LatLng originLatlng,
      LatLng destLatlng) async {
    polylineCoordinates.clear();
    addMarkers(originLatlng, destLatlng);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(originLatlng.latitude, originLatlng.longitude),
      PointLatLng(destLatlng.latitude, destLatlng.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      totalDistanceAndDuration = result.status!;
    }
    animateTo(originLatlng);
    _addPolyLine();
  }

  animateTo(LatLng latLng) {
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          tilt: 50.0,
          zoom: 12.5,
        ),
      ),
    );
  }

  addMarkers(LatLng origin, LatLng destination) {
    _addMarker(origin, "origin", BitmapDescriptor.defaultMarker);
    _addMarker(
        destination, "destination", BitmapDescriptor.defaultMarkerWithHue(90));
  }
}
