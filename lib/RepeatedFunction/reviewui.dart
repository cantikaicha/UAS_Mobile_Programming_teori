// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:chanmovie/RepeatedFunction/repttext.dart';

// ignore: must_be_immutable
class ReviewUI extends StatefulWidget {
  List revdeatils = [];
  ReviewUI({super.key, required this.revdeatils});

  @override
  State<ReviewUI> createState() => _ReviewUIState();
}

class _ReviewUIState extends State<ReviewUI> {
  bool showall = false;

  @override
  Widget build(BuildContext context) {
    List REviewDetails = widget.revdeatils;

    if (REviewDetails.isEmpty) {
      return const Center();
    } else {
      return Column(
        children: [
          /// HEADER
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'User Reviews',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showall = !showall;
                    });
                  },
                  child: Row(
                    children: [
                      showall == false
                          ? Text(
                              'All Reviews (${REviewDetails.length}) ',
                              style: const TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              'Show Less',
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.pinkAccent, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// LIST
          showall == true
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: REviewDetails.length,
                      itemBuilder: (context, index) {
                        return reviewCard(REviewDetails[index]);
                      }))
              : reviewCard(REviewDetails[0]),
        ],
      );
    }
  }

  /// UI CARD
  Widget reviewCard(Map item) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pinkAccent.withOpacity(.3), width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                /// IMG
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.pinkAccent.withOpacity(.5), width: 2),
                      image: DecorationImage(
                          image: NetworkImage(item['avatarphoto']),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 12),

                /// NAME + DATE
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['creationdate'],
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),

                /// RATING
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.star,
                            color: Colors.pinkAccent, size: 22),
                        const SizedBox(width: 5),
                        Text(
                          item['rating'],
                          style: const TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            ),

            const SizedBox(height: 12),

            /// REVIEW
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: overviewtext(item['review']),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
