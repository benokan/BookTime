import 'package:flutter/material.dart';

class GlobalSnackbar {
  static void showMessageUsingSnackBar(
      Color snackColor, String snackText, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackColor,
        content: Row(
          children: [
            Expanded(
              child: Text(
                snackText,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
