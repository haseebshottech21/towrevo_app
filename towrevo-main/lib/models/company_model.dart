import 'package:intl/intl.dart';

class CompanyModel {
  String id;
  String userId;
  String description;
  String latitude;
  String longitude;
  String from;
  String to;
  String distance;
  String firstName;
  String email;
  String phoneNumber;
  String image;
  String notificationId;
  String avgRating;

  CompanyModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.from,
    required this.to,
    required this.distance,
    required this.firstName,
    required this.email,
    required this.phoneNumber,
    required this.image,
    required this.notificationId,
    required this.avgRating,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      description: json['description'] ?? 'There is no Description',
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      from: DateFormat("h:mm a")
          .format(DateFormat("hh:mm").parse(json['from'].toString())),
      to: DateFormat("h:mm a")
          .format(DateFormat("hh:mm").parse(json['to'].toString())),
      // distance: double.parse((json['distance']).toStringAsFixed(2)).toString(),
      distance: json['distance'].toString() == 'Null'
          ? 'Not in range'
          : (double.parse(json['distance']
                          .toString()
                          .split('km')
                          .first
                          .trim()) *
                      0.621371)
                  .toStringAsFixed(2)
                  .toString() +
              ' mi',
      firstName: json['user']['first_name'],
      email: json['user']['email'] ?? '',
      phoneNumber: json['user']['phone'] ?? '',
      image: json['user']['image'] ?? '',
      notificationId: json['user']['notification_id'].toString(),
      avgRating: double.parse(
        (json['user']['avg_rating'] ?? 0.0).toStringAsFixed(1),
      ).toString(),
    );
  }
}
