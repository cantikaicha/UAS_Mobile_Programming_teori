import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chanmovie/RepeatedFunction/sliderlist.dart';
import '../RepeatedFunction/repttext.dart';
import 'package:chanmovie/apikey/apikey.dart';
import 'package:chanmovie/Models/movie_model.dart' as movie_model;

class Upcomming extends StatefulWidget {
  const Upcomming({super.key});

  @override
  State<Upcomming> createState() => _UpcommingState();
}

class _UpcommingState extends State<Upcomming> {
  List<movie_model.Movie> getUpcomminglist = [];

  Future<void> getUpcomming() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'] as List;
      getUpcomminglist = results.map((item) => movie_model.Movie.fromJson(item)).toList();
    }
  }

  void _retry() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUpcomming(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
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
                      backgroundColor: Colors.amber,
                    ),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(getUpcomminglist.map((movie) => movie.toJson()).toList(), "Upcomming", "movie", 20),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 15, bottom: 40),
                      child: tittletext("Many More Coming Soon...")) // hapus color: null
                ]);
          }
        });
  }
}
