import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAsset extends StatelessWidget {
  final String file;

  const LottieAsset({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/$file",
      width: 100,
    );
  }
}