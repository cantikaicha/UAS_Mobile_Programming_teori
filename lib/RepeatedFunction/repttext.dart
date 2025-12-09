// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';

/// GLOBAL COLOR ACCENT (Pink Netflix)
const Color accentPink = Color(0xFFFF296D);

/// Title Besar
Widget tittletext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto',
      color: color.withOpacity(.95),
      fontSize: 22,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8,
    ),
  );
}

/// Bold Text
Widget boldtext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.9),
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    ),
  );
}

/// Normal Text
Widget normaltext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.9),
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
    ),
  );
}

/// Date Text
Widget datetext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.7),
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.6,
    ),
  );
}

/// Rating Text + Accent Pink
Widget ratingtext(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontFamily: 'Open Sans',
      color: accentPink,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.9,
    ),
  );
}

/// ULTRA BIG title
Widget ultratittletext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.95),
      fontSize: 26,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.0,
    ),
  );
}

/// Genre Text
Widget genrestext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.9),
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
  );
}

/// Description / Overview
Widget overviewtext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(.85),
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 0.7,
    ),
  );
}

/// Tabbar
Widget Tabbartext(String title, {Color color = Colors.white}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Open Sans',
      color: color.withOpacity(1),
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
  );
}
