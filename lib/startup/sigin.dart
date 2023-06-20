// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islam/startup/test.dart';
import 'package:islam/ui/bottomNav.dart';

import '../CustomWidgets/CustomAppBar.dart';
import 'Registe12r.dart';

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _MyLoginState();
}

class _MyLoginState extends State<signin> {
  
  final auth = FirebaseAuth.instance;
  final auth2 = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final phoneNumberControllerotp = TextEditingController();
  late final String verification;

  final _formKey = GlobalKey<FormState>(); //added
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
              child: Center(
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.grey, blurRadius: 3)]),
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextFormField(
                      controller: phoneNumberController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
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
                          hintText: "Enter Number",
                          labelText: "Enter Your Mobile Number",
                          hintStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          )),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: () {
                        auth.verifyPhoneNumber(
                            phoneNumber: "+91${phoneNumberController.text}",
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
                            codeSent: (String verificationId, int? token) {
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
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 1,
                child: ElevatedButton(
                  onPressed: () async {

                    if (_formKey.currentState!.validate()){
                          final credential = PhoneAuthProvider.credential(
                              verificationId: verification,
                              smsCode:
                                  phoneNumberControllerotp.text.toString());

                          try {
                            await auth2.signInWithCredential(credential);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomNav()));
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
                          }else {
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
                    "SIGN IN",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 66, 179, 70)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //  SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      " Don't have account?",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
                    },
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
