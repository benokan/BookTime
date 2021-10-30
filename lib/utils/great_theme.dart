import 'package:flutter/material.dart';

// #D0CFCF BackGround color

class GreatTheme {
  Color _grey = Color.fromARGB(255, 208, 207, 207);
  
  ThemeData buildTheme() {
    return ThemeData(
      
      canvasColor: _grey,
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: Colors.brown[700],
      ),
    );
  }
}
