import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/place_detail_model.dart';
import 'package:towrevo/models/places_model.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';
import 'package:towrevo/web_services/place_web_service.dart';

class GetLocationViewModel with ChangeNotifier {
  // LatLng latLng = const LatLng(0.0, 0.0);
  // String address = '';

  PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
  PlaceDetailModel myDestinationLocation = PlaceDetailModel.fromEmptyJson();

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  // GetLocationViewModel(): longitude=0,latitude=0,address='';

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
      print('Address is Empty');
    }
  }

  updatDestinationLoaction(context) {
    if (placeDetailModel.placeAddress.isNotEmpty) {
      myDestinationLocation = placeDetailModel;
      notifyListeners();
      Navigator.of(context).pop();
    } else {
      print('Address is Empty');
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
    print(placeMarks.first);
  }

  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    changeLoadingStatus(true);
    bool permission = await _handlePermission();
    if (permission) {
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      myCurrentLocation.placeLocation =
          LatLng(geoPosition.latitude, geoPosition.longitude);
      final registrationCompanyProvider =
          Provider.of<RegisterCompanyViewModel>(context, listen: false);

      // if (latLng != null) {
      registrationCompanyProvider.body['longitude'] =
          myCurrentLocation.placeLocation.longitude.toString();
      registrationCompanyProvider.body['latitude'] =
          myCurrentLocation.placeLocation.latitude.toString();
      await getLocationFromCoordinates(myCurrentLocation.placeLocation);
      // }
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
    print(query);
    placesList = await placeWebService.getPlaces(query);
    notifyListeners();
  }

  Future<void> getPlaceDetail(String placeId) async {
    placeDetailModel = await placeWebService.getPlaceDetail(placeId);
    notifyListeners();
  }
}
