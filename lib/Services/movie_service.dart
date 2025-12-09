import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chanmovie/apikey/apikey.dart';
import 'package:chanmovie/Models/movie_model.dart' as movie_model;

class MovieService {
  static Future<List<movie_model.Movie>> fetchPopularMovies() async {
    var popularmoviesurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'] as List;
      return popularmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }
    return [];
  }

  static Future<List<movie_model.Movie>> fetchNowPlayingMovies() async {
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingmoviesjson = tempdata['results'] as List;
      return nowplayingmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }
    return [];
  }

  static Future<List<movie_model.Movie>> fetchTopRatedMovies() async {
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';
    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'] as List;
      return topratedmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }
    return [];
  }
}
