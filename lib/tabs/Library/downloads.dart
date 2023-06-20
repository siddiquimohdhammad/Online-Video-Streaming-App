import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class downloadPage extends StatelessWidget {
  const downloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downlaod"),
      ),
  body: Container(
    child:Text("Download Page"),
  ),
    );
  }
}