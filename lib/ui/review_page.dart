import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/model/customer_reviews.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/ui/review_modal.dart';
import 'package:resto_app/widgets/lottie.dart';

// ignore: must_be_immutable
class ReviewPage extends StatelessWidget {
  final Restaurant resto;

  ReviewPage({Key? key, required this.resto}) : super(key: key);
  late RestoProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Review",
          style: TextStyle(color: primaryColor),
        ),
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
      ),
      body: ChangeNotifierProvider(
        create: (_) => RestoProvider(apiService: ApiService())
            .getDetailRestaurant(resto.id),
        child: Consumer<RestoProvider>(
          builder: (context, state, _) {
            provider = state;
            if (state.state == ResultState.loading) {
              return const Center(
                  child: LottieAsset(file: "cat-load.json"));
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.detail.restaurant.customerReviews.length,
                itemBuilder: (context, index) {
                  var review = state.detail.restaurant.customerReviews[index];
                  return cardReview(context, review);
                },
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state.message == "Review berhasil di post"
                    ? const LottieAsset(file: "cat-load.json")
                    : const LottieAsset(file: "cat-error.json"),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) =>
            ReviewModal(provider: provider, id: resto.id));
        },
      ),
    );
  }

  cardReview(BuildContext context, CustomerReview review) {
    Random random = Random();
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: secondaryColor)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/images/${images[random.nextInt(5)]}"),
          radius: 25,
        ),
        title: Text(review.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(review.date ?? ""),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(review.review),
            ),
          ],
        ),
      ),
    );
  }
}
