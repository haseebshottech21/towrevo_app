import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:towrevo/main.dart';
import 'package:towrevo/utilities.dart';

class AuthenticationWebService {
  Future<dynamic> signUpCompany(Map<String, dynamic> body) async {
    print(Utilities.baseUrl + 'register');
    print(body);

    // try {
    final response = await http.post(
      Uri.parse(Utilities.baseUrl + 'register'),
      body: body,
      headers: Utilities.header,
    );
    print(response.body);
    final loadedData = json.decode(response.body);
    print(loadedData);
    if (response.statusCode == 200) {
      // await setToken(loadedData['data']['token'],loadedData['data']['user']['type'].toString());
      print('200');
      Utilities().showToast(loadedData.toString());
      print(loadedData['data']['uniqueId']);

      await Utilities()
          .setSharedPrefValue('uniqueId', loadedData['data']['uniqueId']);
      await Utilities().setSharedPrefValue('validate', '0');
      await Utilities().setSharedPrefValue('resendOTP', '0');

      return loadedData;
    } else {
      print('in error');
      print(loadedData);
      Utilities().showToast(loadedData.toString());
      return {};
    }
    // } catch (e) {
    //   Utilities().showToast('Something Went wrong');
    // }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(Uri.parse(Utilities.baseUrl + 'login'),
        body: {
          'email': email,
          'password': password,
          'notification_id': MyApp.notifyToken,
        },
        headers: Utilities.header);
    print(response.body);

    final responseLoaded = json.decode(response.body);
    // print(responseLoaded['data']['user']);
    if (response.statusCode == 200) {
      await Utilities()
          .setSharedPrefValue('token', responseLoaded['data']['token']);
      await Utilities()
          .setSharedPrefValue('type', responseLoaded['data']['user']['type']);
      Utilities().showToast('Success');
      return true;
    } else {
      Utilities().showToast(responseLoaded['message'].toString());
      return false;
    }
  }

  Future<bool> logout() async {
    final response = await http.post(Uri.parse(Utilities.baseUrl + 'logout'),
        headers: await Utilities().headerWithAuth());
    print(response.body);
    final loadedResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      print('success');
      await Utilities().removeSharedPreferenceValue('token');
      await Utilities().removeSharedPreferenceValue('type');
      return true;
    } else {
      Utilities().showToast(loadedResponse['message'].toString()); 
      return false;
    }
  }

  Future<void> resetPassword(String token, String password,String confirmPassword, String otp,)async{
  
    final response = await http.post(Uri.parse(Utilities.baseUrl+'resetPassword'),
      body:{
        'token':token,
        'otp' : otp,
        'password' : password,
        'password_confirmation' : confirmPassword,
      },
      headers: Utilities.header,
    );
    print(response.body);
    if(response.statusCode == 200){
      print('200');
    }else{
        print(response.statusCode);
    }
  }


   Future<void> forgotPassword(String email)async{
  
    final response = await http.post(Uri.parse(Utilities.baseUrl+'resetPassword'),
      body:{
        'email':email,
      },
      headers: Utilities.header,
    );
    print(response.body);
    if(response.statusCode == 200){
      print('yes 200');
      print(response.statusCode);
    }else{
        print(response.statusCode);
    }
  }

  void signUpErrorHandle(Map<String, dynamic> body) {
    if (body['']) {}
  }
}
