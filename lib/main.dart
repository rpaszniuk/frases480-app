import 'package:flutter/material.dart';
import 'package:frases480/routes/routes.dart';
import 'package:frases480/screens/categories_screen.dart';
import 'package:frases480/screens/category_screen.dart';
import 'package:frases480/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomeScreen(),
      routes:  {
        Routes.home: (context) => HomeScreen(),
        Routes.categories: (context) => CategoriesScreen(),
        Routes.category: (context) =>
            CategoryScreen(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}