import 'package:cinema/domain/datasource/movies_datasource.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/domain/repositories/movies_repository.dart';

class MovieRepositoryIml extends MoviesRepository {

  final MoviesDatasource datasource;
  MovieRepositoryIml(this.datasource);


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page:page);
  }



}