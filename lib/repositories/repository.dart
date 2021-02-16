import 'package:dio/dio.dart';
import 'package:movie_recomendation/model/movie.dart';
import 'package:movie_recomendation/model/movie_reponse.dart';

class UserRepository{
  static String url = 'https://api.reelgood.com/v3.0/content/random';

  final Dio _dio = Dio();

  Future<MovieResponse> getMovie(int genre, int minImdb) async {
    var params = {
      "availability":"onAnySource",
      "content_kind" : "movie",
      "genre": genre,
      "minimum_imdb":minImdb,
      "sources": 'netflix',
      "region": "us",
      "nocache":true,
    };

    try{
      Response response = await _dio.get(url,queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(e,stacktrace){
      print(stacktrace);
      return MovieResponse.withError(e);
    }
  }
}