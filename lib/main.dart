import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorCheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

var kDartColorCheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 5, 99, 125));
void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (value) {
      runApp(MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDartColorCheme,
          cardTheme: CardTheme().copyWith(
              color: kDartColorCheme.secondaryContainer,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDartColorCheme.primaryContainer,
                  foregroundColor: kDartColorCheme.onPrimaryContainer)),
        ),
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorCheme,
            appBarTheme: AppBarTheme().copyWith(
                backgroundColor: kColorCheme.onPrimaryContainer,
                foregroundColor: kColorCheme.primaryContainer),
            cardTheme: CardTheme().copyWith(
                color: kColorCheme.secondaryContainer,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorCheme.primaryContainer)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorCheme.onSecondaryContainer,
                    fontSize: 16))),
        themeMode: ThemeMode.system,
        home: Expenses(),
      ));
  //   },
  // );
}
