import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/ui/resto_detail_page.dart';
import 'package:resto_app/widgets/custom_appbar.dart';
import 'package:resto_app/widgets/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
      create: (_) => RestoProvider(apiService: ApiService()).getAllRestaurant(),
      child: CustomScrollView(
        slivers: [
          Consumer<RestoProvider>(
            builder: (context, state, _) {
              return SliverPersistentHeader(
                delegate: CustomAppBar(expandHeight: 200, provider: state),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
          Consumer<RestoProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const SliverFillRemaining(
                  child: Center(child: LottieAsset(file: "cat-load.json")),
                );
              } else if (state.state == ResultState.hasData) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    state.result.restaurants
                        .map((resto) => cardList(context, resto))
                        .toList(),
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return SliverFillRemaining(
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
                );
              } else if (state.state == ResultState.error) {
                return SliverFillRemaining(
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
                );
              } else {
                return const Center(
                  child: SliverFillRemaining(
                    child: Text(''),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget cardList(BuildContext context, Restaurants resto) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 1,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Hero(
                      tag: resto.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${ApiService.imageUrl}small/${resto.pictureId}',
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                '${resto.rating}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            resto.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            resto.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(resto.city),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestoDetailPage(restos: resto),
            ));
      },
    );
  }
}
