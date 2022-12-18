import 'package:flutter/cupertino.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: movieProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 190,
              child: CupertinoActivityIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (_, i) {
                  return _CastCards(actor: cast[i]);
                }),
          );
        });
  }
}

class _CastCards extends StatelessWidget {
  final Cast actor;
  const _CastCards({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.fullProfilePath),
                fit: BoxFit.cover,
                height: 150,
              )),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
