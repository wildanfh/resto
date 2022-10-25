import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/ui/home_page.dart';
import 'package:resto_app/ui/resto_detail_page.dart';
import 'package:resto_app/widgets/lottie.dart';

class FavPage extends StatelessWidget {
  final HomePage homePage;
  const FavPage({Key? key, required this.homePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider().getFavList(),
      child: Consumer<DatabaseProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: LottieAsset(file: "cat-load.json"));
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.favList.length,
              itemBuilder: (context, index) {
                Restaurants resto = state.favList[index];
                return slideItem(context, state, resto);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LottieAsset(file: "cat-notyet.json"),
                  Text("Daftar favorit belum ada",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: secondaryColor)),
                ],
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LottieAsset(file: "cat-notyet.json"),
                  const SizedBox(height: 10),
                  Text("Daftar favorit belum ada",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: secondaryColor)),
                ],
              ),
            );
          } else {
            return const Center(child: LottieAsset(file: "cat-notyet.json"));
          }
        },
      ),
    );
  }

  slideItem(BuildContext context, DatabaseProvider state, Restaurants resto) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (val) {
              state.tryDestroy(resto.id);
            },
            backgroundColor: red,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: InkWell(
        child: homePage.cardList(context, resto),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RestoDetailPage(restos: resto),
          ));
        },
      ),
    );
  }
}
