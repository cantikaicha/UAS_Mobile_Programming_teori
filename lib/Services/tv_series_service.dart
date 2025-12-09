import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chanmovie/apikey/apikey.dart';
import 'package:chanmovie/Models/tv_series_model.dart' as tv_model;

class TvSeriesService {
  static Future<List<tv_model.TvSeries>> fetchPopularTvSeries() async {
    var populartvseriesurl =
        'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';
    var populartvresponse = await http.get(Uri.parse(populartvseriesurl));
    if (populartvresponse.statusCode == 200) {
      var tempdata = jsonDecode(populartvresponse.body);
      var populartvjson = tempdata['results'] as List;
      return populartvjson.map((item) => tv_model.TvSeries.fromJson(item)).toList();
    }
    return [];
  }

  static Future<List<tv_model.TvSeries>> fetchTopRatedTvSeries() async {
    var topratedtvseriesurl =
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey';
    var topratedtvresponse = await http.get(Uri.parse(topratedtvseriesurl));
    if (topratedtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedtvresponse.body);
      var topratedtvjson = tempdata['results'] as List;
      return topratedtvjson.map((item) => tv_model.TvSeries.fromJson(item)).toList();
    }
    return [];
  }

  static Future<List<tv_model.TvSeries>> fetchOnAirTvSeries() async {
    var onairtvseriesurl =
        'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apikey';
    var onairtvresponse = await http.get(Uri.parse(onairtvseriesurl));
    if (onairtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(onairtvresponse.body);
      var onairtvjson = tempdata['results'] as List;
      return onairtvjson.map((item) => tv_model.TvSeries.fromJson(item)).toList();
    }
    return [];
  }
}
