// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islam/startup/sigin.dart';
import 'package:islam/startup/test.dart';
import 'package:islam/ui/bottomNav.dart';
import '../CustomWidgets/CustomAppBar.dart';
import '../backend/auth_services.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>(); //added

  final auth = FirebaseAuth.instance;
  final auth2 = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final phoneNumberControllerotp = TextEditingController();
  late final String verification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.grey, blurRadius: 5)]),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 33),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Name";
                              } else if (value.length < 3) {
                                return "Name is too short";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
                              labelText: "Enter Your Name",
                              hintStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),

//mobile no firebase

                          TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Mobile Number";
                              } else if (value.length < 10) {
                                return "number should contain only 10 digit";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(color: Colors.green),
                                labelText: "Mobile Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                    // Color:Colors.green,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 38),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                            onPressed: () {
                              auth.verifyPhoneNumber(
                                  phoneNumber:
                                      "+91${phoneNumberController.text}",
                                  verificationCompleted: (_) {},
                                  verificationFailed: (e) {
                                    print(e);
                                    Fluttertoast.showToast(
                                        msg: "$e",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  codeSent:
                                      (String verificationId, int? token) {
                                    verification = verificationId;
                                  },
                                  codeAutoRetrievalTimeout: (e) {
                                    print(e);

                                    Fluttertoast.showToast(
                                        msg: "$e",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                            },
                            child: Text(
                              "Send OTP",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 66, 179, 70)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //otp
                      SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.07,
                        // width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextField(
                          controller: phoneNumberControllerotp,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "OTP",
                              hintStyle: TextStyle(color: Colors.green),
                              labelText: "Enter OTP",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                  // Color:Colors.green,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 30, 40, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final credential = PhoneAuthProvider.credential(
                                verificationId: verification,
                                smsCode:
                                    phoneNumberControllerotp.text.toString());

                            try {
                              await auth2.signInWithCredential(credential);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bottomNav()));
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "error${e}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Make sure all the fields are filled ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 66, 179, 70)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.g_translate),
                      label: Text('Sign in with Google'),
                      onPressed: () async {
                        try {
                          // Sign in with Google and get the user's UserCredential
                          UserCredential userCredential =
                              await signInWithGoogle();

                          // Do something with the userCredential (e.g. navigate to a new screen)
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNav()));
                        } catch (e) {
                          // Handle sign-in errors (e.g. display an error message)
                          // ...
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 80),
                        ),
                        Center(
                          child: const Text(
                            "Already Have Account?",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signin()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
