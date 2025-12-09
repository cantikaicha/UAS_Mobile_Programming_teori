// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chanmovie/SectionHomeUi/FavoriateList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class drawerfunc extends StatefulWidget {
  const drawerfunc({super.key});

  @override
  State<drawerfunc> createState() => _drawerfuncState();
}

class _drawerfuncState extends State<drawerfunc> {
  File? _image;

  Future<void> SelectImage() async {}

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        _image = File(sp.getString('imagepath') ?? "");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF121212),
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  drawerTile('Home', Icons.home, () {
                    Navigator.pop(context);
                  }),

                  drawerTile('Favorite', Icons.favorite, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FavoriateMovies()));
                  }),

                  drawerTile('Our Blogs', FontAwesomeIcons.blogger, () {
                    openPage('Blogs');
                  }),

                  drawerTile('Our Website', FontAwesomeIcons.solidNewspaper, () {
                    openPage('Website');
                  }),

                  drawerTile('Subscribe Us', FontAwesomeIcons.youtube, () async {
                    var url =
                        'https://www.youtube.com/channel/UCeJnnsTq-Lh9E16kCEK49rQ?sub_confirmation=1';
                    await launchUrl(Uri.parse(url));
                  }),

                  drawerTile('About', Icons.info, () {
                    showAboutDialog(context: context);
                  }),

                  drawerTile('Quit', Icons.exit_to_app_rounded, () {
                    SystemNavigator.pop();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.redAccent.shade200,
            Colors.redAccent.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await SelectImage();
              Fluttertoast.showToast(
                msg: "Image Changed",
                gravity: ToastGravity.BOTTOM,
              );
            },
            child: CircleAvatar(
              radius: 45,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : const AssetImage('assets/user.png') as ImageProvider,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerTile(String title, IconData icon, Function ontap) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent.shade100),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.redAccent.shade100),
      onTap: () => ontap(),
      hoverColor: Colors.redAccent.withOpacity(0.15),
    );
  }

  void openPage(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(title),
          ),
          body: const Center(
            child: Text(
              'Coming Soon...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
