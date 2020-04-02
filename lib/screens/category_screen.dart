import 'package:flutter/material.dart';
import 'package:frases480/widgets/nav_drawer.dart';
import 'package:frases480/widgets/phrase_list.dart';
import 'package:frases480/widgets/loader.dart';
import 'package:frases480/services/category.dart';
import 'package:frases480/services/phrase.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  CategoryScreen(this.category);

  final Category category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Phrase> phrases = List();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategory(widget.category.id);
  }

  void getCategory(int id) async {
    setState(() {
      isLoading = true;
    });

    var array = await Category().fetch(id);
    setState(() {
      isLoading = false;
      phrases = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name),
        ),
        body:  phrases == null || phrases.length == 0
            ? isLoading ? Loader()
            : Center (child: Text("Sin frases disponibles"))
            : PhraseList(phrases)
    );
  }
}