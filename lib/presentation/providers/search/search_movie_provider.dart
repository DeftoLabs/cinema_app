
import 'package:cinema/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema/domain/entities/movie.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider <SearchedMoviesNotifier, List<Movie >>((ref) {

final movieRepository = ref.read(movieRepositoryProvider);

return SearchedMoviesNotifier(
  searchMovie: movieRepository.searchMovies, 
  ref: ref
  );
});

typedef SearchMoviesCallback = Future <List<Movie>> Function (String query);

class SearchedMoviesNotifier extends StateNotifier <List<Movie>> {
  
  final SearchMoviesCallback searchMovie;
  final Ref ref;

  SearchedMoviesNotifier ({
    required this.searchMovie, 
    required this.ref,
  }): super ([]);

  Future <List<Movie>> searchMoviesByQuery (String query) async {

    final List<Movie> movies = await searchMovie(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
 

  
  
}