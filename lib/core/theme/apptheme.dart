import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  primaryColor: const Color.fromARGB(255, 18, 38, 151),
  scaffoldBackgroundColor: const Color.fromARGB(255, 231, 226, 226),
  fontFamily: 'LibreBaskerville',
  dividerColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    foregroundColor: Colors.black,
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  ),
  /*bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: Colors.teal,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),*/
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    contentTextStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    elevation: 5,
    // contentTextStyle: const TextStyle(color: Colors.white, fontSize: 20)
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(
    Colors.indigo,
  ))),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(Colors.indigo),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.indigo),
    shape: MaterialStateProperty.all(const CircleBorder()),
  )),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 110, 110, 110),
        fontSize: 20),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(226, 39, 38, 38),
        fontSize: 25),
    titleLarge: TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(226, 39, 38, 38)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
    bodySmall: TextStyle(
        color: Color.fromARGB(232, 214, 210, 210), fontWeight: FontWeight.w500),
    labelLarge: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 17,
        fontWeight: FontWeight.w500),
  ),
  cardTheme: CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.all(10),
  ),
  /*tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )),*/
);
