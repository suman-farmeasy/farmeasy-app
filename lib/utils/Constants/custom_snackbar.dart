// snackbar_utils.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessCustomSnackbar({
  required String title,
  required String message,
  IconData icon = Icons.check,
  Color iconColor = const Color(0xFF00CC99),
  Color backgroundColor = const Color(0xFFE6FAF5),
  Color borderColor = const Color(0xFF00CC99),
  Color textColor = Colors.black87,
}) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    borderRadius: 8,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(0),
    duration: Duration(seconds: 3),
    isDismissible: true,
    snackStyle: SnackStyle.FLOATING,
    messageText: Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void showErrorCustomSnackbar({
  required String title,
  required String message,
  IconData icon = Icons.close,
  Color iconColor = const Color(0xFFEB5757),
  Color backgroundColor = const Color(0xFFFDEEEE),
  Color borderColor = const Color(0xFFEB5757),
  Color textColor = Colors.black87,
}) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    borderRadius: 8,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(0),
    duration: Duration(seconds: 3),
    isDismissible: true,
    snackStyle: SnackStyle.FLOATING,
    messageText: Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
