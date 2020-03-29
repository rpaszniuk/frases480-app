import 'package:flutter/material.dart';
import 'package:frases480/services/phrase.dart';
import 'package:frases480/widgets/nav_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

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
            ? isLoading ? Center(
          child: SpinKitDoubleBounce(
            color: Colors.black,
            size: 100.0,
          ),)
            : Center (child: Text("Sin frases disponibles"))
            : ListView.builder(
            itemCount: phrases.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("Frase de " + phrases[index].category.name),
                        subtitle: Padding(padding: EdgeInsets.only(top: 10), child: Text(phrases[index].phrase)),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:  Icon(Icons.web),
                            onPressed: () {
                              var url = phrases[index].url;
                              if (canLaunch(url) != null) {
                               launch(url, forceSafariVC: false);
                              } else {
                                throw 'No se puede abrir navegador, por favor visitar: $url';
                              }
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.share),
                            onPressed: () {
                              Share.share(phrases[index].phrase + ' ' + phrases[index].url);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
    );
  }
}