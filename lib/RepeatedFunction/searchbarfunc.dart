// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:chanmovie/Services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:chanmovie/DetailScreen/checker.dart';
import 'package:chanmovie/RepeatedFunction/repttext.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchbarfun extends StatefulWidget {
  const searchbarfun({super.key});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  List<Map<String, dynamic>> searchresult = [];
  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;

  Future<void> searchlistfunction(val) async {
    searchresult = await SearchService.searchMulti(val);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showlist = !showlist;
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
        child: Column(
          children: [
            // ===================== SEARCH BAR =====================
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.3),
                    Colors.pinkAccent.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.redAccent.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: TextField(
                autofocus: false,
                controller: searchtext,
                onSubmitted: (value) {
                  searchresult.clear();
                  setState(() {
                    val1 = value;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                onChanged: (value) {
                  searchresult.clear();
                  setState(() {
                    val1 = value;
                  });
                },
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search,
                      color: Colors.redAccent, size: 26),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.white54, size: 22),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Pencarian dihapus",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                      setState(() {
                        searchtext.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                  ),
                  hintText: 'Cari film, acara TV...',
                  hintStyle: const TextStyle(color: Colors.white54, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ===================== SEARCH RESULTS =====================
            searchtext.text.isNotEmpty
                ? FutureBuilder(
                    future: searchlistfunction(val1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: searchresult.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = searchresult[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              descriptioncheckui(
                                                item['id'],
                                                item['media_type'],
                                              )));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.redAccent.withOpacity(0.3),
                                        width: 0.6),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Poster
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${item['poster_path']}',
                                          width: 120,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Info
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Judul
                                              Text(
                                                item['media_type']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star_rounded,
                                                      color: Colors.redAccent,
                                                      size: 18),
                                                  const SizedBox(width: 5),
                                                  ratingtext(
                                                      '${item['vote_average']}'),
                                                  const SizedBox(width: 10),
                                                  const Icon(Icons.people_outline,
                                                      color: Colors.white54,
                                                      size: 18),
                                                  const SizedBox(width: 5),
                                                  ratingtext(
                                                      '${item['popularity']}'),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: Text(
                                                  item['overview'] ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                      height: 1.4),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                              onPressed: () {
                                setState(() {});
                              },
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
                        child: CircularProgressIndicator(
                          color: Colors.redAccent,
                        ),
                      );
                    }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
