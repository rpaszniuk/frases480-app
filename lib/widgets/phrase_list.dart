import 'package:flutter/material.dart';
import 'package:frases480/services/phrase.dart';
import 'package:frases480/widgets/phrase_card.dart';

class PhraseList extends StatelessWidget {
  final List<Phrase> phrases;

  PhraseList(this.phrases);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: PhraseCard(phrases[index]),
          );
        });
  }
}
