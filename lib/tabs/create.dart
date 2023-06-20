import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File? _file;
  File? _selectedFile;
  String? _fileName;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = _selectedFile!.path.split('/').last;
        _file = _selectedFile;
      });
    }
  }

  Future<String> _uploadFile() async {
    if (_file == null) return '';

    String fileName = _file!.path.split('/').last;
    Reference ref = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = ref.putFile(_file!);
    TaskSnapshot snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    return '';
  }

  Future<void> _uploadToDatabase(
      String title, String description, String downloadUrl) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('Videos')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    databaseReference
        .set({'title': title, 'description': description, 'url': downloadUrl});
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:90,horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              maxLength: 15,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'description',
                border: OutlineInputBorder(),
              ),
            ),
SizedBox(
  height: 100,
),
            //file select
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize:Size(150, 50) ,
              ),
              onPressed: () async {
                await _pickFile();
              },
              child: Text('Select',
              style: TextStyle(fontSize: 18),
              
              ),
            ),
            if (_fileName != null)
              Text(
                _fileName!,
                style: TextStyle(fontSize: 18),
              ),


              SizedBox(height: 18,),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize:Size(150, 50) ,
                
              ),
              onPressed: () async {
                try {
                  String downloadUrl = await _uploadFile();
                  _uploadToDatabase(titleController.text.toString(),
                      descriptionController.text.toString(), downloadUrl);
                  Fluttertoast.showToast(
                      msg: "Successful",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  titleController.clear();
                  descriptionController.clear();
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: "check internet connection",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Text('Upload',
              style: TextStyle(fontSize: 18),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
