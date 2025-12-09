import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chanmovie/apikey/apikey.dart';

class SearchService {
  static Future<List<Map<String, dynamic>>> searchMulti(String query) async {
    var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=$apikey&query=$query';
    var searchresponse = await http.get(Uri.parse(searchurl));
    List<Map<String, dynamic>> searchresult = [];
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null &&
            searchjson[i]['media_type'] != null) {
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        }
      }
    }
    return searchresult;
  }
}
