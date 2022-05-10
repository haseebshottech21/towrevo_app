import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/models.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/web_services/place_web_service.dart';

import '../utilities/utilities.dart';

class GetLocationViewModel with ChangeNotifier {
  PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
  PlaceDetailModel myDestinationLocation = PlaceDetailModel.fromEmptyJson();

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  set setAddress(
    String address,
  ) {
    myCurrentLocation.placeAddress = address;
    notifyListeners();
  }

  updateMyLocation(context) {
    if (placeDetailModel.placeAddress.isNotEmpty) {
      myCurrentLocation = placeDetailModel;
      notifyListeners();
      Navigator.of(context).pop();
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

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

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
        coordinate.latitude, coordinate.longitude);
    final address = placeMarks.first;
    myCurrentLocation.placeAddress = (address.street.toString() +
            ', ' +
            address.subLocality.toString() +
            ', ' +
            address.locality.toString() +
            ', ' +
            address.administrativeArea.toString() +
            ', ' +
            address.postalCode.toString() +
            ', ' +
            address.country.toString())
        .replaceAll(', ,', ',');
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    changeLoadingStatus(true);
    bool permission = await _handlePermission();
    if (permission) {
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      myCurrentLocation.placeLocation =
          LatLng(geoPosition.latitude, geoPosition.longitude);
      final registrationCompanyProvider =
          Provider.of<RegisterCompanyViewModel>(context, listen: false);

      registrationCompanyProvider.body['longitude'] =
          myCurrentLocation.placeLocation.longitude.toString();
      registrationCompanyProvider.body['latitude'] =
          myCurrentLocation.placeLocation.latitude.toString();
      await getLocationFromCoordinates(myCurrentLocation.placeLocation);
    }
    changeLoadingStatus(false);
  }

  setLatLng(LatLng latitudeAndLogitude) async {
    myCurrentLocation.placeLocation = latitudeAndLogitude;
    await getLocationFromCoordinates(latitudeAndLogitude);
    notifyListeners();
  }

  List<PlacesModel> placesList = [];
  PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  PlaceWebService placeWebService = PlaceWebService();

  Future<void> getPlaces(String query) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    // print(query);
    placesList = await placeWebService.getPlaces(query);
    notifyListeners();
  }

  Future<void> getPlaceDetail(String placeId) async {
    placeDetailModel = await placeWebService.getPlaceDetail(placeId);
    notifyListeners();
  }

  DirectionsModel directionsModel = DirectionsModel.empty();

  Future<void> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    if (!(await Utilities().isInternetAvailable())) {
      return;
    }
    final loadedData = await placeWebService.getDirectionsRequest(
        origin: origin, destination: destination);
    if (loadedData != null) {
      directionsModel = loadedData;
    }
    notifyListeners();
  }
}
