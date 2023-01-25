import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestLocation extends StatefulWidget {
  static const routeName = '/test-location';

  const TestLocation({Key? key}) : super(key: key);

  @override
  State<TestLocation> createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  GoogleMapController? mapController;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Place Search Autocomplete Google Map"),
      //   backgroundColor: Colors.deepPurpleAccent,
      // ),
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              mapType: MapType.normal, //map type
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Expanded(child: LocationTextField()),
          ),
        ],
      ),
    );
  }
}

class LocationTextField extends StatelessWidget {
  // final TextEditingController searchController;
  // final Function onChange;
  const LocationTextField({
    // required this.searchController,
    // required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        // controller: searchController,
        // onChanged: (val) => onChange(val),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter Your Location',
          suffixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.only(left: 15.w, bottom: 5.h, right: 5.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
