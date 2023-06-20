import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islam/tabs/create.dart';
import 'package:islam/tabs/home.dart';
import 'package:islam/tabs/library.dart';

import '../tabs/subscription.dart';
import '../tabs/upload .dart';
import '../tabs/video.dart';

class bottomNav extends StatefulWidget {
  const bottomNav({Key? key}) : super(key: key);

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  int currentIndex = 0;
  final screen = [
    VideoPage(),
    Text('first4'),
    UploadVideoScreen(),
    subscriptionPage(),
    LIBRARYs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(245, 52, 164, 40),
          selectedItemColor: Color.fromARGB(255, 16, 56, 2),
          unselectedItemColor: Colors.white,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              label: 'SUBSCRIPTION',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_add_sharp),
              label: 'Library',
            ),
          ]),
    );
  }
}
