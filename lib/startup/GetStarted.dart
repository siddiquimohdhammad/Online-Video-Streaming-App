
import 'package:flutter/material.dart';
import 'package:islam/startup/sigin.dart';

import '../CustomWidgets/CustomAppBar.dart';
import 'Registe12r.dart';


class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  List<String> quotes = [
    'Enjoy halal Videos and audios',
    'Original Content from Scholer',
    'Share it all with the world'
  ];

  Widget buildTitle(quote) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(60),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            spreadRadius: 1,
          )
        ],
      ),
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width*0.85,
      height: 90,
      child: Center(
        child: Text(
          "$quote",
          // ignore: prefer_const_constructors
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Text(
                "Welcome to\nIslamic Videos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  color: Color(0xff4da92b),
                  shadows: [
                    Shadow(
                      color: Color(0xff4da92b),
                      blurRadius: 5,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              for (var item in quotes) buildTitle(item),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              new SizedBox(
                height: MediaQuery.of(context).size.height*0.09,
                width: MediaQuery.of(context).size.width*0.6 ,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 70, 249, 5),
                      textStyle: TextStyle(
                        fontSize: 18,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>register()));
                    },
                    icon: Text(
                      'GET STARTED',
                    ),
                    label: Icon(Icons.forward)),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin()));
                  },
                  child: Text('Already have account? sign in'),
                  style: TextButton.styleFrom(
                    primary: Color(0xff4da92b),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
