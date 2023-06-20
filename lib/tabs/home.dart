// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islam/startup/sigin.dart';

import '../backend/delete_user.dart';
import '../startup/Registe12r.dart';
import '../videoPlayer/videoplayer.dart';



class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Videos');
  final searchFilter = TextEditingController();

  Firebase_deleteUser accountDelete = Firebase_deleteUser();
  //for delete user
   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

      Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
              onPressed: () {
                accountDelete.deleteUser(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => signin()),
                  );
                });
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: Column(
            children: [
              // ListBuilder(),
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: Center(child: CircularProgressIndicator(backgroundColor: Colors.green,strokeWidth: 2,),),
                  itemBuilder: (context, snapshot, animation, index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                           SizedBox(
                            height: 5,
                            child: Divider(color: Colors.lightGreen,
                            thickness: 3,),
                          ),
                          VideoPlayer(videoUrls:snapshot.child('url').value.toString() ),
                          ListTile(
                            title: Text(snapshot.child('title').value.toString()),
                            subtitle: Text(snapshot.child('description').value.toString()),
                          ),
                          SizedBox(
                            height: 5,
                            child: Divider(color: Colors.lightGreen,
                            thickness: 3,),
                          ),
                          
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
// real time db coding starts
    );
  }

  
}


