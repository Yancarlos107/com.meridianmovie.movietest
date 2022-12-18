import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    [
      Container(
          color: Colors.red,
          child: IconButton(
              onPressed: () => query = '', icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {close(context, null)},
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(Icons.movie_creation_outlined,
            color: Colors.black38, size: 100),
      );
    }
    final movieProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(Icons.movie_creation_outlined,
                color: Colors.black38, size: 100),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (_, i) => _MovieResult(
                  movie: snapshot.data![i],
                ));
      },
    );
  }
}

class _MovieResult extends StatelessWidget {
  final Movie movie;
  const _MovieResult({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'ResultMovie${movie.id}';
    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title),
        onTap: () {
          Navigator.pushNamed(context, 'Details', arguments: movie);
        },
      ),
    );
  }
}
