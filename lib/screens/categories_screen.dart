import 'package:flutter/material.dart';
import 'package:frases480/services/category.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frases480/widgets/nav_drawer.dart';

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
            ? isLoading ? Center(
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),)
            : Center (child: Text("Sin categorías disponibles"))
            : ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(categories[index].name),
              );
            })
    );
  }
}