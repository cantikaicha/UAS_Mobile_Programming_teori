// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:chanmovie/RepeatedFunction/reviewui.dart';
import 'package:chanmovie/RepeatedFunction/sliderlist.dart';
import '../HomePage/HomePage.dart';
import '../RepeatedFunction/TrailerUI.dart';
import '../RepeatedFunction/favoriateandshare.dart';
import '../RepeatedFunction/repttext.dart';
import 'package:chanmovie/apikey/apikey.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TvSeriesDetails extends StatefulWidget {
  var id;
  TvSeriesDetails({super.key, this.id});

  @override
  State<TvSeriesDetails> createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {
  var tvseriesdetaildata;
  List<Map<String, dynamic>> TvSeriesDetails = [];
  List<Map<String, dynamic>> TvSeriesREview = [];
  List<Map<String, dynamic>> similarserieslist = [];
  List<Map<String, dynamic>> recommendserieslist = [];
  List<Map<String, dynamic>> seriestrailerslist = [];

  Future<void> tvseriesdetailfunc() async {
    var tvseriesdetailurl = 'https://api.themoviedb.org/3/tv/${widget.id}?api_key=$apikey';
    var tvseriesreviewurl = 'https://api.themoviedb.org/3/tv/${widget.id}/reviews?api_key=$apikey';
    var similarseriesurl = 'https://api.themoviedb.org/3/tv/${widget.id}/similar?api_key=$apikey';
    var recommendseriesurl = 'https://api.themoviedb.org/3/tv/${widget.id}/recommendations?api_key=$apikey';
    var seriestrailersurl = 'https://api.themoviedb.org/3/tv/${widget.id}/videos?api_key=$apikey';

    // TV Series Detail
    var tvseriesdetailresponse = await http.get(Uri.parse(tvseriesdetailurl));
    if (tvseriesdetailresponse.statusCode == 200) {
      tvseriesdetaildata = jsonDecode(tvseriesdetailresponse.body);

      TvSeriesDetails.add({
        'backdrop_path': tvseriesdetaildata['backdrop_path'],
        'title': tvseriesdetaildata['original_name'],
        'vote_average': tvseriesdetaildata['vote_average'],
        'overview': tvseriesdetaildata['overview'],
        'status': tvseriesdetaildata['status'],
        'releasedate': tvseriesdetaildata['first_air_date'],
      });

      // Genres
      for (var genre in tvseriesdetaildata['genres']) {
        TvSeriesDetails.add({'genre': genre['name']});
      }

      // Creators
      for (var creator in tvseriesdetaildata['created_by']) {
        TvSeriesDetails.add({
          'creator': creator['name'],
          'creatorprofile': creator['profile_path'],
        });
      }
    }

    // Reviews
    var tvseriesreviewresponse = await http.get(Uri.parse(tvseriesreviewurl));
    if (tvseriesreviewresponse.statusCode == 200) {
      var tvseriesreviewdata = jsonDecode(tvseriesreviewresponse.body);
      for (var review in tvseriesreviewdata['results']) {
        TvSeriesREview.add({
          'name': review['author'],
          'review': review['content'],
          "rating": review['author_details']['rating'] == null
              ? "Not Rated"
              : review['author_details']['rating'].toString(),
          "avatarphoto": review['author_details']['avatar_path'] == null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : "https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}",
          "creationdate": review['created_at'].substring(0, 10),
          "fullreviewurl": review['url'],
        });
      }
    }

    // Similar Series
    var similarseriesresponse = await http.get(Uri.parse(similarseriesurl));
    if (similarseriesresponse.statusCode == 200) {
      var similarseriesdata = jsonDecode(similarseriesresponse.body);
      for (var series in similarseriesdata['results']) {
        similarserieslist.add({
          'poster_path': series['poster_path'],
          'name': series['original_name'],
          'vote_average': series['vote_average'],
          'id': series['id'],
          'Date': series['first_air_date'],
        });
      }
    }

    // Recommended Series
    var recommendseriesresponse = await http.get(Uri.parse(recommendseriesurl));
    if (recommendseriesresponse.statusCode == 200) {
      var recommendseriesdata = jsonDecode(recommendseriesresponse.body);
      for (var series in recommendseriesdata['results']) {
        recommendserieslist.add({
          'poster_path': series['poster_path'],
          'name': series['original_name'],
          'vote_average': series['vote_average'],
          'id': series['id'],
          'Date': series['first_air_date'],
        });
      }
    }

    // Trailers
    var tvseriestrailerresponse = await http.get(Uri.parse(seriestrailersurl));
    if (tvseriestrailerresponse.statusCode == 200) {
      var tvseriestrailerdata = jsonDecode(tvseriestrailerresponse.body);
      for (var trailer in tvseriestrailerdata['results']) {
        if (trailer['type'] == "Trailer") {
          seriestrailerslist.add({'key': trailer['key']});
        }
      }
      seriestrailerslist.add({'key': 'aJ0cZTcTh90'});
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _retry() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: tvseriesdetailfunc(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
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
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                      Navigator.pop(context);
                    },
                    icon: const Icon(FontAwesomeIcons.circleArrowLeft),
                    iconSize: 28,
                    color: Colors.white,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage()),
                            (route) => false);
                      },
                      icon: const Icon(FontAwesomeIcons.houseUser),
                      iconSize: 25,
                      color: Colors.white,
                    )
                  ],
                  backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
                  expandedHeight: MediaQuery.of(context).size.height * 0.35,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FittedBox(
                      fit: BoxFit.fill,
                      child: trailerwatch(
                        trailerytid: seriestrailerslist[0]['key'],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    addtofavoriate(
                      id: widget.id,
                      type: 'tv',
                      Details: TvSeriesDetails,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: tvseriesdetaildata['genres'].length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: genrestext(TvSeriesDetails[index + 1]['genre'].toString()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 12),
                      child: tittletext("Series Overview : "), // warna default putih
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: overviewtext(TvSeriesDetails[0]['overview'].toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: ReviewUI(revdeatils: TvSeriesREview),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: boldtext("Status : ${TvSeriesDetails[0]['status']}"),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: tittletext("Created By : "), // warna default putih
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: tvseriesdetaildata['created_by'].length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(25, 25, 25, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${TvSeriesDetails[index + 4]['creatorprofile']}',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                genrestext(TvSeriesDetails[index + 4]['creator'].toString()),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: normaltext("Total Seasons : ${tvseriesdetaildata['seasons'].length}"),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: normaltext("Release date : ${TvSeriesDetails[0]['releasedate']}"),
                    ),
                    sliderlist(similarserieslist, 'Similar Series', 'tv', similarserieslist.length),
                    sliderlist(recommendserieslist, 'Recommended Series', 'tv', recommendserieslist.length),
                  ]),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
