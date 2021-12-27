import 'package:towrevo/utilities.dart';

class ServiceRequestModel {
  String id;
  String userId;
  String companyId;
  String serviceId;
  String serviceName;
  String longitude;
  String latitude;
  String address;
  int status;
  String notificationId;
  String name;
  String image;
  String createdAt;

  ServiceRequestModel({
    required this.userId,
    required this.id,
    required this.companyId,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.serviceId,
    required this.serviceName,
    required this.status,
    required this.notificationId,
    required this.name,
    required this.image,
    required this.createdAt,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      longitude: json['longitude'].toString(),
      latitude: json['latitude'].toString(),
      address: json['address'].toString(),
      companyId: json['company_id'].toString(),
      serviceId: json['service']['id'].toString(),
      serviceName: json['service']['name'],
      status: json['status'],
      notificationId: json['user']['notification_id'],
      name: (json['user']['first_name'] ?? '') +
          ' ' +
          (json['user']['last_name'] ?? ''),
      image: json['user']['image'] ?? '',
      createdAt: json['created_at'] == null
          ? Utilities().outputDate(json['created_at'])
          : '',
    );
  }
}
