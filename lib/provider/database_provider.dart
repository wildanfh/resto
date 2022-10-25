// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:resto_app/database/database_helper.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  late DatabaseHelper databaseHelper = DatabaseHelper();

  late bool _isFav = false;
  late List<Restaurants> _favList;
  late ResultState _state;

  bool get isFav => _isFav;
  List<Restaurants> get favList => _favList;
  ResultState get state => _state;

  DatabaseProvider getFavList() {
    _fetchFavList();
    return this;
  }

  void _fetchFavList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List<Restaurants> resto = await databaseHelper.getFavs();
      if(resto.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _favList = resto;
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  DatabaseProvider tryAddFavList(Restaurants resto) {
    _addFavList(resto);
    return this;
  }

  void _addFavList(Restaurants resto) async {
    try {
      await databaseHelper.addFav(resto);
      _isFav = true;
      notifyListeners();
    } catch(e) {
      print(e);
    }
  }

  DatabaseProvider getIsFavorite(String id) {
    _isFavorite(id);
    return this;
  }

  Future<bool> _isFavorite(String id) async {
    _state = ResultState.loading;
    notifyListeners();
    final isExist = await databaseHelper.getFavById(id);
    bool val = isExist.isNotEmpty;
    _isFav = val;

    _state = ResultState.hasData;
    notifyListeners();
    return val;
  }

  DatabaseProvider tryDestroy(String id) {
    _destroy(id);
    return this;
  }

  Future<void> _destroy(String id) async {
    try {
      _state = ResultState.loading;
      await databaseHelper.destroyFav(id);
      _isFav = false;
      getFavList();
      _state = ResultState.hasData;
      notifyListeners();
    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }
}