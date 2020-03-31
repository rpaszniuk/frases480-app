import 'package:flutter/material.dart';
import 'package:frases480/services/phrase.dart';
import 'package:frases480/widgets/nav_drawer.dart';
import 'package:frases480/widgets/phrase_list.dart';
import 'package:frases480/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreen({this.phrases});

  final List<Phrase> phrases;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Phrase> phrases = List();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getPhrases();
  }

  void updateUI(List<Phrase> array) {
    setState(() {
      phrases = array;
    });
  }

  void getPhrases() async {
    setState(() {
      isLoading = true;
    });

    var array = await Phrase().fetchAll();
    setState(() {
      isLoading = false;
      phrases = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Frases"),
        ),
        body:  phrases == null || phrases.length == 0
            ? isLoading ? Loader()
            : Center (child: Text("Sin frases disponibles"))
            : PhraseList(phrases)
    );
  }
}