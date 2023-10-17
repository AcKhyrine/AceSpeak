import 'package:flutter/material.dart';

final appTheme = ThemeData(
    textTheme: TextTheme(
      bodyText2: textStyle,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      titleTextStyle: textStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: textStyle.copyWith(fontSize: 50))));

final textStyle = TextStyle(
    fontSize: 40,
    color: Colors.white);
