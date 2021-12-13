class ServiceRequestModel {
  String userId;
  String companyId;
  String serviceId;
  String serviceName;

  ServiceRequestModel({required this.userId,required this.companyId,required this.serviceId,required this.serviceName,});

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(userId: json['user_id'].toString(), companyId: json['company_id'].toString(), serviceId: json['service']['id'].toString(), serviceName: json['service']['name']);
  }

}