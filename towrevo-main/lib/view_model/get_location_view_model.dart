import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';

class GetLocationViewModel with ChangeNotifier {
  LatLng latLng = const LatLng(0.0, 0.0);
  String address = '';

  bool isLoading = false;
  changeLoadingStatus(bool loadingStatus) {
    isLoading = loadingStatus;
    notifyListeners();
  }

  // GetLocationViewModel(): longitude=0,latitude=0,address='';

  set setAddress(
    String address,
  ) {
    this.address = address;
    notifyListeners();
  }

  String get getAddress => address;

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
    print(placeMarks.first);
  }

  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    changeLoadingStatus(true);
    bool permission = await _handlePermission();
    if (permission) {
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
      final registrationCompanyProvider =
          Provider.of<RegisterCompanyViewModel>(context, listen: false);

      // if (latLng != null) {
      registrationCompanyProvider.body['longitude'] =
          latLng.longitude.toString();
      registrationCompanyProvider.body['latitude'] = latLng.latitude.toString();
      await getLocationFromCoordinates(latLng);
      // }
    }
    changeLoadingStatus(false);
  }

  setLatLng(LatLng latitudeAndLogitude) async {
    latLng = latitudeAndLogitude;
    await getLocationFromCoordinates(latitudeAndLogitude);
    notifyListeners();
  }
}
