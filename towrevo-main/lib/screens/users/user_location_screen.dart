import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/place_detail_model.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';

class UserLocationScreen extends StatefulWidget {
  static const routeName = '/location-screen';
  const UserLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  final textSearchController = TextEditingController();

  bool init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      final placeProvider = Provider.of<GetLocationViewModel>(
        context,
      );
      placeProvider.placeDetailModel = PlaceDetailModel.fromEmptyJson();
      placeProvider.placesList.clear();
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reqFromMyLocation =
        ModalRoute.of(context)!.settings.arguments as bool;
    final placeViewModel =
        Provider.of<GetLocationViewModel>(context, listen: true);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Location'),
      // ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: const Gmap(),
          ),
          if (placeViewModel.placesList.isNotEmpty &&
              textSearchController.text.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
              // decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print(placeViewModel.placesList[index].placeId);
                          textSearchController.clear();
                          placeViewModel.getPlaceDetail(
                            placeViewModel.placesList[index].placeId,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            // color: Colors.yellow,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    placeViewModel
                                        .placesList[index].description,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: placeViewModel.placesList.length),
              ),
            ),
          Positioned(
            top: 40,
            right: 20,
            left: 20,
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: LocationSearchBox(
                      searchController: textSearchController,
                      onChange: placeViewModel.getPlaces,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 15,
            left: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                ),
                onPressed: () {
                  if (reqFromMyLocation) {
                    placeViewModel.updateMyLocation(context);
                  } else {
                    placeViewModel.updatDestinationLoaction(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Gmap extends StatefulWidget {
  const Gmap({
    Key? key,
  }) : super(key: key);

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    final placeViewModel =
        Provider.of<GetLocationViewModel>(context, listen: true);
    if (placeViewModel.placeDetailModel.placeAddress.isNotEmpty) {
      animate(placeViewModel.placeDetailModel.placeLocation);
      _addMarker(placeViewModel.placeDetailModel.placeLocation);
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        onMapCreated: (controller) {
          _googleMapController = controller;
          animate(placeViewModel.placeDetailModel.placeLocation);
        },
        markers: {
          if (marker != null) marker!,
        },
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: placeViewModel.placeDetailModel.placeLocation,
          zoom: 15,
        ),
      ),
    );
  }

  Marker? marker;

  void _addMarker(LatLng pos) {
    marker = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos);
  }

  animate(LatLng latlng) {
    _googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 15),
      ),
    );
  }
}

class LocationSearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final Function onChange;
  const LocationSearchBox({
    required this.searchController,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        onChanged: (val) => onChange(val),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter Your Location',
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
