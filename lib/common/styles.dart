import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xffF3F9FB);
const Color grey = Color(0xccF3F9FB);
const Color primaryTextColor = Color(0xff323232);
const Color secondaryColor = Color(0xff474F85);
const Color red = Color(0xffDD5353);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.rubik(
    fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.rubik(
    fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.rubik(
    fontSize: 48, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.rubik(
    fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.rubik(
    fontSize: 24, fontWeight: FontWeight.w500),
  titleLarge: GoogleFonts.rubik(
    fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.rubik(
    fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleSmall: GoogleFonts.rubik(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.rubik(
    fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.rubik(
    fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.rubik(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.rubik(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.rubik(
    fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

List<String> images = ["review.jpg", "review2.jpg", "review3.jpg", "review4.jpg", "review5.jpg"];