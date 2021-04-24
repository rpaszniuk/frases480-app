import 'package:flutter/material.dart';
import 'package:frases480/services/pagination.dart';
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
  List<Phrase> phrases = [];
  Pagination? pagination;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategory(widget.category.id);
  }

  void getCategory(int? id) async {
    setState(() {
      isLoading = true;
    });

    var object = await PhrasesWithPagination().fetchAllByCategory(id, pagination == null || pagination!.nextPage == null ? 1 : pagination!.nextPage);
    setState(() {
      isLoading = false;
      if (object != null) {
        pagination = object.pagination;
        if (phrases.length == 0) {
          phrases = object.phrases!;
        } else {
          phrases.addAll(object.phrases!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name!),
        ),
        body:  _buildPaginatedListView()
    );
  }

  Widget _buildPaginatedListView() {
    return Column(
      children: <Widget>[
        Expanded(
            child: NotificationListener<ScrollNotification>(
              // ignore: missing_return
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading && scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent && (pagination != null && pagination!.nextPage != null)) {
                  this.getCategory(widget.category.id);
                  // start loading data
                  setState(() {
                    isLoading = true;
                  });
                }
                return false;
              },
              child: phrases.length == 0
                  ? isLoading ? Loader() : Center(child: Text("Sin frases disponibles"))
                  : PhraseList(phrases),
            )
        ),
        Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.white,
          child: phrases.length == 0 ? Text('') : Loader(),
        ),
      ],
    );
  }
}