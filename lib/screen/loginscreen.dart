import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseNewLocation.dart';
import 'OTPScreen.dart';
import 'Webview.dart';
import 'chooseLocation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  final phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height * 0.40,
                              child: Image.asset(
                                "assets/logintp.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/blackng.png',
                                        height: 30,
                                        width: double.infinity,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontFamily: "montserratbold",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                                  child: Text(
                                    'Enter your phone number to proceed',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontFamily: "montserratmedium",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left:20.0),
                                          child: Image.asset(
                                            "assets/india.png",
                                            fit: BoxFit.fitWidth,
                                            height: 23,
                                            width: 23,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 5,5),
                                          child: Text('+91',style: TextStyle(fontFamily: "montserratbold",fontSize: 18,letterSpacing:3.0)),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: phoneNumber,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(fontFamily: "montserratbold",fontSize: 18,letterSpacing:3.0),
                                            decoration: InputDecoration(
                                              fillColor: Colors.transparent,
                                              filled: true,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 18.0,fontFamily: "montserratbold",),
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      //Verify mobile number here
                                      if (phoneNumber.text.isEmpty) {
                                        showErrorDialog(context, 'Please enter mobile number.');
                                      } else {
                                        getDataFromAPI(phoneNumber.text);
                                      }

                                    },
                                  ),
                                ),
                                // Center(
                                //   child: Padding(
                                //     padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                //     child: Text(
                                //       'Or',
                                //       style: TextStyle(
                                //         fontSize: 16.0,
                                //         color: Colors.grey,
                                //         fontFamily: "montserratmedium",
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // //for order as guest
                                // GestureDetector(
                                //   onTap: () async {
                                //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                //     prefs.setInt('CustomerId', 000000);
                                //     prefs.setString('UniqueId', "DEMO1");
                                //     prefs.setString('Name', "Guest");
                                //     prefs.setString('Email', "guest@guest.com");
                                //     prefs.setString('MobileNo', "999999999");
                                //     prefs.setString('IsCleaner', "false");
                                //     prefs.setString('selectedlocatio', 'Choose City');
                                //
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 HomeScreen()));
                                //   },
                                //   child: Container(
                                //     margin: EdgeInsets.only(left: 80, right: 80, top: 0),
                                //     width: double.infinity,
                                //     height: 40,
                                //     alignment: Alignment.center,
                                //     child: Text('Skip Login', style: TextStyle(
                                //         fontSize: 16.0,
                                //         decoration: TextDecoration.underline,
                                //         fontWeight: FontWeight.w600,
                                //         fontFamily: 'montserratbold',
                                //         color: ConstantColors.newcolor13),),
                                //   ),
                                //   ),
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

  void getDataFromAPI(String mobilenumbers) async {
    String url =
        "https://goetc-dev.com/API/AccountAPI/LogonPhno?Mobile=" +mobilenumbers;
    url = url.replaceAll('+', '');
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(url);
    try{
      String msg = data['msg'];
      print(msg);
      if (msg=='success') {
        print("msgif");
        int CustomerId = data['CustomerId'];
        var UniqueId = data['UniqueId'];
        var Name = data['Name'];
        var Email = data['Email'];
        var MobileNo = data['MobileNo'];
        var IsCleaner = data['IsCleaner'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('CustomerId', CustomerId);
        prefs.setString('UniqueId', UniqueId);
        prefs.setString('Name', Name);
        prefs.setString('Email', Email);
        prefs.setString('MobileNo', MobileNo);
        prefs.setString('IsCleaner', IsCleaner);
        if(IsCleaner=='true'){
          prefs.setString('CleanerCities', data['CleanerCities']);
          prefs.setString('CleanerAreas', data['CleanerAreas']);
          prefs.setString('CleanerSocieties', data['CleanerSocieties']);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                      mobileNumber: phoneNumber.text
                          .toString())));
        }else {
          Fluttertoast.showToast(
              msg: "User not found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }catch(error){
      print("msgcatcj");
      print(""+error.toString());
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }

  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
