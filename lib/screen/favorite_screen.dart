import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/fovorite_provider.dart';

import '../utils/result_state.dart';
import '../widget/error_text.dart';
import '../widget/list_all_restaurants.dart';

class FavorireScreen extends StatelessWidget {
  const FavorireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 32,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favorite Restaurant',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/img/profile.png',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<FavoriteProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.hashData) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => ListAllRestaurants(
                        restaurant: state.result[index],
                      ),
                    );
                  } else if (state.state == ResultState.noData) {
                    return ErrorText(textError: state.message);
                  } else if (state.state == ResultState.errors) {
                    return ErrorText(textError: state.message);
                  } else {
                    return ErrorText(textError: state.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
