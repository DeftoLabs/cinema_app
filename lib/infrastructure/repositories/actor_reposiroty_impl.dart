import 'package:cinema/domain/datasource/actors_datasource.dart';
import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;
  ActorRepositoryImpl (this. datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }


}