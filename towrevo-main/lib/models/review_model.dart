class ReviewModel {
  int rate;
  String review;
  ReviewModel({
    required this.rate,
    required this.review,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // print('there');
    // print(json['created_at']);
    return ReviewModel(
      rate: json['rate'],
      review: json['review'] ?? '',
    );
  }
}
