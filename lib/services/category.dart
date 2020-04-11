import 'package:frases480/services/networking.dart';
import 'package:frases480/services/phrase.dart';
import 'dart:convert';

const categoriesURL = '/categories';

class Category {
  final int id;
  final String name;
  final String description;
  final String slug;
  final String status;

  Category({this.id, this.name, this.description, this.slug, this.status});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      slug: json['slug'],
      status: json['status'],
    );
  }

  Future<List<Phrase>> fetch(int id) async {
    try {
      NetworkHelper networkHelper = NetworkHelper("$categoriesURL/$id");
      final response = await networkHelper.get();

      if (response.statusCode == 200) {
        return (json.decode(response.body)['data'] as List)
            .map((data) => new Phrase.fromJson(data))
            .toList();
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<List<Category>> fetchAll() async {
    try {
      NetworkHelper networkHelper = NetworkHelper(categoriesURL);
      final response = await networkHelper.get();

      if (response.statusCode == 200) {
        return (json.decode(response.body)['data'] as List)
            .map((data) => new Category.fromJson(data))
            .toList();
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}