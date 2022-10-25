import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final double expandHeight;
  final RestoProvider provider;

  const CustomAppBar({
    required this.expandHeight,
    required this.provider,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/bg1.jpg',
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandHeight),
              child: const SizedBox(
                child: Text(
                  'Resto',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 3.0,
                        color: Color.fromARGB(155, 0, 0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -25,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandHeight),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 5,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        provider.getAllRestaurant();
                      } else {
                        provider.onQuery(value);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Search Restaurant",
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 14, right: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
