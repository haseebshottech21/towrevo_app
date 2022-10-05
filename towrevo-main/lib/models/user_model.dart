class CompanyInfoModel {
  int? id;
  int? userId;
  String? status;

  CompanyInfoModel({
    this.id,
    this.userId,
    this.status,
  });

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) =>
      CompanyInfoModel(
        id: json['id'],
        userId: json['user_id'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'status': status,
      };
}
