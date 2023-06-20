// import 'package:frontend/video.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islam/constant/constant.dart';
import 'package:islam/tabs/video.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';


class UploadVideoScreen extends StatefulWidget {
  @override
  _UploadVideoScreenState createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _video;
  VideoPlayerController? _videoController;

  Future<void> _pickVideo() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_video!);
        _videoController!.initialize().then((_) {
          setState(() {});
        });
      } else {
        print('No video selected.');
      }
    });
  }

  Future<void> _uploadVideo() async {
    
    if (_formKey.currentState!.validate()) {
      final uri = Uri.parse('${Constant.backendUrl}upload');
      final videoStream =
          // ignore: deprecated_member_use
          http.ByteStream(DelegatingStream.typed(_video!.openRead()));
      final videoLength = await _video!.length();
      final request = http.MultipartRequest('POST', uri);
      final multipartFile = http.MultipartFile(
          'video', videoStream, videoLength,
          filename: path.basename(_video!.path));
      request.files.add(multipartFile);
      request.fields['title'] = _titleController.text;
      request.fields['description'] = _descriptionController.text;
      final response = await request.send();
if (response.statusCode == 200) {
  print('Video uploaded successfully');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Video uploaded successfully'),
      backgroundColor: Colors.green,
    ),
  );
}

 else {
  print('Error uploading video');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Error uploading video'),
      backgroundColor: Colors.red,
    ),
  );
}

    }
    
  }
  

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _video == null
                    ? Text('No video selected.')
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayer(_videoController!),
                      ),
                SizedBox(height: 16),
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: _pickVideo,
          child: Text('Select Video From Gallery'),
        ),
      ),
    ),
  ],
),

                SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: _uploadVideo,
          child: Text('Upload'),
        ),
      ),
    ),
  ],
),

      //  SizedBox(height: 16),
      //            ElevatedButton(
      //     onPressed: () => Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) =>  VideoPage())),
      //     child: const Text('Raised Button'),
          
      //   ),
              ],
            ),
          ),
        
        ),
      ),
       
    );
  }
}
