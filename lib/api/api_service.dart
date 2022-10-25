import 'dart:convert';
import 'dart:math';

import 'package:resto_app/model/customer_reviews.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String imageUrl = '${_baseUrl}images/';

  Future<RestaurantsResult> getListRestaurants() async {
      final response = await http.get(Uri.parse("${_baseUrl}list"));
      if (response.statusCode == 200) {
        return RestaurantsResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to Load Restaurant List');
      }
  }

  Future<RestaurantsDetail> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantsDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant Detail');
    }
  }

  Future<RestaurantsResult> searchRestaurants({String query = ""}) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Restaurant is Not Found');
    }
  }

  Future<CustomerReviews> postReviewRestaurant(CustomerReview review) async {
    var reviews = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse("${_baseUrl}review"),
      body: reviews,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    if(response.statusCode == 200) {
      return CustomerReviews.fromJson(json.decode(response.body));
    } else {
      throw Exception("Review fail to post");
    }
  }

  Future<Restaurants> fetchRandomOne() async {
    try {
      List<Restaurants> listRestaurants = [];
      final response = await http.get(Uri.parse("${_baseUrl}list"));

      if(response.statusCode == 200) {
        final data = json.decode(response.body);

        (data['restaurants'] as List).map((item) {
          Restaurants model = Restaurants.fromJson(item);
          listRestaurants.add(model);
        }).toList();
      }

      Random random = Random();
      int rNumber = random.nextInt(listRestaurants.length);
      return listRestaurants[rNumber];
    } catch(e) {
      throw Exception(e);
    }
  }
}
