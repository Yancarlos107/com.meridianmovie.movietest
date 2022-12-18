import 'package:flutter/material.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final String genre = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(genre),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: MovieSlider(
          nextPage: () => moviesProvider.updateListMovies(),
        ),
      ),
    );
  }
}
