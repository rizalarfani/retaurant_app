import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:restaurant_app/models/add_review.dart';
import 'package:restaurant_app/models/detail_restaurant_model.dart';
import 'package:restaurant_app/models/restaurant_model.dart'
    as restaurant_model;
import '../utils/constans.dart';

class ServiceApi {
  final Client client;
  ServiceApi({required this.client});

  final String _baseUrl = Constans.baseUrlApi;

  Future<List<restaurant_model.Restaurants>> getListRestaurants() async {
    Uri url = Uri.parse(_baseUrl + 'list');
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List? data =
          (jsonDecode(response.body) as Map<String, dynamic>)['restaurants'];
      if (data == null || data.isEmpty) {
        return [];
      } else {
        return data
            .map((e) => restaurant_model.Restaurants.fromJson(e))
            .toList();
      }
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception(response.body);
    }
  }

  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    Uri url = Uri.parse(_baseUrl + 'detail/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailRestaurantModel restaurants = DetailRestaurantModel.fromJson(data);
      return restaurants;
    } else if (response.statusCode == 404) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw (response.body);
    }
  }

  Future<AddReviewModel> addReview(
      String id, String name, String review) async {
    Uri url = Uri.parse(_baseUrl + 'review');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var json = jsonEncode({
      'id': id,
      'name': name,
      'review': review,
    });
    Response response = await client.post(url, headers: headers, body: json);
    if (response.statusCode == 201) {
      return AddReviewModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return AddReviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw (response.body);
    }
  }

  Future<List<restaurant_model.Restaurants>> search(String query) async {
    Uri url = Uri.parse(_baseUrl + 'search?q=$query');
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List? data =
          (jsonDecode(response.body) as Map<String, dynamic>)['restaurants'];
      if (data == null || data.isEmpty) {
        return [];
      } else {
        return data
            .map((e) => restaurant_model.Restaurants.fromJson(e))
            .toList();
      }
    } else {
      throw (response.body);
    }
  }

  Future<restaurant_model.Restaurants> getRandomRestaurant() async {
    Uri url = Uri.parse(_baseUrl + 'list');
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List? data =
          (jsonDecode(response.body) as Map<String, dynamic>)['restaurants'];
      return restaurant_model.Restaurants.fromJson((data!..shuffle()).first);
    } else {
      throw Exception(response.body);
    }
  }
}
