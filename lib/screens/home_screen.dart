import 'package:flutter/material.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onLongPress: () {
              Navigator.pushNamed(context, 'Secret');
            },
            child: Text("Generos de peliculas"),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: ListView.builder(
            itemCount: moviesProvider.listGenres.length,
            itemBuilder: ((context, index) {
              final genre = moviesProvider.listGenres[index];
              return ListTile(
                  title: Text(genre.name),
                  leading: const Icon(Icons.ondemand_video),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    moviesProvider.resetDataMovies();
                    moviesProvider.genreId = genre.id.toString();
                    Navigator.pushNamed(context, 'Genre',
                        arguments: genre.name);
                  });
            })));
  }
}
