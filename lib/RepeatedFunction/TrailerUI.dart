// ignore_for_file: file_names, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class trailerwatch extends StatefulWidget {
  var trailerytid;
  trailerwatch({super.key, this.trailerytid});

  @override
  State<trailerwatch> createState() => _trailerwatchState();
}

class _trailerwatchState extends State<trailerwatch> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoid = YoutubePlayer.convertUrlToId(widget.trailerytid);

    _controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags: const YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          controlsTimeOut: const Duration(milliseconds: 1500),

          /// ✅ Thumbnail
          thumbnail: Image.network(
            "https://img.youtube.com/vi/${widget.trailerytid}/hqdefault.jpg",
            fit: BoxFit.cover,
          ),

          showVideoProgressIndicator: true,

          /// ✅ BUFFER LOADER
          bufferIndicator: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(.6),
              ),
              padding: const EdgeInsets.all(18),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),
            ),
          ),

          /// ✅ Progress bar custom style
          progressIndicatorColor: Colors.pinkAccent,

          bottomActions: const [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.pinkAccent,
                handleColor: Colors.white,
                backgroundColor: Colors.grey,
                bufferedColor: Colors.white24,
              ),
            ),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
      ),
    );
  }
}
