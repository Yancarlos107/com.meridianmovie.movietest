import 'package:flutter/material.dart';
import 'package:peliculas/widgets/casting_card.dart';

import '../models/movie.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        body: CustomScrollView(
      //widgets con comportamiento programado cuando se hace scroll en los widgets
      slivers: [
        _CustomAppBar(title: movie.title, poster: movie.fullBackdropPath),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTittle(
            title: movie.title,
            originalTittle: movie.originalTitle,
            voteAverage: movie.voteAverage.toString(),
            poster: movie.fullPosterImg,
            heroId: movie.heroId!,
          ),
          _Overview(overview: movie.overview),
          CastingCards(movieId: movie.id)
        ]))
      ],
    ));
  }
}

class _PosterAndTittle extends StatelessWidget {
  final String title;
  final String poster;
  final String voteAverage;
  final String originalTittle;
  final String heroId;
  const _PosterAndTittle({
    Key? key,
    required this.title,
    required this.poster,
    required this.voteAverage,
    required this.originalTittle,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: heroId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(poster),
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextTheme.headline5,
                ),
                Text(
                  originalTittle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextTheme.subtitle1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.star_outlined,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(voteAverage, style: TextTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String poster;
  const _CustomAppBar({Key? key, required this.title, required this.poster})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      floating: false,
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
            padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            )),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(poster),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;
  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(overview,
          textAlign: TextAlign.justify,
          maxLines: 10,
          overflow: TextOverflow.ellipsis),
    );
  }
}
