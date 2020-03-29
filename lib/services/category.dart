import 'package:frases480/services/networking.dart';
import 'dart:convert';

const URL = '/categories';

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

  Future<Category> fetch(int id) async {
    NetworkHelper networkHelper = NetworkHelper("$URL/$id");
    final response = await networkHelper.get();

    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<Category>> fetchAll() async {
    NetworkHelper networkHelper = NetworkHelper(URL);
    final response = await networkHelper.get();

    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => new Category.fromJson(data))
          .toList();
    } else {
      return null;
    }
  }
}