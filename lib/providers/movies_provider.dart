import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '305dda9a38d756b2b85972bf74e17f2a';
  final String _language = 'es-ES';

  List<Movie> onGenerMovies = [];
  List<Genre> listGenres = [];
  int page = 0;
  Map<int, List<Cast>> movieCast = {};
  String genreId = '0';

  MoviesProvider() {
    getListMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<String> _getJsonDataMovie(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
      'with_genres': genreId
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<List<Movie>> getMoviesGenre() async {
    page++;
    final jsonData = await _getJsonDataMovie('3/discover/movie', page);
    final nowGenerResponse = GenreMovies.fromJson(jsonData);
    onGenerMovies = [...onGenerMovies, ...nowGenerResponse.results];

    return onGenerMovies;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditResponse = Credits.fromJson(jsonData);
    movieCast[movieId] = creditResponse.cast;
    return creditResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchMovies = SearchResults.fromJson(response.body);

    return searchMovies.results;
  }

  getListMovies() async {
    var url = Uri.https(_baseUrl, '3/genre/movie/list',
        {'api_key': _apiKey, 'language': _language});
    final response = await http.get(url);
    final listMovies = ListMovies.fromJson(response.body);
    listGenres = listMovies.genres;
    notifyListeners();
  }

  resetDataMovies() {
    onGenerMovies = [];
    page = 0;
    notifyListeners();
  }

  void updateListMovies() {
    getMoviesGenre();
    notifyListeners();
  }
}
