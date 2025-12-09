// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:chanmovie/SqfLitelocalstorage/NoteDbHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../DetailScreen/checker.dart';

class FavoriateMovies extends StatefulWidget {
  const FavoriateMovies({super.key});

  @override
  State<FavoriateMovies> createState() => _FavoriateMoviesState();
}

class _FavoriateMoviesState extends State<FavoriateMovies> {
  int svalue = 1;
  
  VoidCallback? get _retry => null;

  SortByChecker(int sortvalue) {
    if (sortvalue == 1) {
      return FavMovielist().queryAllSortedDate();
    } else if (sortvalue == 2) {
      return FavMovielist().queryAllSorted();
    } else if (sortvalue == 3) {
      return FavMovielist().queryAllSortedRating();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),

      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color(0xff1A1A1A),
        centerTitle: true,
        title: const Text(
          'Favorite Movies',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// SORT ROW
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F1F1F),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.pinkAccent, width: 0.6),
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      iconEnabledColor: Colors.white,
                      dropdownColor: const Color(0xff1E1E1E),
                      value: svalue,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('View All',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Sort by Name',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('Sort by Rating',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          svalue = value as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// DATA
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,

                child: FutureBuilder(
                  future: SortByChecker(svalue),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.pinkAccent,
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
                              onPressed: _retry,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                              ),
                              child: const Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent.shade700,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),

                            onDismissed: (direction) {
                              FavMovielist().delete(snapshot.data![index]['id']);

                              Fluttertoast.showToast(
                                msg: "Deleted from Favorite",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            key: UniqueKey(),

                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return descriptioncheckui(
                                      snapshot.data![index]['tmdbid'].toString(),
                                      snapshot.data![index]['tmdbtype'].toString(),
                                    );
                                  },
                                ));
                              },

                              child: Card(
                                color: const Color(0xff1C1C1C),
                                elevation: 4,
                                shadowColor: Colors.pinkAccent.withOpacity(.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: Colors.pinkAccent.withOpacity(.3),
                                  ),
                                ),

                                child: ListTile(
                                  textColor: Colors.white,
                                  title: Text(
                                    snapshot.data![index]['tmdbname'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),

                                  subtitle: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.yellow,
                                        size: 19,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        snapshot.data![index]['tmdbrating'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),

                                  trailing: Text(
                                    snapshot.data![index]['tmdbtype'],
                                    style: TextStyle(
                                      color: Colors.pinkAccent.shade200,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pinkAccent,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
