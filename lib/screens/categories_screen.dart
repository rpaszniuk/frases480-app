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
  List<Category> filteredCategories = List();
  String message;
  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void _filterCategories(value) {
    setState(() {
      filteredCategories = categories
          .where((category) =>
          category.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void getCategories() async {
    setState(() {
      isLoading = true;
    });
    var array = await Category().fetchAll();
    setState(() {
      isLoading = false;
      categories = filteredCategories = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: !isSearching
              ? Text('Categorías')
              : TextField(
            onChanged: (value) {
              _filterCategories(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            isSearching
                ? IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  this.isSearching = false;
                  filteredCategories = categories;
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = true;
                });
              },
            )
          ],
        ),
        body: filteredCategories.length == 0
            ? isLoading ? Loader()
            : Center (child: Text("Sin categorías disponibles"))
            : ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: filteredCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: Card(
                  child: ListTile(
                    onTap: () {Navigator.pushNamed(context, Routes.category, arguments: filteredCategories[index]);},
                    title: Text(filteredCategories[index].name),
                  ),
                ),
              );
            })
    );
  }
}