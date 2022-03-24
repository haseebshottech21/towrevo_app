class ReviewModel {
  int rate;
  String review;
  ReviewModel({
    required this.rate,
    required this.review,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rate: json['rate'],
      review: json['review'] ?? '',
    );
  }
}
