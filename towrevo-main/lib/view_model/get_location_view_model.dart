import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/web_services/place_web_service.dart';

import '../utilities/utilities.dart';

// class GetLocationViewModel with ChangeNotifier {
//   PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
//   PlaceDetailModel myDestinationLocation = PlaceDetailModel.fromEmptyJson();
//   LatLng latLng = const LatLng(0.0, 0.0);
//   String address = '';

//   bool isLoading = false;
//   changeLoadingStatus(bool loadingStatus) {
//     isLoading = loadingStatus;
//     notifyListeners();
//   }

//   set setAddress(
//     String address,
//   ) {
//     myCurrentLocation.placeAddress = address;
//     notifyListeners();
//   }

//   String get getAddress => address;

//   updateMyLocation(context) {
//     if (placeDetailModel.placeAddress.isNotEmpty) {
//       myCurrentLocation = placeDetailModel;
//       notifyListeners();
//       Navigator.of(context).pop();
//     } else {
//       Fluttertoast.showToast(msg: "Please select a location");
//     }
//   }

//   updatDestinationLoaction(context) {
//     if (placeDetailModel.placeAddress.isNotEmpty) {
//       myDestinationLocation = placeDetailModel;
//       notifyListeners();
//       Navigator.of(context).pop();
//     } else {
//       Fluttertoast.showToast(msg: 'Please select a destination');
//     }
//   }

//   String get getMyAddress => myCurrentLocation.placeAddress;
//   String get getDestinationAddress => myDestinationLocation.placeAddress;

//   final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

//   Future<bool> _handlePermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission != LocationPermission.always) {
//       permission = await _geoLocatorPlatform.requestPermission();
//       if (permission == LocationPermission.always ||
//           permission == LocationPermission.whileInUse) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       return true;
//     }
//   }

//   Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//     List<Placemark> placeMarks = await placemarkFromCoordinates(
//         coordinate.latitude, coordinate.longitude);
//     final address = placeMarks.first;
//     myCurrentLocation.placeAddress = (address.street.toString() +
//             ', ' +
//             address.subLocality.toString() +
//             ', ' +
//             address.locality.toString() +
//             ', ' +
//             address.administrativeArea.toString() +
//             ', ' +
//             address.postalCode.toString() +
//             ', ' +
//             address.country.toString())
//         .replaceAll(', ,', ',');
//   }

//   final utilities = Utilities();

//   setLocalCoordinates(LatLng coordinate, String address) {
//     placeDetailModel = PlaceDetailModel(
//       placeAddress: getAddress,
//       placeLocation: coordinate,
//     );
//     utilities.setSharedPrefValue(
//       'longitude',
//       coordinate.longitude.toString(),
//     );
//     utilities.setSharedPrefValue(
//       'latitude',
//       coordinate.latitude.toString(),
//     );
//     utilities.setSharedPrefValue('address', address);
//     // notifyListeners();
//     getLocalCoordinates();
//   }

//   Future<void> getLocalCoordinates() async {
//     final longitude = await utilities.getSharedPreferenceValue('longitude');
//     final latitude = await utilities.getSharedPreferenceValue('latitude');
//     final address = await utilities.getSharedPreferenceValue('address');
//     placeDetailModel = PlaceDetailModel(
//       placeAddress: address.toString(),
//       placeLocation: LatLng(
//         double.parse(latitude.toString()),
//         double.parse(longitude.toString()),
//       ),
//     );
//   }

//   // Future<void> getCurrentLocation(BuildContext context) async {
//   //   changeLoadingStatus(true);
//   //   bool permission = await _handlePermission();
//   //   if (permission) {
//   //     final geoPosition = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high,
//   //     );
//   //     myCurrentLocation.placeLocation =
//   //         LatLng(geoPosition.latitude, geoPosition.longitude);
//   //     final registrationCompanyProvider =
//   //         Provider.of<RegisterCompanyViewModel>(context, listen: false);

//   //     registrationCompanyProvider.body['longitude'] =
//   //         myCurrentLocation.placeLocation.longitude.toString();
//   //     registrationCompanyProvider.body['latitude'] =
//   //         myCurrentLocation.placeLocation.latitude.toString();

//   //     await getLocationFromCoordinates(myCurrentLocation.placeLocation);
//   //   }
//   //   changeLoadingStatus(false);
//   // }

//   Future<void> getCurrentLocation(BuildContext context) async {
//     changeLoadingStatus(true);

//     bool permission = await _handlePermission();
//     if (permission) {
//       final geoPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//       // final registrationCompanyProvider =
//       //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//       await getLocationFromCoordinates(latLng);
//     }
//     // return null;
//     changeLoadingStatus(false);
//   }

//   Future<void> getStoreLocationIfExist(BuildContext context) async {
//     final longitude = await utilities.getSharedPreferenceValue('longitude');
//     // final latitude = await utilities.getSharedPreferenceValue('latitude');
//     // final address = await utilities.getSharedPreferenceValue('address');
//     // print('$longitude long');
//     // print('$latitude lat');
//     // print('$address address');
//     if (longitude == null) {
//       await getCurrentLocation(context);
//     }
//     if (longitude != null) {
//       await getLocalCoordinates();
//     }
//     notifyListeners();
//   }

//   setLatLng(LatLng latitudeAndLogitude) async {
//     myCurrentLocation.placeLocation = latitudeAndLogitude;
//     await getLocationFromCoordinates(latitudeAndLogitude);
//     notifyListeners();
//   }

//   List<PlacesModel> placesList = [];
//   PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
//   PlaceWebService placeWebService = PlaceWebService();

//   Future<void> getPlaces(String query) async {
//     if (!(await Utilities().isInternetAvailable())) {
//       return;
//     }
//     // print(query);
//     placesList = await placeWebService.getPlaces(query);
//     notifyListeners();
//   }

//   // Future<void> getPlaceDetail(String placeId) async {
//   //   placeDetailModel = await placeWebService.getPlaceDetail(placeId);
//   //   notifyListeners();
//   // }

//   Future<void> getPlaceDetail(String placeId) async {
//     final detailModel = await placeWebService.getPlaceDetail(placeId);
//     setLocalCoordinates(detailModel.placeLocation, detailModel.placeAddress);
//     notifyListeners();
//   }

//   DirectionsModel directionsModel = DirectionsModel.empty();

//   Future<void> getDirections(
//       {required LatLng origin, required LatLng destination}) async {
//     if (!(await Utilities().isInternetAvailable())) {
//       return;
//     }
//     final loadedData = await placeWebService.getDirectionsRequest(
//         origin: origin, destination: destination);
//     if (loadedData != null) {
//       directionsModel = loadedData;
//     }
//     notifyListeners();
//   }
// }

class GetLocationViewModel with ChangeNotifier {
  PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
  PlaceDetailModel myDestinationLocation = PlaceDetailModel.fromEmptyJson();
  LatLng latLng = const LatLng(0.0, 0.0);
  String address = '';

  // GetLocationViewModel(): longitude=0,latitude=0,address='';

  set setAddress(
    String address,
  ) {
    this.address = address;
    notifyListeners();
  }

  String get getAddress => address;

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  updateMyLocation(context, bool setValue) {
    if (placeDetailModel.placeAddress.isNotEmpty) {
      myCurrentLocation = placeDetailModel;
      if (setValue) {
        setLocalCoordinates(placeDetailModel);
      }
      notifyListeners();
      // Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: "Please select a location");
    }
  }

  updatDestinationLoaction(context) {
    if (placeDetailModel.placeAddress.isNotEmpty) {
      myDestinationLocation = placeDetailModel;
      notifyListeners();
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: 'Please select a destination');
    }
  }

  String get getMyAddress => myCurrentLocation.placeAddress;
  String get getDestinationAddress => myDestinationLocation.placeAddress;

  Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<void> getLocationFromCoordinates(LatLng coordinate) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final address = placeMarks.first;
    setAddress = address.street.toString() +
        ', ' +
        address.subLocality.toString() +
        ', ' +
        address.locality.toString() +
        ', ' +
        address.administrativeArea.toString() +
        ', ' +
        address.postalCode.toString() +
        ', ' +
        address.country.toString();
    setAddress = this.address.replaceAll(', ,', ',');

    // setLocalCoordinates(
    //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate));
  }

  setLocalCoordinates(PlaceDetailModel placeModel) async {
    // placeDetailModel = PlaceDetailModel(
    //   placeAddress: getAddress,
    //   placeLocation: coordinate,
    // );
    await utilities.setSharedPrefValue(
      'longitude',
      placeModel.placeLocation.longitude.toString(),
    );
    await utilities.setSharedPrefValue(
      'latitude',
      placeModel.placeLocation.latitude.toString(),
    );
    await utilities.setSharedPrefValue('address', placeModel.placeAddress);
    // notifyListeners();
    // getLocalCoordinates();
  }

  Future<void> getLocalCoordinates() async {
    final longitude = await utilities.getSharedPreferenceValue('longitude');
    final latitude = await utilities.getSharedPreferenceValue('latitude');
    final address = await utilities.getSharedPreferenceValue('address');

    myCurrentLocation = PlaceDetailModel(
      placeAddress: address.toString(),
      placeLocation: LatLng(
        double.parse(latitude.toString()),
        double.parse(longitude.toString()),
      ),
    );
    notifyListeners();
  }

  final utilities = Utilities();

  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    bool permission = await _handlePermission();
    if (permission) {
      final geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
      // final registrationCompanyProvider =
      //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

      await getLocationFromCoordinates(latLng);
      return latLng;
    }
    return null;
  }

  Future<void> getStoreLocationIfExist(BuildContext context) async {
    final longitude = await utilities.getSharedPreferenceValue('longitude');
    // final latitude = await utilities.getSharedPreferenceValue('latitude');
    // final address = await utilities.getSharedPreferenceValue('address');
    // print('$longitude long');
    // print('$latitude lat');
    // print('$address address');
    if (longitude == null) {
      LatLng currentCordinates =
          await getCurrentLocation(context) ?? const LatLng(0.0, 0.0);
      myCurrentLocation = PlaceDetailModel(
          placeAddress: getAddress, placeLocation: currentCordinates);
    }
    if (longitude != null) {
      await getLocalCoordinates();
    }
    notifyListeners();
  }

  setLatLng(LatLng latitudeAndLogitude) async {
    latLng = latitudeAndLogitude;
    await getLocationFromCoordinates(latitudeAndLogitude);
    notifyListeners();
  }

  List<PlacesModel> placesList = [];
  PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  PlaceWebService placeWebService = PlaceWebService();

  Future<void> getPlaces(String query) async {
    // if (!(await Utilities().isInternetAvailable())) {
    //   return;
    // }
    placesList = await placeWebService.getPlaces(query);
    notifyListeners();
  }

//cleared function
  Future<void> getPlaceDetail(String placeId) async {
    placeDetailModel = await placeWebService.getPlaceDetail(placeId);
    // print(placeDetailModel.placeAddress);
    notifyListeners();
  }
}
