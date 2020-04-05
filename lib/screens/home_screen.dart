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
  List<Phrase> phrases = List();
  Pagination pagination;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPhrases();
  }

  void getPhrases() async {
    setState(() {
      isLoading = true;
    });

    var object = await PhrasesWithPagination().fetchAll(pagination == null || pagination.nextPage == null ? 1 : pagination.nextPage);
    setState(() {
      isLoading = false;
      pagination = object.pagination;
      if (phrases.length == 0) {
        phrases = object.phrases;
      } else {
        phrases.addAll(object.phrases);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Frases"),
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
                    scrollInfo.metrics.maxScrollExtent && (pagination != null && pagination.nextPage != null)) {
                  this.getPhrases();
                  // start loading data
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: phrases == null || phrases.length == 0
                  ? isLoading ? Loader() : Center(child: Text("Sin frases disponibles"))
                  : PhraseList(phrases),
            )
        ),
        Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.white,
          child: phrases == null || phrases.length == 0 ? null : Loader(),
        ),
      ],
    );
  }
}