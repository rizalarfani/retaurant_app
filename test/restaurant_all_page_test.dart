import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/screen/restaurant_all_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/error_text.dart';

import 'restaurant_all_page_test.mocks.dart';

@GenerateMocks([RestaurantProvider])
void main() {
  late MockRestaurantProvider mockRestaurantProvider;

  setUp(() {
    mockRestaurantProvider = MockRestaurantProvider();
  });

  testWidgets('show loading widget when status is loading',
      (WidgetTester tester) async {
    when(mockRestaurantProvider.state).thenReturn(ResultState.loading);

    await tester.pumpWidget(ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => mockRestaurantProvider,
      child: const MaterialApp(
        home: RestaurantsAll(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('show ErrorText widget when status is noData',
      (WidgetTester tester) async {
    when(mockRestaurantProvider.state).thenReturn(ResultState.noData);
    when(mockRestaurantProvider.message).thenReturn('Empty Data');
    await tester.pumpWidget(ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => mockRestaurantProvider,
      child: const MaterialApp(
        home: RestaurantsAll(),
      ),
    ));
    expect(find.byType(ErrorText), findsOneWidget);
  });

  testWidgets('show ListView widget when status is hastData',
      (WidgetTester tester) async {
    when(mockRestaurantProvider.state).thenReturn(ResultState.hashData);
    when(mockRestaurantProvider.result).thenReturn([]);
    await tester.pumpWidget(ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => mockRestaurantProvider,
      child: const MaterialApp(
        home: RestaurantsAll(),
      ),
    ));
    expect(find.byType(ListView), findsOneWidget);
  });
}
