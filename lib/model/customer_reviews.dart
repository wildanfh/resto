// ignore_for_file: unnecessary_null_in_if_null_operators

class CustomerReviews {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  CustomerReviews({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerReviews.fromJson(Map<String, dynamic> json) =>
      CustomerReviews(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            (json["customerReviews"] as List)
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerReview {
  String? id;
  String name;
  String review;
  String? date;

  CustomerReview({
    this.id,
    required this.name,
    required this.review,
    this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        id: json["id"] ?? null,
        name: json["name"],
        review: json["review"],
        date: json["date"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
        "date": date,
      };
}
