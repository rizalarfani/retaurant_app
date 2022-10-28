import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/service/service_api.dart';
import 'package:restaurant_app/utils/constans.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ServiceApi serviceApi;
  MockClient client = MockClient();

  setUp(() {
    serviceApi = ServiceApi(client: client);
  });

  group("Fetch Restaurants", () {
    test('returns an List Restaurants if the http call completes successfully',
        () async {
      String jsonString = Constans.readJson('assets/json/list_restaurant.json');
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      final restraurant = await serviceApi.getListRestaurants();
      expect(restraurant, isA<List<Restaurants>>());
    });

    test(
        'return parsing detail restaurant if the http call completes successfully',
        () async {
      String id = 'rqdv5juczeskfw1e867';
      String jsonString =
          Constans.readJson('assets/json/detail_restaurant.json');
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) => Future.value(http.Response(jsonString, 200)));
      final detail = await serviceApi.getDetailRestaurant(id);
      expect(detail.restaurant!.id, equals(id));
      expect(detail.restaurant!.name, 'Melting Pot');
      expect(detail.restaurant!.rating, double.parse("4.2"));
      expect(detail.restaurant!.menus!.foods, isNotEmpty);
    });

    test('check results restaurant details not found ', () async {
      String id = 'rqdv5juczeskfw1e86';
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) => Future.value(http.Response(
              '{"error": true, "message": "restaurant not found"}', 404)));
      final detail = await serviceApi.getDetailRestaurant(id);
      expect(detail.error, true);
      expect(detail.message, 'restaurant not found');
    });
  });
}
