import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/detail_restaurant_model.dart';
import 'package:restaurant_app/providers/reviews_provider.dart';
import 'package:restaurant_app/service/service_api.dart';
import 'package:restaurant_app/utils/constans.dart';

import 'review_test.mocks.dart';

@GenerateMocks([http.Client, ReviewsProvider])
void main() {
  late ServiceApi serviceApi;
  late MockReviewsProvider mockReviewsProvider;
  MockClient client = MockClient();

  setUp(() {
    serviceApi = ServiceApi(client: client);
    mockReviewsProvider = MockReviewsProvider();
  });

  group('Returns customerReviews', () {
    test(
        'returns an List customerReviews if the http call completes successfully',
        () async {
      String id = 'rqdv5juczeskfw1e867';
      String jsonString =
          Constans.readJson('assets/json/detail_restaurant.json');
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) => Future.value(http.Response(jsonString, 200)));
      final reviews = await serviceApi.getDetailRestaurant(id);
      expect(reviews.restaurant!.customerReviews, isA<List<CustomerReviews>>());
      expect(reviews.restaurant!.customerReviews, isNotEmpty);
    });
  });

  group('add review', () {
    test("check successfully added a review", () async {
      String id = 'rqdv5juczeskfw1e867';
      when(mockReviewsProvider.addReview(
              id, argThat(contains('test')), 'ini testing review yaa'))
          .thenAnswer((_) => Future.value());
      mockReviewsProvider.addReview(
          id, 'test review', 'ini testing review yaa');
      verify(mockReviewsProvider.addReview(
          id, 'test review', 'ini testing review yaa'));
    });
  });
}
