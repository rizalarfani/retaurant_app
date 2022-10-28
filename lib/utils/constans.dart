import 'dart:io';

class Constans {
  static String baseUrlApi = 'https://restaurant-api.dicoding.dev/';

  static String readJson(String path) {
    var dir = Directory.current.path;
    return File("$dir/$path").readAsStringSync();
  }
}
