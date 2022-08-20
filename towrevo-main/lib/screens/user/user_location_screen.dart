import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/place_detail_model.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight,
            width: double.infinity,
            // width: ScreenUtil().screenWidth,
            child: const Gmap(),
          ),
          if (placeViewModel.placesList.isNotEmpty &&
              textSearchController.text.isNotEmpty)
            Container(
              margin: EdgeInsets.only(
                top: 90.h,
                left: 20.w,
                right: 20.w,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.r),
              ),
              width: double.infinity,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shrinkWrap: true,
                itemCount: placeViewModel.placesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      textSearchController.clear();
                      placeViewModel.getPlaceDetail(
                        placeViewModel.placesList[index].placeId,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 0.5.w,
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
                            SizedBox(width: 8.w),
                            SizedBox(
                              width: ScreenUtil().screenWidth * 0.7,
                              child: Text(
                                placeViewModel.placesList[index].description,
                                style: TextStyle(
                                  fontSize: 13.sp,
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
              ),
            ),
          Positioned(
            top: 25.h,
            right: 20.w,
            left: 20.w,
            child: SizedBox(
              height: 80.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 38.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5.r),
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
            bottom: 25.h,
            right: 15.w,
            left: 15.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Container(
                width: ScreenUtil().screenWidth * 0.80,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: kElevationToShadow[10],
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.1, 0.8],
                    colors: [
                      Color(0xFF0195f7),
                      Color(0xFF083054),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    shadowColor: Colors.transparent,
                    primary: Colors.transparent,
                    minimumSize: Size(
                      ScreenUtil().screenWidth * 0.80,
                      35.h,
                    ),
                  ),
                  onPressed: () {
                    if (reqFromMyLocation) {
                      placeViewModel.updateMyLocation(context);
                    } else {
                      placeViewModel.updatDestinationLoaction(context);
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                ),
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
