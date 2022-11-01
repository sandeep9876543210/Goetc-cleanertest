import 'dart:convert';
import 'dart:math';

import 'package:countdown_widget/countdown_widget.dart';
import 'package:goetc/Cleaner/taskCompleted.dart';
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

import 'ChooseSlot.dart';
import 'ProviderHome.dart';
import 'chooseLocation.dart';

class OTPVerificationScreen extends StatefulWidget {

  var CustomerId;
  var MobileNo;
  var ServiceBookId;
  var BookingId;
  var otp;

  OTPVerificationScreen({this.CustomerId,this.MobileNo,this.ServiceBookId,this.BookingId,this.otp});

  @override
  _OTPScreenState createState() => _OTPScreenState();

}

class _OTPScreenState extends State<OTPVerificationScreen> {

  final phoneNumber = TextEditingController();
  var code;
  int customerId1=0;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerId1 = prefs.getInt('CustomerId')!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }


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
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 8, 0),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
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
                                    'OTP Verification',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'montserratbold',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),                      ]),
                ],
              ),
            ),
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
                  Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [

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
                                'Verification Code to Start',
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
                                ''+widget.MobileNo.toString(),
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

                              Container(
                                margin:
                                EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                child: FlatButton(
                                  minWidth: double.infinity,
                                  height: 50,
                                  child: Text(
                                    'Verify OTP',
                                    style: TextStyle(fontSize: 18.0,
                                      fontFamily: 'montserratbold',),
                                  ),
                                  color: ConstantColors.newcolor,
                                  textColor: Colors.white,
                                  onPressed: () {

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
                ],
              ),
            )),
      ),
    );
  }

  Future<void> clickOnLogin(BuildContext context,String pin) async {
    if (widget.MobileNo.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      if(pin==widget.otp.toString()){
        String numbercodes = widget.MobileNo;
        print(numbercodes);
        verifyregisteration();
      }else{
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

  Future<void> verifyregisteration() async {
    String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingStatusInsertAPI";
    print(url1);
    Map<String, dynamic> body = {
      'BookingId': '' + widget.BookingId.toString(),
      'CleanerId': ''+customerId1.toString() ,
      'CustomerId': '' + widget.CustomerId.toString(),
      'BookingOtp': '' + widget.otp.toString(),
    };
    print('registration api: ' + body.toString());
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await post(
      Uri.parse(url1),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    Map data1 = jsonDecode(response.body);
    print(data1);
    print(url1);
    String msg = data1['msg'];
    if (msg == "success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskCompleted(
                CustomerId: widget.CustomerId.toString(),
                MobileNo:  widget.MobileNo.toString(),
                ServiceBookId:  widget.ServiceBookId.toString(),
                BookingId:  widget.BookingId.toString(),
                otp:  widget.otp.toString(),
              )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskCompleted(
                CustomerId: widget.CustomerId.toString(),
                MobileNo:  widget.MobileNo.toString(),
                ServiceBookId:  widget.ServiceBookId.toString(),
                BookingId:  widget.BookingId.toString(),
                otp:  widget.otp.toString(),
              )));
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return;
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}


