// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:chanmovie/RepeatedFunction/repttext.dart';
import '../DetailScreen/MovieDetails.dart';
import '../DetailScreen/TvSeriesDetail.dart';

Widget sliderlist(List firstlistname, String categorytittle, String type, itemlength) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// TITLE
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 15, bottom: 10),
        child: tittletext(categorytittle), // hapus color: null
      ),

      /// SLIDER
      SizedBox(
        height: 250,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: itemlength,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (type == 'movie') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(id: firstlistname[index]['id']),
                    ),
                  );
                } else if (type == 'tv') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvSeriesDetails(id: firstlistname[index]['id']),
                    ),
                  );
                }
              },

              /// CARD
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${firstlistname[index]['poster_path']}",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.25),
                      BlendMode.darken,
                    ),
                  ),
                ),

                child: Stack(
                  children: [
                    /// DATE
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: datetext(firstlistname[index]["release_date"]),
                      ),
                    ),

                    /// RATING
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.withOpacity(.7),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            const SizedBox(width: 3),
                            ratingtext(firstlistname[index]['vote_average'].toString()),
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
      ),

      const SizedBox(height: 20),
    ],
  );
}
