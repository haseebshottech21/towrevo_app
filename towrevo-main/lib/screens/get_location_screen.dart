import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';

class GetLocationScreen extends StatefulWidget {
  static const routeName = '/get-location';
  static Map<String, double> latLng = {'lat': 0.0, 'lng': 0.0};

  const GetLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  GoogleMapController? _googleMapController;

  Marker? _origin;
  @override
  Widget build(BuildContext context) {
    final locationViewModelProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: locationViewModelProvider.latLng!, zoom: 9),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) {
          _googleMapController = controller;
          _addMarker(locationViewModelProvider.latLng!);
        },
        markers: {if (_origin != null) _origin!},
        onLongPress: _addMarker,
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: locationViewModelProvider.latLng!,
              ),
            ),
          );
          _addMarker(locationViewModelProvider.latLng!);
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  void _addMarker(LatLng pos) {
    _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos);
    Provider.of<GetLocationViewModel>(context, listen: false).setLatLng(pos);
    print(_origin!.position);
    setState(() {});
  }
}
