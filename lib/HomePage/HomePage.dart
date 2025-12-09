// ignore: file_names
// ignore: file_names
// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chanmovie/DetailScreen/checker.dart';
import 'package:chanmovie/RepeatedFunction/repttext.dart';
import 'package:chanmovie/RepeatedFunction/searchbarfunc.dart';
import '../Models/trending_model.dart';
import '../RepeatedFunction/Drawer.dart';
import '../SectionHomeUi/movie.dart';
import '../SectionHomeUi/tvseries.dart';
import '../SectionHomeUi/upcomming.dart';
import '../Services/trending_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<TrendingItem> trendingweek = [];
  int uval = 1;

  Future<void> trendinglist(int checkerno) async {
    trendingweek = await TrendingService.fetchTrending(checkerno);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const drawerfunc(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ====================== CUSTOM APP BAR ======================
          SliverAppBar(
            backgroundColor: Colors.black.withOpacity(0.4),
            elevation: 0,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: trendinglist(uval),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      trendingweek.isNotEmpty) {
                    final featured = trendingweek[0];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // Poster Background
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${featured.posterPath}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.4),
                                Colors.black,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),

                        // Content overlay (title + buttons)
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  featured.displayTitle,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.redAccent, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${featured.voteAverage}',
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                descriptioncheckui(
                                              featured.id,
                                              featured.mediaType,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.play_arrow,
                                          color: Colors.white),
                                      label: const Text(
                                        "Tonton Sekarang",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(Icons.add,
                                          color: Colors.white),
                                      label: const Text(
                                        "Tambah ke Daftar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.redAccent),
                    );
                  }
                },
              ),
            ),
          ),

          // ====================== MAIN CONTENT ======================
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              const searchbarfun(),
              const SizedBox(height: 20),

              // Tab section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: [
                    Tab(child: Tabbartext('TV Series')),
                    Tab(child: Tabbartext('Movies')),
                    Tab(child: Tabbartext('Upcoming')),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              SizedBox(
                height: 1100,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    TvSeries(),
                    Movie(),
                    Upcomming(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
