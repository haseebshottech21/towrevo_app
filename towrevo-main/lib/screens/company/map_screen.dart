import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/directions_model.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? _originMarker;
  Marker? _destinationMarker;
  DirectionsModel? info;

  static const _initialCamperPosition =
      CameraPosition(target: LatLng(25.3960, 68.357), zoom: 11.5);
  @override
  Widget build(BuildContext context) {
    final mapViewModel =
        Provider.of<GetLocationViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_originMarker != null)
            TextButton(
              onPressed: () {
                _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _originMarker!.position,
                      tilt: 50.0,
                      zoom: 14.5,
                    ),
                  ),
                );
              },
              child: const Text('ORIGIN'),
            ),
          if (_destinationMarker != null)
            TextButton(
              onPressed: () {
                _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _destinationMarker!.position,
                      tilt: 50.0,
                      zoom: 14.5,
                    ),
                  ),
                );
              },
              child: const Text('DESTINATION'),
            ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            polylines: {
              if (info != null)
                Polyline(
                  points: info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                  color: Colors.red,
                  width: 5,
                  polylineId: const PolylineId('overview_polyline'),
                ),
            },
            onLongPress: (latlng) => _addMarker(latlng, mapViewModel),
            // zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: _initialCamperPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_originMarker != null) _originMarker!,
              if (_destinationMarker != null) _destinationMarker!,
            },
          ),
          if (info != null)
            Positioned(
              top: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        spreadRadius: 6.0,
                      ),
                    ]),
                child: Text(
                  '${info!.totalDistance}, ${info!.totalDuration}',
                  style: const TextStyle(
                      fontSize: 19.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController!.animateCamera(
          info != null
              ? CameraUpdate.newLatLngBounds(info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCamperPosition),
        ),
        child: const Icon(Icons.directions),
      ),
    );
  }

  _addMarker(LatLng latLng, GetLocationViewModel mapViewModel) async {
    if (_originMarker == null ||
        (_originMarker != null && _destinationMarker != null)) {
      setState(() {
        _originMarker = Marker(
          markerId: const MarkerId('origin'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );
      });
      _destinationMarker = null;
      info = null;
    } else {
      setState(() {
        _destinationMarker = Marker(
          markerId: const MarkerId('destination'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      });

      await mapViewModel.getDirections(
          origin: _originMarker!.position,
          destination: _destinationMarker!.position);

     
    }
  }

  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }
}
