import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'Splash',
      routes: {
        'Splash': (_) => const SplashScreen(),
        'Home': (_) => const HomeScreen(),
        'Genre': (_) => const GenreScreen(),
        'Details': (_) => const DetailsScreen(),
        'Secret': (_) => const SecretScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
