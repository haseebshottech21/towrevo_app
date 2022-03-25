import 'package:towrevo/models/review_model.dart';

import '../utilities/utilities.dart';

class UserHistoryModel {
  String id;
  String userId;
  String companyId;
  String serviceId;
  String serviceName;
  String longitude;
  String latitude;
  String address;
  int status;
  String companyName;
  String date;

  ReviewModel? rating;

  UserHistoryModel({
    required this.userId,
    required this.id,
    required this.companyId,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.serviceId,
    required this.serviceName,
    required this.status,
    required this.companyName,
    required this.date,
    required this.rating,
  });

  factory UserHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserHistoryModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      longitude: json['longitude'].toString(),
      latitude: json['latitude'].toString(),
      address: json['address'].toString(),
      companyId: json['company_id'].toString(),
      serviceId: json['service']['id'].toString(),
      serviceName: json['service']['name'],
      status: json['status'],
      companyName: json['company']['first_name'],
      date: Utilities().userHistoryDateFormat(json['created_at']),
      rating: json['rating'] == null
          ? null
          : ReviewModel.fromJson(
              json['rating'],
            ),
    );
  }
}
