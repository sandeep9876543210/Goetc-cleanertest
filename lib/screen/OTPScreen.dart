import 'dart:convert';
import 'dart:math';

import 'package:auto_sms_verification/auto_sms_verification.dart';
import 'package:countdown_widget/countdown_widget.dart';
import 'package:goetc/Cleaner/CleanerHomeScreen.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/HomeScreen.dart';
import 'package:goetc/screen/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseNewLocation.dart';
import 'ProviderHome.dart';
import 'chooseLocation.dart';

class OTPScreen extends StatefulWidget {
  var mobileNumber;

  OTPScreen({this.mobileNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final phoneNumber = TextEditingController();
  var code;
  String signature='';

  @override
  void initState() {
    super.initState();

    if(widget.mobileNumber=="7777777777"){

    }else {
    //  hitOtp();
    }
    _startListeningSms();

  }

  _startListeningSms() async {
    String? otp = await AutoSmsVerification.startListeningSms();
    if (otp!.isNotEmpty || otp != null) {
      print(''+otp);
      print(''+otp.replaceAll("<#> Login Verification code for GOETC app is ", "").replaceAll(" "+signature, ""));
      print(''+otp.replaceAll("<#> Verification code for Storm Overseas Education is : ", "").replaceAll(" "+signature, ""));
      String numbercodes = widget.mobileNumber;
      print(numbercodes);
      getDataFromAPI(numbercodes);
    }
  }

/*  void hitOtp() async{
    print('hdfufdhjdfjd');
    signature = (await AutoSmsVerification.appSignature())!;
    var rng = new Random();
    code = rng.nextInt(900000) + 100000;
    String url='https://api.textlocal.in/send/?apikey=NjM2YzQyNzU0ZjU2NjIzMTUxNDE0OTY3NWE0YjUwNzQ=&sender=GOETC&numbers='+widget.mobileNumber+'&message=%3C%23%3E%20Login%20Verification%20code%20for%20GOETC%20app%20is%20'+code.toString()+' '+signature.replaceAll("+", "%2B");
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    print(data);
    print(url);
    print('signature: '+signature);
    String msg=data['status'];
    print(msg);
    if(msg=="success"){

    }

  }*/

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color(0xFFFFFFF),
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(
      color: Color(0xFF0063AD),
    ),
  );



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                Text(
                                  'Verification Code',
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      fontFamily: 'montserratbold',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'We have send the verification code\n to Your Mobile Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                    fontSize: 14.0, color: Colors.grey,
                                    fontFamily: 'montserratmedium',
                                  ),
                                ),SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ''+ widget.mobileNumber,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'montserratbold',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: new PinPut(
                                      fieldsCount: 6,
                                      withCursor: true,
                                      textStyle: TextStyle(fontSize: 25.0, color: Color(0xFF000000)),
                                      eachFieldWidth: 40.0,
                                      eachFieldHeight: 51.0,
                                      onSubmit: (String pin) => clickOnLogin(context,pin),
                                      controller: _pinPutController,
                                      focusNode: _pinPutFocusNode,
                                      submittedFieldDecoration: pinPutDecoration,
                                      selectedFieldDecoration: pinPutDecoration,
                                      followingFieldDecoration: pinPutDecoration,
                                      pinAnimationType: PinAnimationType.fade,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 10.0, 15.0, 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '00:',
                                        style: TextStyle(
                                            color: ConstantColors.greytext,
                                            fontFamily: 'montserratmedium',
                                            fontSize: 13.0),
                                      ),
                                      CountDownWidget(
                                        duration: Duration(seconds: 25),
                                        builder: (context, duration) {
                                          return Text(duration.inSeconds.toString());
                                        },
                                        onDurationRemainChanged: (duration) {
                                          Text(
                                            '${duration.toString()}',
                                            style: TextStyle(
                                                color: ConstantColors.greytext,
                                                fontFamily: 'montserratmedium',
                                                fontSize: 13.0),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                              msg: "OTP resent successfully",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        //  hitOtp();
                                        },
                                        child: Text(
                                          'Resend OTP',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'montserratmedium',
                                              fontSize: 14.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Text(
                                      'ENTER OTP',
                                      style: TextStyle(fontSize: 18.0,
                                        fontFamily: 'montserratbold',),
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        String numbercodes = widget.mobileNumber;
                                        print(numbercodes);
                                        getDataFromAPI(numbercodes);
                                      });

                                    },
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

  Future<void> clickOnLogin(BuildContext context,String pin) async {
    if (widget.mobileNumber.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      if(widget.mobileNumber=='7777777777'){
        if (pin == '123456') {
          String numbercodes = widget.mobileNumber;
          print(numbercodes);
          getDataFromAPI(numbercodes);
        }else {
          Fluttertoast.showToast(
              msg: "Invalid Verification code",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }else {
        if (pin == 123456) {
          String numbercodes = widget.mobileNumber;
          print(numbercodes);
          getDataFromAPI(numbercodes);
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Verification code",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }


    }
  }

  void getDataFromAPI(String mobilenumbers) async {
    String url =
        "https://goetc-dev.com/API/AccountAPI/LogonPhno?Mobile=" +
            widget.mobileNumber;
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
        }
        if(IsCleaner=='true'){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CleanerHomeScreen()),
              ModalRoute.withName('/'));
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
        print("msgelse");
        print(phoneNumber.text);

      }
    }catch(error){
      print("msgcatcj");
      print(""+error.toString());

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
          child: const Text('Yes'),
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

