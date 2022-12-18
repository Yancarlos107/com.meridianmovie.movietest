import 'dart:convert';

import 'package:peliculas/models/movie.dart';

class SearchResults {
  SearchResults({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchResults.fromJson(String str) =>
      SearchResults.fromMap(json.decode(str));

  factory SearchResults.fromMap(Map<String, dynamic> json) => SearchResults(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
