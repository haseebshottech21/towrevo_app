class CompanyModel {
  String id;
  String userId;
  String description;
  String startingPrice;
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
  bool isCompanyAvailable;

  CompanyModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.startingPrice,
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
    required this.isCompanyAvailable,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      description: json['description'].toString().replaceAll(r'Other', '\n● '),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      startingPrice: (json['starting_price'] ?? '').toString(),
      from: (json['from'] ?? '24 Hours Open').toString().toUpperCase(),
      to: (json['to'] ?? '').toString().toUpperCase(),
      distance: json['distance'].toString() == 'Null'
          ? 'Not in range'
          : json['distance'].toString().contains('ft')
              ? json['distance'].toString()
              : (double.tryParse(json['distance']
                              .toString()
                              .split('mi')
                              .first
                              .trim()
                              .replaceAll(',', '')) ??
                          json['distance'].toString())
                      .toString() +
                  ' mi',
      isCompanyAvailable: json['distance'].toString() == 'Null' ? false : true,
      firstName: json['user']['first_name'],
      email: json['user']['email'] ?? '',
      phoneNumber: json['user']['phone'] ?? '',
      image: json['user']['image'] ?? '',
      notificationId: json['user']['notification_id'].toString(),
      avgRating: (json['user']['avg_rating']) == null
          ? '0.0'
          : double.parse(json['user']['avg_rating'].toString())
              .toStringAsFixed(1),
    );
  }
}
