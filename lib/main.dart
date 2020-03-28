import 'package:flutter/material.dart';
import 'package:frases480/screens/categories_screen.dart';
import 'package:frases480/screens/home_screen.dart';
import 'package:frases480/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes:  {
        Routes.home: (context) => HomeScreen(),
        Routes.categories: (context) => CategoriesScreen()
      },
    );
  }
}