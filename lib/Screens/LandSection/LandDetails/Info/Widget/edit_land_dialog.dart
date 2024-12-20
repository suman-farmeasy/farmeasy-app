import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showEditLandDialog(
    BuildContext context, double heightValue, Widget editLandValue) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5), // Background dimming
    transitionDuration:
        const Duration(milliseconds: 300), // Smooth animation duration
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: Get.height * heightValue,
            child: editLandValue,
          ),
        ),
      );
    },

    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack, // Smooth animation curve
          ),
          child: child,
        ),
      );
    },
  );
}
