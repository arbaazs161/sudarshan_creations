import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const themeColor = Color(0xfff04f5f);

const lightSkinColor = Color(0xffFEF7F3);
const brownColor = Color(0xffB58543);

// const lightGreenColor = Color(0xffe2f7c7);
// const greenColor = Color.fromRGBO(171, 232, 94, 1);
// const greenColor2 = Color.fromARGB(255, 115, 164, 55);
const themeColor = Color(0xffB58543);
// const themeColor = Color.fromARGB(255, 115, 164, 55);

final themeData = ThemeData(
    textTheme: ThemeData(fontFamily: "CenturyGothic").textTheme,
    colorSchemeSeed: themeColor,
    useMaterial3: true,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    // useMaterial3: true,
    // scaffoldBackgroundColor: lightSkinColor,
    bottomSheetTheme:
        const BottomSheetThemeData(surfaceTintColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ));
