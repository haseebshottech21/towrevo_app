import 'package:flutter/cupertino.dart';

class ServicesModel with ChangeNotifier {
  String id;
  String name;
  bool serviceAvailable;

  ServicesModel(
      {required this.id, required this.name, this.serviceAvailable = false});

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }

  toggleService() async {
    serviceAvailable = !serviceAvailable;
    notifyListeners();
  }
}
