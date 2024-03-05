

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinema/config/helpers/human_formats.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future <List<Movie>> Function (String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMovieCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isloadingStream= StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate ({
    required this.searchMovies,
    required this.initialMovies,
    });

  void clearStreams(){
    debouncedMovies.close();
  }

  void _onQueryChanged (String query){

    isloadingStream.add(true);

    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async { 
      //if(query.isEmpty) {
      //  debouncedMovies.add([]);
      //  return;


      final movie = await searchMovies(query);
      debouncedMovies.add(movie);
      initialMovies = movie;
      isloadingStream.add(false);


    });
  }

  Widget buildResultsAndSuggestions () {
          return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot){

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            return _MovieItem(movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
            );
          },
        );
      });
  }

@override
String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [

    StreamBuilder(
      initialData: false,
      stream: isloadingStream.stream, 
      builder: (context, snapshot){
        if(snapshot.data ?? false) {
        return SpinPerfect(
          duration: const Duration(seconds: 5),
          spins: 10,
          infinite: true,
      child: IconButton(
        onPressed: () {
          query = '';
        } ,
        icon: const Icon(Icons.refresh_rounded)),
    );
        }
    return FadeIn(
      animate: query.isNotEmpty,
      child: IconButton(
        onPressed: () {
          query = '';
        } ,
        icon: const Icon(Icons.clear)),
    );

      }),




   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: (){
        clearStreams();
        close(context, null);},
      icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return buildResultsAndSuggestions();

  
}

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
    });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child:Row(children: [
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(movie.posterPath,
              loadingBuilder: ((context, child, loadingProgress) => FadeIn(child: child)) ,),
              
            ),
          ),
          const SizedBox(width: 10,),
      
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleMedium,),
      
                (movie.overview.length >100 ) 
                ? Text('${movie.overview.substring(0,100)}...')
                : Text(movie.overview),
      
                Row(
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                    const SizedBox(width: 3,),
                    Text(
                      HumanFormats.number(movie.voteAverage, 1),
                    style: textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900)),
                  ],)
              ],
            ),
          )
        ],)),
    );
  }
}