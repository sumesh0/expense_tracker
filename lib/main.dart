import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kDarkTheme = ColorScheme.fromSeed(seedColor: Colors.black);
void main() {
  runApp( MaterialApp(
    darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
    colorScheme: kDarkTheme,),
    debugShowCheckedModeBanner: false,
    home: const Expenses(),
    themeMode: ThemeMode.system,
  ));
} 