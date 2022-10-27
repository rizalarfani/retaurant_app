import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/favorite_restaurant_db.dart';
import 'package:restaurant_app/helper/navigator_helper.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/providers/bottom_navigation_bar_provider.dart';
import 'package:restaurant_app/providers/categories_provider.dart';
import 'package:restaurant_app/providers/fovorite_provider.dart';
import 'package:restaurant_app/providers/populars_provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/providers/reviews_provider.dart';
import 'package:restaurant_app/providers/scheduling_provider.dart';
import 'package:restaurant_app/providers/search_restaurant_provider.dart';
import 'package:restaurant_app/providers/theme_config_provider.dart';
import 'package:restaurant_app/screen/detail_restaurant.dart';
import 'package:restaurant_app/service/service_api.dart';
import 'package:restaurant_app/service/service_background.dart';
import 'package:restaurant_app/utils/theme_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final bool? themeState;
  const MyApp({Key? key, this.themeState}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<PopularsProvider>(
          create: (_) => PopularsProvider(apiService: ServiceApi()),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider<ThemeConfigProvider>(
          create: (_) => ThemeConfigProvider(),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ServiceApi()),
        ),
        ChangeNotifierProvider<ReviewsProvider>(
          create: (_) => ReviewsProvider(apiServie: ServiceApi()),
        ),
        ChangeNotifierProvider<SearchRestaurantsProvider>(
          create: (_) => SearchRestaurantsProvider(apiService: ServiceApi()),
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(database: DatabaseManager.instanse),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        )
      ],
      child: Consumer<ThemeConfigProvider>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Hub',
            theme:
                state.isDark ? ThemeConfig.darkTheme : ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              DetailRestaurant.routeName: (context) => DetailRestaurant(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as dynamic),
            },
          );
        },
      ),
    );
  }
}
