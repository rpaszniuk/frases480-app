import 'package:flutter/material.dart';
import 'package:frases480/services/category.dart';
import 'package:frases480/widgets/nav_drawer.dart';
import 'package:frases480/widgets/loader.dart';
import 'package:frases480/routes/routes.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/categories';

  @override
  _CategoriesScreen createState() => _CategoriesScreen();
}

class _CategoriesScreen extends State<CategoriesScreen> {
  List<Category> categories = List();
  String message;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    setState(() {
      isLoading = true;
    });
    var array = await Category().fetchAll();
    setState(() {
      isLoading = false;
      categories = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Categorías"),
        ),
        body: categories == null || categories.length == 0
            ? isLoading ? Loader()
            : Center (child: Text("Sin categorías disponibles"))
            : ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: Card(
                  child: ListTile(
                    onTap: () {Navigator.pushNamed(context, Routes.category, arguments: categories[index]);},
                    title: Text(categories[index].name),
                  ),
                ),
              );
            })
    );
  }
}