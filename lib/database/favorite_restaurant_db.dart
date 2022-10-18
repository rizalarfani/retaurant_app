import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  DatabaseManager.__private();

  static DatabaseManager instanse = DatabaseManager.__private();

  Database? _db;
  static const String _table = 'favorite';

  Future<Database> get db async {
    _db ??= _db = await _initDb();
    return _db!;
  }

  Future _initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'favorite.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        return await database.execute('''CREATE TABLE $_table (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          description TEXT NOT NULL,
          city TEXT NOT NULL,
          rating REAL NOT NULL
        )''');
      },
    );
  }

  Future<void> insertFavorite(Restaurants restaurant) async {
    _db = await instanse.db;
    await _db!.insert(_table, {
      'id': restaurant.id,
      'name': restaurant.name,
      'description': restaurant.description,
      'city': restaurant.city,
      'rating': restaurant.rating,
    });
  }

  Future<Map> getFavoriteById(String id) async {
    _db = await instanse.db;

    List<Map<String, dynamic>> results = await _db!.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : {};
  }

  Future closeDb() async {
    _db = await instanse.db;
    _db!.close();
  }
}
