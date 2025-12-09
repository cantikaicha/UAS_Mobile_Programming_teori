import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chanmovie/apikey/apikey.dart';
import 'package:chanmovie/Models/trending_model.dart';

class TrendingService {
  static Future<List<TrendingItem>> fetchTrending(int checkerno) async {
    String type = checkerno == 1 ? 'week' : 'day';
    String url =
        'https://api.themoviedb.org/3/trending/all/$type?api_key=$apikey';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body)['results'] as List;
      return data.map((item) => TrendingItem.fromJson(item)).toList();
    }
    return [];
  }
}
