//
import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  ThemeData theme() {
    return ThemeData(
      primaryColor: blue,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "yanoneR",
      appBarTheme: AppBarTheme(backgroundColor: blue),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: blue, primary: blue),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}


