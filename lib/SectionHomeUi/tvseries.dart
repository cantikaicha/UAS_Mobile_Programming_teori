import 'package:flutter/material.dart';
import 'package:chanmovie/RepeatedFunction/sliderlist.dart';
import 'package:chanmovie/Models/tv_series_model.dart' as tv_model;
import 'package:chanmovie/Services/tv_series_service.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  List<tv_model.TvSeries> populartvseries = [];
  List<tv_model.TvSeries> topratedtvseries = [];
  List<tv_model.TvSeries> onairtvseries = [];

  Future<void> tvseriesfunction() async {
    populartvseries = await TvSeriesService.fetchPopularTvSeries();
    topratedtvseries = await TvSeriesService.fetchTopRatedTvSeries();
    onairtvseries = await TvSeriesService.fetchOnAirTvSeries();
  }

  @override
  void initState() {
    super.initState();
    // tvseriesfunction();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121212),
      child: FutureBuilder(
        future: tvseriesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pinkAccent,
              ),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(
                    populartvseries.map((tv) => tv.toJson()).toList(),
                    "🔥 Popular TV",
                    "tv",
                    populartvseries.length,
                  ),
                  sliderlist(
                    onairtvseries.map((tv) => tv.toJson()).toList(),
                    "📡 On Air Now",
                    "tv",
                    onairtvseries.length,
                  ),
                  sliderlist(
                    topratedtvseries.map((tv) => tv.toJson()).toList(),
                    "⭐ Top Rated",
                    "tv",
                    topratedtvseries.length,
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
