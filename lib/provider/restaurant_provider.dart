import 'package:flutter/material.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/model/customer_reviews.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService});

  late RestaurantsResult _restaurantsResult;
  late RestaurantsDetail _restaurantsDetail;
  late ResultState _state;
  String _message = '';
  String _query = "";

  RestaurantsResult get result => _restaurantsResult;
  RestaurantsDetail get detail => _restaurantsDetail;
  ResultState get state => _state;
  String get message => _message;

  RestoProvider getAllRestaurant() {
    _fetchAllRestaurant();
    return this;
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = _query == ""
          ? await apiService.getListRestaurants()
          : await apiService.searchRestaurants(query: _query);

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurants not found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> Internet not connected';
    }
  }

  RestoProvider getDetailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getDetailRestaurant(id);
      if (restaurantDetail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data for this id ($id) is not found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsDetail = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> Internet is not connected';
    }
  }

  void onQuery(String query) {
    _query = query;
    _fetchAllRestaurant();
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      _state = ResultState.hasData;
      notifyListeners();
      final response = await apiService.postReviewRestaurant(review);
      if (!response.error) getDetailRestaurant(review.id!);
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Review berhasil di post';
    }
  }
}
