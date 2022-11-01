import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Downloadinvocie.dart';
import 'HomeScreen.dart';

class OtherSereen extends StatefulWidget {



  @override
  _PaymentConfirmationState createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<OtherSereen> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: ConstantColors.newcolor,
              title: Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.transparent,
                          child: Stack(children: [
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen()),
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 8, 0),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      HomeScreen()),
                                                  (Route<dynamic> route) => false);
                                        },
                                        child: Image.asset(
                                          "assets/leftArrowWhite.png",
                                          fit: BoxFit.fitWidth,
                                          height: 23,
                                          width: 23,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'GOETC',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: 'montserratbold',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ]),
                ],
              ),
            ),

            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/bottom.png'),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Image.asset(
                                  'assets/success.png',
                                  height: 90,
                                  width: 90,
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 8),
                                  child: Text(
                                    'Thank you For Choosing Our Service.One of Our team Will Contact you shortly.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: ConstantColors.black),
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 8),
                                  child: Text(
                                    'Do you Need Help?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: ConstantColors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                 padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Row(
                                    children: <Widget>[

                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/call.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Call Us',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: ConstantColors.black),
                                              ),GestureDetector(
                                                onTap: (){
                                                  launch(('tel://18001234382'));
                                                },
                                                child: Text(
                                                  '18001234382',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 17,
                                                      color: ConstantColors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/emaill.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                'Email Us',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: ConstantColors.black),
                                              ),GestureDetector(
                                                onTap: () async {
                                                  final Uri params = Uri(
                                                    scheme: 'mailto',
                                                    path: 'support@goetc.in',
                                                    query: 'subject=App Feedback', //add subject and body here
                                                  );
                                                  var url = params.toString();
                                                  await launch(url);
                                                },
                                                child: Text(
                                                  'support@goetc.in',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 17,
                                                      color: ConstantColors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),

                                Container(
                                  margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    onPressed: (){
                                      //
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen()),
                                              (Route<dynamic> route) => false);
                                    },
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/leftArrowWhite.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'BACK TO HOME',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,

                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
