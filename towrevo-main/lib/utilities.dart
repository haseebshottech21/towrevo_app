import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      );

      if (result != null) {
        print(result.startTime.format(context));
        return {
          'fromUtilize': result.startTime.format(context).toString(),
          'toUtilize': result.endTime.format(context).toString(),
          'from': timeConverter(result.startTime.format(context)),
          'to': timeConverter(result.endTime.format(context)),
        };
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
  static const baseUrl = 'https://myprojectstaging.net/tow_revo/public/api/';

  static const Map<String, String> header = {
    'Accept': 'application/json',
    // 'Content-Type': 'application/json'
  };
  Future<Map<String, String>> headerWithAuth() async {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await getSharedPreferenceValue('token')}'
    };
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  // Future<void> showAlertDialog(
  //   String title,
  //   String subTitle,
  //   BuildContext context,
  // ) async {
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //             actions: [
  //               ElevatedButton(
  //                 // style: ElevatedButton.styleFrom(
  //                 //     primary: Theme.of(context).buttonColor
  //                 // ),
  //                 onPressed: () {
  //                   // onPress();
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('Okay'),
  //               )
  //             ],
  //             title: Text(title),
  //             content: Text(subTitle),
  //           ));
  // }

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

//time stamp to dd/MM/yyyy
  final outputFormat = DateFormat('dd/MM/yyyy');
  String outputDate(String date) {
    // final inputDate =
    //     DateFormat('yyyy-MM-dd HH:mm').parse(date.split('T').first);
    // print(inputDate);
    // return outputFormat.format(inputDate);
    return date.split('T').first;
  }
}
