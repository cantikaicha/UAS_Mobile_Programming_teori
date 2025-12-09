// ignore_for_file: must_be_immutable, deprecated_member_use, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chanmovie/SqfLitelocalstorage/NoteDbHelper.dart';
import 'package:chanmovie/RepeatedFunction/repttext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class addtofavoriate extends StatefulWidget {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var id, type, Details;
  addtofavoriate({super.key, this.id, this.type, this.Details});

  @override
  State<addtofavoriate> createState() => _addtofavoriateState();
}

class _addtofavoriateState extends State<addtofavoriate> {
  Color favoriatecolor = Colors.white;

  Future checkfavoriate() async {
    final value = await FavMovielist().search(
      widget.id.toString(),
      widget.Details[0]['title'].toString(),
      widget.type,
    );

    setState(() {
      favoriatecolor = value == 0 ? Colors.white : Colors.redAccent;
    });
  }

  addatatbase() async {
    String name = widget.Details[0]['title'].toString();
    String rating = widget.Details[0]['vote_average'].toString();
    String id = widget.id.toString();
    String type = widget.type;

    if (favoriatecolor == Colors.white) {
      await FavMovielist().insert({
        'tmdbid': id,
        'tmdbtype': type,
        'tmdbname': name,
        'tmdbrating': rating,
      });
      favoriatecolor = Colors.redAccent;

      Fluttertoast.showToast(
        msg: "Added to Favorite ❤️",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      await FavMovielist().deletespecific(id, type);
      favoriatecolor = Colors.white;

      Fluttertoast.showToast(
        msg: "Removed from Favorite 💔",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkfavoriate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Favorite Button
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: favoriatecolor,
                size: 35,
              ),
              onPressed: addatatbase,
            ),
          ),

          /// Share Button
          GestureDetector(
            onTap: () => _openShareDialog(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(.8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.share, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  normaltext("Share")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openShareDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: normaltext("Share"),
          content: SizedBox(
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Social Media Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _socialIcon(
                      FontAwesomeIcons.facebook,
                      Colors.blue,
                      () async {
                        await launchUrl(Uri.parse(
                            "https://www.facebook.com/sharer/sharer.php?u=https://www.themoviedb.org/$widget.type/$widget.id"));
                      },
                    ),
                    _socialIcon(
                      FontAwesomeIcons.whatsapp,
                      Colors.green,
                      () async {
                        await launchUrl(Uri.parse(
                            "https://wa.me/?text=Check%20out%20this:%20https://www.themoviedb.org/$widget.type/$widget.id"));
                      },
                    ),
                    _socialIcon(
                      FontAwesomeIcons.linkedin,
                      Colors.blue,
                      () async {
                        await launchUrl(Uri.parse(
                            "https://www.linkedin.com/shareArticle?mini=true&url=https://www.themoviedb.org/$widget.type/$widget.id"));
                      },
                    ),
                    _socialIcon(
                      FontAwesomeIcons.twitter,
                      Colors.lightBlueAccent,
                      () async {
                        await launchUrl(Uri.parse(
                            "https://twitter.com/intent/tweet?text=Check%20out%20this%20link:%20https://www.themoviedb.org/$widget.type/$widget.id"));
                      },
                    ),
                  ],
                ),

                /// Copy Link Button
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(
                      text: "https://www.themoviedb.org/$widget.type/$widget.id",
                    ));
                    Navigator.pop(context);

                    Fluttertoast.showToast(
                      msg: "Link Copied ✅",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.link, color: Colors.white),
                        const SizedBox(width: 10),
                        normaltext("Copy Link"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _socialIcon(icon, color, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 24,
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
