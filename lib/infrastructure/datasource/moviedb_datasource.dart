


import 'package:cinema/config/constants/enviroment.dart';
import 'package:cinema/domain/datasource/movies_datasource.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Envioment.theMovieDbKry,
      'language': 'es-MX',
    }
  )
  );

  List<Movie> _jsonToMovies (Map<String, dynamic> json){

    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
      ).toList();

    return movies;

  }
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing',
    queryParameters:{
    'page' : page
    } 
    );
    
  return _jsonToMovies(response.data);
  
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular',
    queryParameters:{
    'page' : page
    } 
    );
    return _jsonToMovies(response.data);

  }

    @override
  Future<List<Movie>> getTopRated ({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
    queryParameters:{
    'page' : page
    } 
    );
    return _jsonToMovies(response.data);

  }

    @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
    queryParameters:{
    'page' : page
    } 
    );
    return _jsonToMovies(response.data);

  }


}