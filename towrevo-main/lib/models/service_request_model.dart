import 'package:towrevo/models/review_model.dart';
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
  String destLongitude;
  String destLatitude;
  String destAddress;
  String description;
  int status;
  String notificationId;
  String name;
  String image;
  String createdAt;
  ReviewModel? reviewModel;

  ServiceRequestModel({
    required this.userId,
    required this.id,
    required this.companyId,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.serviceId,
    required this.destLongitude,
    required this.destLatitude,
    required this.destAddress,
    required this.description,
    required this.serviceName,
    required this.status,
    required this.notificationId,
    required this.name,
    required this.image,
    required this.createdAt,
    this.reviewModel,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      longitude: json['longitude'].toString(),
      latitude: json['latitude'].toString(),
      address: json['address'].toString(),
      destLongitude: json['dest_longitude'] ?? '',
      destLatitude: json['dest_latitude'] ?? '',
      destAddress: json['dest_address'] ?? '',
      description: json['description'] ?? ''.toString(),
      companyId: json['company_id'].toString(),
      serviceId: json['service']['id'].toString(),
      serviceName: json['service']['name'],
      status: json['status'],
      notificationId: (json['user']['notification_id']) ?? '',
      name: (json['user']['first_name'] ?? '') +
          ' ' +
          (json['user']['last_name'] ?? ''),
      image: json['user']['image'] ?? '',
      createdAt: json['created_at'] != null
          ? Utilities().companyHistoryDateFormat(json['created_at'])
          : '',
      reviewModel: json['rating'] == null
          ? null
          : ReviewModel.fromJson(
              json['rating'],
            ),
    );
  }
}
