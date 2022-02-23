import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';

class MapDistanceScreen extends StatefulWidget {
  static const routeName = '/map-distance-screen';
  const MapDistanceScreen({Key? key}) : super(key: key);

  @override
  _MapDistanceScreenState createState() => _MapDistanceScreenState();
}

class _MapDistanceScreenState extends State<MapDistanceScreen> {
  GoogleMapController? _googleMapController;

  Marker? _origin;
  Marker? _destination;

  @override
  Widget build(BuildContext context) {
    final locationViewModelProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    final destLatLng = ModalRoute.of(context)!.settings.arguments as LatLng;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          TextButton(
            onPressed: () {
              _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                      target: _origin!.position, tilt: 50.0, zoom: 14.5)));
            },
            child: const Text('ORIGIN'),
            style: TextButton.styleFrom(
              primary: Colors.blue,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                      target: _destination!.position, tilt: 50.0, zoom: 14.5)));
            },
            child: const Text('DESTINATION'),
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: locationViewModelProvider.latLng,
          zoom: 17,
        ),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) {
          _googleMapController = controller;
          _setMarker(
              originPos: locationViewModelProvider.latLng, destPos: destLatLng);
        },
        markers: {
          if (_origin != null) _origin!,
          if (_destination != null) _destination!
        },
        // onLongPress: _addMarker,
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  void _setMarker({required LatLng originPos, required LatLng destPos}) {
    print('in to set');
    _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow:
            const InfoWindow(title: 'Origin', snippet: 'Your Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: originPos);
    _destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow:
          const InfoWindow(title: 'Destination', snippet: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: destPos,
    );

    print(originPos);
    print(destPos);
    setState(() {
      print('there');
    });
  }
}
