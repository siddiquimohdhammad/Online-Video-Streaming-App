
import 'package:flutter/material.dart';
import 'package:islam/CustomWidgets/CustomAppBar.dart';
import 'package:islam/tabs/Library/downloads.dart';
import 'package:islam/tabs/Library/history.dart';
import 'package:islam/tabs/Library/saved.dart';


class LIBRARYs extends StatelessWidget {
  List<IconData> Icondata = [
    Icons.cast_sharp,
    Icons.notifications,
    Icons.search,
    Icons.account_circle,
  ];
  @override
  Widget build(BuildContext context) {

    Widget _userHistory(){
      return Card(
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 8),
              // elevation: 50,
              color: Colors.grey,
              child: Container(
              child: Text("History"),
              width: 200,
              height: 100,
              ),
            );

    }

    return FocusScope(
      child: Scaffold(
                backgroundColor: Colors.white,
    
        appBar:PreferredSize(child: CustomAppBar(),
          preferredSize: Size.fromHeight(112),
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
                _userHistory(),
            ]),
          ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.green[600]),
              title: Text('History', style: TextStyle(color: Colors.green[600])),
              onTap: (){
                Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => historyPage()),
      );
              },
            ),
            ListTile(
              leading: Icon(Icons.play_circle_outline, color: Colors.green[600]),
              title:
                  Text('Your Videos', style: TextStyle(color: Colors.green[600])),
            ),
            ListTile(
              leading: Icon(Icons.vertical_align_bottom, color: Colors.green[600]),
              title: Text('Downloads', style: TextStyle(color: Colors.green[600])),
             onTap: () {
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => downloadPage()),
      );
             },
            ),
            ListTile(
              leading: Icon(Icons.layers_outlined, color: Colors.green[600]),
              title:
                  Text('Saved Videos', style: TextStyle(color: Colors.green[600])),
                  onTap: () {
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => savedLaterPage()),
      );
             },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline_sharp, color: Colors.green[600]),
              title:
                  Text('Liked Videos', style: TextStyle(color: Colors.green[600])),
            ),
            Divider(
              color: Colors.green,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Playlist',
                  style: TextStyle(
                    fontSize: 18,
                      color: Colors.green[600],
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
