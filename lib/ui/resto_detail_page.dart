// ignore_for_file: unnecessary_cast

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/ui/review_page.dart';
import 'package:resto_app/widgets/lottie.dart';

class RestoDetailPage extends StatelessWidget {
  final Restaurants restos;

  const RestoDetailPage({Key? key, required this.restos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestoProvider provider;
    return ChangeNotifierProvider(
      create: (_) {
        provider = RestoProvider(apiService: ApiService());
        return provider.getDetailRestaurant(restos.id);
      },
      child: Consumer<RestoProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Scaffold(
                body: Center(child: LottieAsset(file: "cat-load.json")));
          } else if (state.state == ResultState.hasData) {
            return Scaffold(
              appBar: detailAppBar(context, restos),
              body: detailBody(context, state.detail.restaurant),
            );
          } else if (state.state == ResultState.noData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LottieAsset(file: "cat-error.json"),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LottieAsset(file: "cat-error.json"),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  detailAppBar(BuildContext context, Restaurants resto) {
    return AppBar(
      iconTheme: const IconThemeData(color: primaryColor),
      backgroundColor: secondaryColor,
      title: Text(
        resto.name,
        style: const TextStyle(
          color: primaryColor,
        ),
      ),
      elevation: 0,
    );
  }

  detailBody(BuildContext context, Restaurant resto) {
    return SingleChildScrollView(
      child: Material(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: resto.id,
                  child: Image.network(
                    "${ApiService.imageUrl}medium/${resto.pictureId}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              resto.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '${resto.rating}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "${resto.address}, ${resto.city}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: resto.categories.map((categories) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              margin: const EdgeInsets.only(right: 8, top: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                categories.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: ChangeNotifierProvider<DatabaseProvider>(
                            create: (_) =>
                                DatabaseProvider().getIsFavorite(resto.id),
                            child: Consumer<DatabaseProvider>(
                              builder: (context, state, _) {
                                if (state.state == ResultState.loading) {
                                  return const CircularProgressIndicator(
                                      color: primaryColor);
                                } else if (state.state == ResultState.noData) {
                                  return MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 0,
                                    color: secondaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 0),
                                    child: Row(children: state.isFav
                                      ? [
                                     const  Icon(Icons.favorite,
                                          color: primaryColor, size: 14),
                                      const SizedBox(width: 4),
                                      const Text('Favorite',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13)),
                                    ]
                                    : [
                                      const Icon(Icons.delete,
                                          color: primaryColor, size: 14),
                                      const SizedBox(width: 4),
                                      const Text('Delete',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13)),
                                    ]),
                                    onPressed: () {
                                      state.isFav
                                          ? state.tryDestroy(resto.id)
                                          : state.tryAddFavList(restos);
                                    },
                                  );
                                } else if (state.state == ResultState.hasData) {
                                  return MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 0,
                                    color: !state.isFav ? secondaryColor : red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 0),
                                    child: Row(children: !state.isFav
                                      ? [
                                     const  Icon(Icons.favorite,
                                          color: primaryColor, size: 14),
                                      const SizedBox(width: 4),
                                      const Text('Favorite',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13)),
                                    ]
                                    : [
                                      const Icon(Icons.delete,
                                          color: primaryColor, size: 14),
                                      const SizedBox(width: 4),
                                      const Text('Remove',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 13)),
                                    ]),
                                    onPressed: () {
                                      state.isFav
                                          ? state.tryDestroy(resto.id)
                                          : state.tryAddFavList(restos);
                                    },
                                  );
                                } else {
                                  return const LottieAsset(file: "cat-load.json");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x55333333),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    ExpandableText(
                      resto.description,
                      expandText: "Read more",
                      maxLines: 5,
                      linkColor: secondaryColor,
                      animation: true,
                      collapseText: "Read less",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menus',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: const Text('Foods :'),
                    ),
                    menuItem(context, resto.menus.foods),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: const Text('Drinks :'),
                    ),
                    menuItem(context, resto.menus.drinks),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: const Text(
                    "Review",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewPage(resto: resto)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  menuItem(BuildContext context, List<ToName> menus) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        itemCount: menus.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menus.map((item) {
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
