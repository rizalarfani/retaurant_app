import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/database/favorite_restaurant_db.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

import '../utils/result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseManager database;

  FavoriteProvider({required this.database}) {
    _getFavoriteRestaurant();
  }

  ResultState _state = ResultState.loading;
  List<Restaurants> _result = [];
  String _message = '';

  String get message => _message;
  ResultState get state => _state;
  List<Restaurants> get result => _result;

  void _getFavoriteRestaurant() async {
    await database.db;
    _result = await database.getFavoriteRestaurant();
    if (_result.isEmpty) {
      _state = ResultState.noData;
      _message = 'Favorite is empty';
    } else {
      _state = ResultState.hashData;
    }
    notifyListeners();
  }

  Future<void> addBookmark(Restaurants restaurant) async {
    await database.db;
    try {
      if (!await _isFovorited(restaurant.id ?? '')) {
        await database.insertFavorite(restaurant);
        restaurant.isFavorite = true;
        notifyListeners();
      } else {
        await database.removeFavorite(restaurant.id!);
        restaurant.isFavorite = false;
        notifyListeners();
      }
      _getFavoriteRestaurant();
    } catch (e) {
      _state = ResultState.errors;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> _isFovorited(String id) async {
    await database.db;
    final fovoriteRestaurant = await database.getFavoriteById(id);
    return fovoriteRestaurant.isNotEmpty;
  }
}
