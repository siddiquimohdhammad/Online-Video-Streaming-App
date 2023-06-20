import 'dart:async';
import 'package:flutter/material.dart';
import 'package:islam/startup/GetStarted.dart';

import '../backend/isLogin.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  firebase_login FireLogin = firebase_login();

  @override
  void initState() {
    // TODO: implement initState
    FireLogin.isLogin(context);
    super.initState();

  }

  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            
            decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/splash.png'),fit: BoxFit.fill)
            ),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/IslamicV.png',scale: 5       
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/image.png'),
            ),
          ),
        ],
      
    );
  }
}
