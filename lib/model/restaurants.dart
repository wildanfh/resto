// ignore_for_file: prefer_if_null_operators

class RestaurantsResult {
  final bool error;
  String? message;
  int? count;
  int? founded;
  final List<Restaurants> restaurants;

  RestaurantsResult({
    required this.error,
    this.message,
    this.count,
    this.founded,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        founded: json["founded"] == null ? null : json["founded"],
        restaurants: List<Restaurants>.from(
            (json["restaurants"] as List).map((x) => Restaurants.fromJson(x))),
      );
}

class RestaurantSearch {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurants>.from(
            (json["restaurants"] as List).map((x) => Restaurants.fromJson(x))),
      );
}

class Restaurants {
  String id;
  String name;
  String description;
  String city;
  String pictureId;
  double rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
