import 'package:flutter/material.dart';

class ServiceDescriptionModel with ChangeNotifier {
  final String title;
  bool isActive;
  ServiceDescriptionModel({
    required this.title,
    required this.isActive,
  });

  toggleServiceDescription() async {
    isActive = !isActive;
    notifyListeners();
  }
}
