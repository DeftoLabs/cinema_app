import 'package:cinema/domain/entities/actor.dart';

abstract class ActorsRepository {

Future <List<Actor>> getActorsByMovie (String movieId);
}