import 'package:Textly/effects/SlideSnackbar.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showCustomSnackbar(BuildContext context, String msg) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust the distance from the bottom
        left: 20,
        right: 20,
        child: SlideSnackbar(message: msg),
      ),
    );

    // Insert the overlay into the current overlay stack
    Overlay.of(context)!.insert(overlayEntry);

    // Automatically remove the snackbar after the desired duration
    Future.delayed(const Duration(seconds: 5), () {
      overlayEntry.remove();
    });
  }
}