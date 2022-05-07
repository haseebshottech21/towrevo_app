import 'package:towrevo/utilities/utilities.dart';

class Payment {
  final String id;
  final String amount;
  final String createdAt;
  Payment({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> map) {
    return Payment(
      id: map['id'].toString(),
      amount: map['amount'].toString(),
      createdAt:
          Utilities().userHistoryDateFormat(map['created_at'].toString()),
    );
  }
}
