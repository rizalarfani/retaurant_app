import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helper/navigator_helper.dart';

import '../providers/fovorite_provider.dart';
import '../screen/detail_restaurant.dart';
import '../utils/colors_theme.dart';
import 'error_text.dart';

class ListAllRestaurants extends StatelessWidget {
  final dynamic restaurant;
  const ListAllRestaurants({Key? key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationHelper.intentWithData(
          DetailRestaurant.routeName, restaurant),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(211, 209, 216, 0.35),
                offset: Offset(15, 15),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: restaurant?.id ?? '',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${restaurant!.pictureId}',
                        fit: BoxFit.cover,
                        height: 228,
                        width: double.infinity,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const ErrorText(
                              textError:
                                  'Image failed to load because internet is not available');
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 28,
                    width: 50,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(244, 114, 76, 0.20),
                          offset: Offset(0, 15),
                          blurRadius: 23,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant?.rating.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, state, _) {
                      bool isFavorite = state.result
                          .where((element) => element.id == restaurant?.id)
                          .isNotEmpty;
                      return Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => state.addBookmark(restaurant),
                          child: Container(
                            height: 28,
                            width: 28,
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            decoration: BoxDecoration(
                              color: isFavorite
                                  ? Colors.white
                                  : ColorsTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color:
                                  isFavorite ? Colors.redAccent : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      restaurant?.name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: ColorsTheme.primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              restaurant?.city ?? '',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
