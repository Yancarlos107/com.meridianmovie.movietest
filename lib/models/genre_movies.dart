import 'dart:convert';
import 'movie.dart';

class GenreMovies {
  GenreMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory GenreMovies.fromJson(String str) =>
      GenreMovies.fromMap(json.decode(str));

  factory GenreMovies.fromMap(Map<String, dynamic> json) => GenreMovies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
