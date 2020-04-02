import 'package:flutter/material.dart';
import 'package:frases480/services/phrase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class PhraseCard extends StatelessWidget {
  Phrase phrase;
  PhraseCard(this.phrase);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          phrase.category == null ? ListTile(
            title: Text(phrase.phrase)
          )
              : ListTile(
            title: Text("Frase de " + phrase.category.name),
            subtitle: Padding(padding: EdgeInsets.only(top: 10), child: Text(phrase.phrase)),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child:  Icon(Icons.web),
                onPressed: () {
                  var url = phrase.url;
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
                  Share.share(phrase.phrase + ' ' + phrase.url);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}