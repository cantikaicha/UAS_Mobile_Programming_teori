// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:chanmovie/DetailScreen/MovieDetails.dart';
import 'TvSeriesDetail.dart';

// ignore: must_be_immutable
class descriptioncheckui extends StatefulWidget {
  // ignore: duplicate_ignore
  // ignore: prefer_typing_uninitialized_variables
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype, {super.key});

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype.toString() == 'movie') {
      return MovieDetails(
        id: widget.newid,
      );
    } else if (widget.newtype.toString() == 'tv') {
      return TvSeriesDetails(id: widget.newid);
    } else if (widget.newtype.toString() == 'person') {
      // return persondescriptionui(widget.id);
    } else {
      return errorui(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: const Center(
      child: Text('no Such page found'),
    ),
  );
}
