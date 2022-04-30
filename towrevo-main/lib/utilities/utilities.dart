import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Utilities {
  Future<Map<String, String>?> setTimer(BuildContext context) async {
    try {
      TimeRange result = await showTimeRangePicker(
        context: context,
        use24HourFormat: false,
        disabledTime: TimeRange(
          startTime: const TimeOfDay(hour: 23, minute: 55),
          endTime: const TimeOfDay(hour: 0, minute: 05),
        ),
        minDuration: const Duration(hours: 3),
        // start: TimeOfDay(hour: hour, minute: minute)
      );

      if (result != null) {
        return {
          'fromUtilize': result.startTime.format(context).toString(),
          'toUtilize': result.endTime.format(context).toString(),
          'from': timeConverter(result.startTime.format(context)),
          'to': timeConverter(result.endTime.format(context)),
        };
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //12 to 24
  String timeConverter(String datee) {
    DateTime date = DateFormat.jm().parse(datee);
    // DateTime date2= DateFormat("hh:mma").parse("6:45PM"); // think this will work better for you

    // format date 12 to 24

    // print(DateFormat("HH:mm").format(date2));
    return DateFormat("HH:mm").format(date);
  }

  static const stripeBaseUrl = 'https://api.stripe.com';
  // static const baseUrl = 'https://myprojectstaging.net/tow_revo/public/api/';
  static const baseUrl = 'https://api.towrevo.com/public/api/';
  // static const imageBaseUrl =
  //     'https://myprojectstaging.net/tow_revo/public/uploads/user/';
  static const imageBaseUrl = 'https://api.towrevo.com/public/uploads/user/';

  static const Map<String, String> header = {
    'Accept': 'application/json',
  };
  Future<Map<String, String>> headerWithAuth() async {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await getSharedPreferenceValue('token')}'
    };
  }

  Future<dynamic> getSharedPreferenceValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<dynamic> removeSharedPreferenceValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  Future<String> dayToInt(String day) async {
    if (day == 'Monday') {
      return '1';
    } else if (day == 'Tuesday') {
      return '2';
    } else if (day == 'Wednesday') {
      return '3';
    } else if (day == 'Thursday') {
      return '4';
    } else if (day == 'Friday') {
      return '5';
    } else if (day == 'Saturday') {
      return '6';
    } else if (day == 'Sunday') {
      return '7';
    } else {
      return '1';
    }
  }

  Future<void> setSharedPrefValue(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<bool> isInternetAvailable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: 'Please Check Your Internet',
      );
      return false;
    }
  }

//time stamp to dd/MM/yyyy
  final outputFormat = DateFormat('dd/MM/yyyy');
  String userHistoryDateFormat(String date) {
    final inputDate = DateFormat('yyyy-MM-dd').parse(date.split('T').first);

    // print(inputDate);
    // return outputFormat.format(inputDate);
    return DateFormat.yMMMd().format(inputDate);
  }

  String companyHistoryDateFormat(String date) {
    final inputDate = DateFormat('yyyy-MM-dd').parse(date.split('T').first);

    // print(inputDate);
    // return outputFormat.format(inputDate);
    return DateFormat.MMMMEEEEd().format(inputDate);
  }

  List<PointLatLng> decodeEncodedPolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      PointLatLng p =
          PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  Future<void> setUserDataToLocalStorage(Map loadedData) async {
    await setSharedPrefValue('token', loadedData['token']);
    await setSharedPrefValue('type', loadedData['user']['type']);

    await setSharedPrefValue('email', loadedData['user']['email']);
    await setSharedPrefValue('image', loadedData['user']['image'] ?? '');
    final Map companyInfo = loadedData['user']['company_info'] ?? {};

    if (companyInfo.isNotEmpty) {
      await setSharedPrefValue(
          'longitude', companyInfo['longitude'].toString());
      await setSharedPrefValue('latitude', companyInfo['latitude'].toString());
    }
    await setSharedPrefValue(
      'name',
      loadedData['user']['first_name'].toString() +
          ' ' +
          (loadedData['user']['last_name'] ?? '').toString(),
    );
  }

  Future<void> setUpRequestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
