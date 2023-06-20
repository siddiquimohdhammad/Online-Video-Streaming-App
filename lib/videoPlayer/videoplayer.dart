import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrls;
  const VideoPlayer({Key? key, required this.videoUrls}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  // String videoUrl =
  //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrls)
      ..initialize().then((value) => setState(() {}));
      AspectRatio : 16/9;
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
  
        
          child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController
          ),
        ),
    );
  
  }
}