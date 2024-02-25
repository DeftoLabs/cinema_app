import 'package:flutter_dotenv/flutter_dotenv.dart';

class Envioment {

  static String theMovieDbKry = dotenv.env['THE_MOVIEDB_KEY'] ?? 'Error API Key';


}