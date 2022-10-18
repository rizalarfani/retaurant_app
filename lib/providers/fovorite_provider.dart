import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/database/favorite_restaurant_db.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

import '../utils/result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseManager database;

  FavoriteProvider({required this.database});

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  Future<void> addBookmark(Restaurants restaurant) async {
    await database.db;
    try {
      if (!await _isFovorited(restaurant.id ?? '')) {
        await database.insertFavorite(restaurant);
      } else {
        _state = ResultState.errors;
        _message = 'Favorite sudah ada';
        notifyListeners();
      }
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
