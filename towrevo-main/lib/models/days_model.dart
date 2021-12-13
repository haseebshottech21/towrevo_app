import 'package:flutter/cupertino.dart';

class DaysModel with ChangeNotifier{
  String id;
  String name;
  bool dayAvailable;

  DaysModel({required this.id, required this.name, this.dayAvailable=false});

  toggleDay()async{
    dayAvailable = !dayAvailable;
    notifyListeners();
  }

}