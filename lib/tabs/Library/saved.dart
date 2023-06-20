import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class WatchLaterItem {
  String title;
  String description;
  String videoUrl;

  WatchLaterItem({
    required this.title,
    required this.description,
    required this.videoUrl,
  });
}

List<WatchLaterItem> savedVideos = [];

class savedLaterPage extends StatefulWidget {
  const savedLaterPage({Key? key}) : super(key: key);

  @override
  State<savedLaterPage> createState() => _savedLaterPageState();
}

class _savedLaterPageState extends State<savedLaterPage> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Watch Later"),
        ),
        body: ListView.builder(
          itemCount: savedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.video_collection_outlined),
              title: Text(savedVideos[index].title),
              subtitle: Text(savedVideos[index].description),
              // trailing: ElevatedButton(),
               trailing: ElevatedButton(
              onPressed: () {
                // Remove button on press
                setState(() {
                  savedVideos.removeAt(index);
                });
              },
              child: Text("Remove"),
            ),              
            );
          },
        ),
      ),
    );
  }
}
