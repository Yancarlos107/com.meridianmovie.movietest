import 'dart:convert';

class ListMovies {
  ListMovies({
    required this.genres,
  });

  final List<Genre> genres;

  factory ListMovies.fromJson(String str) =>
      ListMovies.fromMap(json.decode(str));

  factory ListMovies.fromMap(Map<String, dynamic> json) => ListMovies(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
      );
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
