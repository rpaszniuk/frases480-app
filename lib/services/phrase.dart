import 'package:frases480/services/networking.dart';
import 'dart:convert';

const URL = '/phrases';

class Phrase {
  final int id;
  final String phrase;
  final String slug;
  final int categoryId;
  final String status;

  Phrase({this.id, this.phrase, this.slug, this.categoryId, this.status});

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      id: json['id'],
      phrase: json['phrase'],
      slug: json['slug'],
      categoryId: json['category_id'],
      status: json['status'],
    );
  }

  Future<Phrase> fetch(int id) async {
    NetworkHelper networkHelper = NetworkHelper("$URL/$id");
    final response = await networkHelper.get();

    if (response.statusCode == 200) {
      return Phrase.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<Phrase>> fetchAll() async {
    NetworkHelper networkHelper = NetworkHelper(URL);
    final response = await networkHelper.get();

    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => new Phrase.fromJson(data))
          .toList();
    } else {
      return null;
    }
  }
}