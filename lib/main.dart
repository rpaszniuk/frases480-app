import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:frases480/routes/routes.dart';
import 'package:frases480/screens/categories_screen.dart';
import 'package:frases480/screens/category_screen.dart';
import 'package:frases480/screens/home_screen.dart';
import 'package:frases480/services/category.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();

    return MaterialApp(
      title: "Frases 480",
      theme: ThemeData.light(),
      home: HomeScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      routes: {
        Routes.home: (context) => HomeScreen(),
        Routes.categories: (context) => CategoriesScreen(),
        Routes.category: (context) => CategoryScreen(
            ModalRoute.of(context)!.settings.arguments as Category),
      },
    );
  }
}
