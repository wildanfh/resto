import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/ui/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    home();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: secondaryColor,
      ),
      child: Center(
        child: DefaultTextStyle(
          style:
              Theme.of(context).textTheme.displayLarge!.apply(color: primaryColor),
          child: AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                'Resto',
                scalingFactor: 1.0,
                duration: const Duration(milliseconds: 2500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void home() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) {
          return const MainPage();
        }
      ));
    });
  }
}
