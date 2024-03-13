import 'package:cinema/domain/datasource/local_storage_datasource.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl (this.datasource);


  @override
  Future<bool> isMovieFavorite(int movieId) {
    return isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return toggleFavorite(movie);
  }


}