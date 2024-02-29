
import 'package:cinema/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:cinema/infrastructure/repositories/actor_reposiroty_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});

