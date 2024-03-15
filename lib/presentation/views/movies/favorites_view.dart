import 'package:cinema/presentation/providers/providers.dart';
import 'package:cinema/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// init
// solo las primeras 10

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override

  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {

    if( isLoading || isLastPage) return;
    isLoading = true;

    final movies = await  ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if(movies.isEmpty){
      isLastPage = true;
    }


  }

@override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
      body: MovieMasonry (
        loadNextPage: loadNextPage,
        movies: favoriteMovies),
    );
  }
}