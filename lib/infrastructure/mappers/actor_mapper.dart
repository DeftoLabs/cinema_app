

import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity (Cast cast) => 
  Actor(
    id: cast.id, 
    name: cast.name,
    profilePath: cast.profilePath != null
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    : 'https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1095249842.jpg',
    character: cast.character!,
    
    );

}