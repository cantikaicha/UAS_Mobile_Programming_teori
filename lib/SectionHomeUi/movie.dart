import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chanmovie/RepeatedFunction/sliderlist.dart';
import 'package:chanmovie/apikey/apikey.dart';
import 'package:chanmovie/Models/movie_model.dart' as movie_model;

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  List<movie_model.Movie> popularmovies = [];
  List<movie_model.Movie> nowplayingmovies = [];
  List<movie_model.Movie> topratedmovies = [];
  List<movie_model.Movie> latestmovies = [];

  Future<void> moviesfunction() async {
    var popularmoviesurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';

    /// POPULAR
    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'] as List;
      popularmovies = popularmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }

    /// NOW PLAYING
    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingmoviesjson = tempdata['results'] as List;
      nowplayingmovies = nowplayingmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }

    /// TOP RATED
    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'] as List;
      topratedmovies = topratedmoviesjson.map((item) => movie_model.Movie.fromJson(item)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    // moviesfunction();
  }

  void _retry() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121212), // dark bg
      child: FutureBuilder(
        future: moviesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.pinkAccent,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Terjadi kesalahan. Silakan coba lagi.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _retry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                    ),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(
                    popularmovies.map((movie) => movie.toJson()).toList(),
                    "🔥 Popular Now",
                    "movie",
                    popularmovies.length,
                  ),
                  sliderlist(
                    nowplayingmovies.map((movie) => movie.toJson()).toList(),
                    "🎬 Now Playing",
                    "movie",
                    nowplayingmovies.length,
                  ),
                  sliderlist(
                    topratedmovies.map((movie) => movie.toJson()).toList(),
                    "⭐ Top Rated",
                    "movie",
                    topratedmovies.length,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
