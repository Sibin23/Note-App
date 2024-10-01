import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/colors.dart';

const h10 = SizedBox(height: 10);
const h20 = SizedBox(height: 20);
const h30 = SizedBox(height: 30);
const h40 = SizedBox(height: 40);

final buttonText = GoogleFonts.roboto(color: blackColor, fontSize: 20);
final hintTextStyle = GoogleFonts.roboto(color: hintTextColor, fontSize: 16);
final titleTextStyle = GoogleFonts.roboto(
    color: blackColor, fontSize: 20, fontWeight: FontWeight.w400);

void customSnackBar(BuildContext context, String statusMsg, String message,
    AnimatedSnackBarType snackbarType) {
  return AnimatedSnackBar.rectangle(
    duration: const Duration(seconds: 2),
    statusMsg,
    message,
    type: snackbarType,
    brightness: Brightness.light,
  ).show(context);
}
