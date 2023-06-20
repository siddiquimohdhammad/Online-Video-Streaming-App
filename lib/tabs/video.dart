import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:islam/tabs/Library/saved.dart';
import 'package:video_player/video_player.dart';
import 'package:share/share.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../constant/constant.dart';
import '../startup/Registe12r.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<dynamic> videos = [];
  List<dynamic> filteredVideos = []; // List to store filtered videos
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final response =
        await http.get(Uri.parse('${Constant.backendUrl}videos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        videos = data['videos'];
      });
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to fetch videos');
    }
  }

  void filterVideos(String text) {
    setState(() {
      searchText = text;
      filteredVideos = text.isEmpty
          ? List.from(videos) // Fetch all videos when search text is empty
          : videos
              .where((video) =>
                  video['title'].toLowerCase().contains(text.toLowerCase()) ||
                  video['description']
                      .toLowerCase()
                      .contains(text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
     final auth = FirebaseAuth.instance;
    return FocusScope(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => register()),
                );
              },
              icon: Icon(Icons.logout_rounded)),
          //second button

        ],
      ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) => filterVideos(text),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                //  width: _isFullScreen ? MediaQuery.of(context).size.width : null,
                itemCount: filteredVideos.length,
                itemBuilder: (context, index) {
                  final video = filteredVideos[index];
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 198, 255, 198), // light green
                          Color.fromARGB(255, 179, 255, 216), // olive green
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      title: Text(
                        filteredVideos[index]['title'],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          filteredVideos[index]['description'],
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),

                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          // Handle options here
                          if (value == 'delete') {
                            // Perform delete operation
                          } else if (value == 'rename') {
                            // Perform rename operation
                          } else if (value=='later'){
                             WatchLaterItem item = WatchLaterItem(
        title: filteredVideos[index]['title'],
        description: filteredVideos[index]['description'],
        videoUrl: filteredVideos[index]['url'],
      );
        savedVideos.add(item);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Video Saved'),
            content: Text('The video has been saved to Watch Later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    
                          } 
                          else if (value == 'share') {
                            Share.share('Check out this cool content on social media!',
                  subject: 'Share on Social Media');
                            // Perform share operation
                             // position of the sharing dialog
                          } 
                       Future<void> myFunction() async {
  // code that uses the await keyword
   if (value == 'download') {
    
  }
}

                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'delete', // value that identifies this option
                            child: ListTile(
                              leading: Icon(Icons.delete,
                                  color: Colors
                                      .red), // icon for the option with red color
                              title: Text(
                                'Delete',
                                style: TextStyle(
                                    color:
                                        Colors.red), // text color for the option
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'rename', // value that identifies this option
                            child: ListTile(
                              leading: Icon(Icons.edit,
                                  color: Colors
                                      .blue), // icon for the option with blue color
                              title: Text(
                                'Rename',
                                style: TextStyle(
                                    color:
                                        Colors.blue), // text color for the option
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'share',
                            child: ListTile(
                              leading: Icon(Icons.share,
                                  color: Colors
                                      .green),
                              title: Text(
                                'Share',
                                style: TextStyle(
                                    color: Colors
                                        .green), 
                              ),
                            ),
                          ),
                            PopupMenuItem<String>(
                            value: 'later', 
                            child: ListTile(
                              leading: Icon(Icons.save_alt_outlined,
                                  color: Colors
                                      .blue), 
                              title: Text(
                                'Save To Watch Later',
                                style: TextStyle(
                                    color: Colors
                                        .blue), 
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'download', 
                            child: ListTile(
                              leading: Icon(Icons.download,
                                  color: Color.fromARGB(255, 33, 243, 65)), 
                              title: Text(
                                'Download',
                                style: TextStyle(
                                    color: Colors
                                        .blue), 
                              ),
                            ),
                          ),
                        ],
                        
                      ),

                      
                      leading: Icon(Icons.video_library_outlined),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return VideoPlayerPage(filteredVideos[index]['url']);
                        }));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage(this.videoUrl);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  String _getVideoDurationString() {
    Duration duration = _controller.value.duration;
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    String durationString = "$minutes:$seconds";
    return durationString;
  }

  String _getVideoPositionString() {
    Duration position = _controller.value.position;
    int minutes = position.inMinutes;
    int seconds = position.inSeconds % 60;
    String positionString = "$minutes:$seconds";
    return positionString;
  }

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isFullScreen = false;
  bool _showButtons = true;
  int _likes = 0;
  int _dislikes = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _startTimer();
  }

  void _startTimer() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        _showButtons = false;
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _showButtons = true;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Video Player')),
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
            _resetTimer();
          });
        },
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                width: _isFullScreen ? MediaQuery.of(context).size.width : null,
                height:_isFullScreen ? MediaQuery.of(context).size.height : null,
                child: AspectRatio(
                  //  aspectRatio:2.2 ,
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      VideoPlayer(_controller),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        padding:
                            EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                        colors: VideoProgressColors(
                          playedColor: Color.fromARGB(255, 95, 244, 54),
                          bufferedColor: Colors.blue,
                          backgroundColor: Color.fromARGB(255, 158, 158, 158),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              _getVideoDurationString(), // Display video duration
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              _getVideoPositionString(), // Display current video position
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
// Slider(
//   value: _controller.value.position.inSeconds.toDouble(),
//   min: 0.0,
//   max: _controller.value.duration.inSeconds.toDouble(),
//   onChanged: (value) {
//     setState(() {
//       _controller.seekTo(Duration(seconds: value.toInt()));
//     });
//   },
// ),
                      if (_showButtons && !_controller.value.isPlaying)
                        Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.play();
                              });
                              _resetTimer();
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),
                      if (_showButtons && _controller.value.isPlaying)
                        Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.pause();
                              });
                              // _resetTimer();
                            },
                            icon: Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 26, horizontal: 0),
                            onPressed: () {
                              setState(() {
                                _isFullScreen = !_isFullScreen;
                                if (_isFullScreen) {
                                  SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.leanBack,
                                      overlays: []);
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.landscapeLeft,
                                    DeviceOrientation.landscapeRight,
                                    // AspectRatio(aspectRatio: 2.0),
                                  ]);
                                } else {
                                  SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.manual,
                                      overlays: SystemUiOverlay.values);
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                  ]);
                                }
                              });
                              _resetTimer();
                            },
                            icon: Icon(
                              _isFullScreen
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // verticalDirection: VerticalDirection.up,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: _showButtons ? 1.0 : 1.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // verticalDirection: VerticalDirection.up,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 26, horizontal: 0),
                                  onPressed: () {
                                    setState(() {
                                      final newPosition =
                                          _controller.value.position -
                                              Duration(seconds: 5);
                                      _controller.seekTo(newPosition);
                                    });
                                    _resetTimer();
                                  },
                                  icon: Icon(
                                    Icons.replay_5_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      final newPosition =
                                          _controller.value.position +
                                              Duration(seconds: 5);
                                      _controller.seekTo(newPosition);
                                    });
                                    _resetTimer();
                                  },
                                  icon: Icon(
                                    Icons.forward_5_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                 
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
