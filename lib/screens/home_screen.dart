import 'package:flutter/material.dart';
import 'package:frases480/services/pagination.dart';
import 'package:frases480/services/phrase.dart';
import 'package:frases480/widgets/nav_drawer.dart';
import 'package:frases480/widgets/phrase_list.dart';
import 'package:frases480/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Phrase> phrases = [];
  Pagination? pagination;
  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    getPhrases();
  }

  void getPhrases({term : ''}) async {
    setState(() {
      isLoading = true;
    });

    var object = await PhrasesWithPagination().fetchAll(pagination == null || pagination!.nextPage == null ? 1 : pagination!.nextPage, term);
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
        drawer: NavDrawer(),
        appBar: AppBar(
          title: !isSearching
              ? Text('Frases')
              : TextField(
            onChanged: (value) {
              phrases = [];
              pagination = null;
              getPhrases(term: value);
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
                  isSearching = false;
                  phrases = [];
                  pagination = null;
                  getPhrases();
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
                  this.getPhrases();
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