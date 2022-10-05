import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../models/place_detail_model.dart';
import '../../utilities/towrevo_appcolor.dart';
import '../../view_model/get_location_view_model.dart';

class CompanyLocationScreen extends StatefulWidget {
  const CompanyLocationScreen({Key? key}) : super(key: key);

  static const routeName = '/company-location-screen';

  @override
  State<CompanyLocationScreen> createState() => _CompanyLocationScreenState();
}

class _CompanyLocationScreenState extends State<CompanyLocationScreen> {
  final textSearchController = TextEditingController();

  bool init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      final placeProvider = Provider.of<GetLocationViewModel>(context);
      placeProvider.placeDetailModel = PlaceDetailModel.fromEmptyJson();
      placeProvider.placesList.clear();
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final placeViewModel = context.watch<GetLocationViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: placeViewModel.placeDetailModel.placeAddress.isNotEmpty
          ? Container(
              height: size.height * 0.16,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 16, right: 16),
                    child: Text(
                      placeViewModel.placeDetailModel.placeAddress,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                    child: GestureDetector(
                      onTap: () {
                        placeViewModel.updateMyLocation(context, false);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Center(
                            child: Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8, right: 25, left: 25),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.white),
                  //     ),
                  //     child: TextButton(
                  //       onPressed: () {
                  //         placeViewModel.updateMyLocation(context, false);
                  //         // if (placeViewModel
                  //         //     .placeDetailModel.placeAddress.isNotEmpty) {
                  //         Navigator.of(context).pop();
                  //         // }
                  //       },
                  //       style: TextButton.styleFrom(
                  //         padding: const EdgeInsets.only(
                  //           right: 25,
                  //           left: 25,
                  //         ),
                  //       ),
                  //       child: const Text(
                  //         'SAVE',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          : const SizedBox(),
      body: Stack(
        children: [
          // const Expanded(
          //   child: Gmap(),
          // ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Gmap(),
              ),
            ),
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
                      // placeViewModel.getPlaceDetail(
                      //   placeViewModel.placesList[index].placeId,
                      // );
                      context.read<GetLocationViewModel>().getPlaceDetail(
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
        // buildingsEnabled: true,
        // mapToolbarEnabled: false,
        // myLocationEnabled: true,
        // zoomControlsEnabled: true,
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
