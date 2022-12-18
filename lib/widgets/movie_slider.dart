import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieSlider extends StatefulWidget {
  final Function nextPage;
  const MovieSlider({Key? key, required this.nextPage}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        widget.nextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getMoviesGenre(),
      builder: (_, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final movies = snapshot.data!;
        return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            controller: scrollController,
            scrollDirection: Axis.vertical,
            itemCount: movies.length,
            itemBuilder: (_, i) {
              final movie = movies[i];
              movie.heroId = 'Slider${movie.id}';
              return _MovieContainer(
                movie: movie,
              );
            });
      },
    );
  }
}

class _MovieContainer extends StatelessWidget {
  final Movie movie;
  const _MovieContainer({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'Details', arguments: movie);
              },
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.cover,
                    height: 300,
                    width: 200,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
