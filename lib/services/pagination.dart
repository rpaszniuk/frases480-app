import 'package:frases480/services/phrase.dart';
import 'package:frases480/services/category.dart';
import 'package:frases480/services/networking.dart';
import 'dart:convert';

class Pagination {
  final int total;
  final int perPage;
  final String next;
  final String previous;
  final int nextPage;
  final int previousPage;

  Pagination({this.total, this.perPage, this.next, this.previous, this.nextPage, this.previousPage});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      perPage: json['per_page'],
      next: json['next'],
      previous: json['previous'],
      nextPage: json['next_page'],
      previousPage: json['previous_page'],
    );
  }
}

class PhrasesWithPagination {
  final List<Phrase> phrases;
  final Pagination pagination;

  PhrasesWithPagination({this.phrases, this.pagination});

  factory PhrasesWithPagination.fromJson(Map<String, dynamic> json) {
    var phrases = (json['data'] as List)
        .map((data) => new Phrase.fromJson(data))
        .toList();
    var pagination = Pagination.fromJson(json['meta']);
    return PhrasesWithPagination(
      phrases: phrases,
      pagination: pagination
    );
  }

  Future<PhrasesWithPagination> fetchAll(int page, String term) async {
    NetworkHelper networkHelper = NetworkHelper("$phrasesURL?page=$page&q=$term");
    try {
      final response = await networkHelper.get();

      if (response.statusCode == 200) {
        return PhrasesWithPagination.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<PhrasesWithPagination> fetchAllByCategory(int categoryId, int page) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          "$categoriesURL/$categoryId?page=$page");
      final response = await networkHelper.get();

      if (response.statusCode == 200) {
        return PhrasesWithPagination.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}