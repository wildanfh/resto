import 'package:resto_app/model/customer_reviews.dart';

class RestaurantsDetail {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantsDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantsDetail.fromJson(Map<String, dynamic> json) => RestaurantsDetail(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );
}

class Restaurant {
    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    List<ToName> categories;
    Menus menus;
    double rating;
    List<CustomerReview> customerReviews;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        required this.categories,
        required this.menus,
        required this.rating,
        required this.customerReviews,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<ToName>.from((json["categories"] as List).map((x) => ToName.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from((json["customerReviews"] as List).map((x) => CustomerReview.fromJson(x))),
    );
}



class Menus {
  List<ToName> foods;
  List<ToName> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<ToName>.from((json["foods"] as List).map((x) => ToName.fromJson(x))),
        drinks: List<ToName>.from((json["drinks"] as List).map((x) => ToName.fromJson(x))),
      );
}

class ToName {
  String name;

  ToName({required this.name});

  factory ToName.fromJson(Map<String, dynamic> json) => ToName(
        name: json["name"],
      );
}
