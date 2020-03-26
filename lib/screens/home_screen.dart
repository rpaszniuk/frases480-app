import 'package:flutter/material.dart';
import 'package:frases480/services/phrase.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.phrases});

  final List<Phrase> phrases;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Phrase> phrases = List();
  String message;
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    updateUI(widget.phrases);
  }

  void updateUI(List<Phrase> array) {
    setState(() {
      phrases = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Frases"),
        ),
        body: phrases == null
            ? Center (child: Text("Sin frases disponibles"))
            : ListView.builder(
            itemCount: phrases.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(phrases[index].phrase),
              );
            })
    );
  }
}