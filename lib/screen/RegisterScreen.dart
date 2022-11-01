import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseNewLocation.dart';
import 'HomeScreen.dart';
import 'OTPScreen.dart';
import 'Webview.dart';
import 'chooseLocation.dart';

class RegisterScreen extends StatefulWidget {
  var mobileNumber;

  RegisterScreen({this.mobileNumber});

  @override
  _LoginScreen createState() => _LoginScreen();

}

class _LoginScreen extends State<RegisterScreen> {

  final phoneNumber = TextEditingController();
  final emailid = TextEditingController();
  final yourname = TextEditingController();
  bool isChecked = true;
  var fltrNotification;

  @override
  void initState() {
    super.initState();
    phoneNumber.text=widget.mobileNumber;
    var androidInitilize = new AndroidInitializationSettings('bg');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
  }


  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer",importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await fltrNotification.show(
        0, "GOETC", "Thank you for registering with us",
        generalNotificationDetails, payload: "Task");
  }
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
                                  padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'roboto',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: TextField(
                                    controller: phoneNumber,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Mobile Number',
                                      hintText: 'Enter Mobile Number',
                                      fillColor: ConstantColors.whiteBg,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: TextField(
                                    controller: yourname,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Your Name',
                                      hintText: 'Enter Your Name',
                                      fillColor: ConstantColors.whiteBg,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: TextField(
                                    controller: emailid,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email Address',
                                      hintText: 'Enter Email Address',
                                      fillColor: ConstantColors.whiteBg,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
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
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      //Verify mobile number here
                                      if(isChecked) {
                                        if (phoneNumber.text.isEmpty) {
                                          showErrorDialog(context,
                                              'Please enter mobile number.');
                                        }
                                        if (emailid.text.isEmpty) {
                                          showErrorDialog(
                                              context, 'Please enter emailid.');
                                        }
                                        if (yourname.text.isEmpty) {
                                          showErrorDialog(context,
                                              'Please enter mobile number.');
                                        } else {
                                          verifyregisteration();
                                        }
                                      }else{
                                        showErrorDialog(context,
                                            'Please accept terms and conditions to proceed');
                                      }
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'By clicking. I accept ',
                                                  style: TextStyle(
                                                      color: ConstantColors.greytext,
                                                      fontFamily: "montserratmedium",
                                                      fontSize: 14.0),

                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => WebviewScreen(
                                                                WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=terms-of-use'
                                                                    .toString(),Title:'Terms & Conditions')));
                                                  },
                                                  child: Text(
                                                    'Terms of Use',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: 'montserratmedium',
                                                        fontSize: 13.0),
                                                  ),
                                                ),
                                                Text(
                                                  ' & ',
                                                  style: TextStyle(
                                                      color: ConstantColors.greytext,
                                                      fontFamily: 'montserratmedium',
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => WebviewScreen(
                                                            WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=privacy-policy'
                                                                .toString(),Title:'Privacy Policy')));
                                              },
                                              child: Text(
                                                'Privacy Policy',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily: 'montserratmedium',
                                                    fontSize: 13.0),
                                              ),
                                            ),
                                          ],),
                                      ),
                                    ],
                                  ),
                                ), //

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

  Future<void> verifyregisteration() async {
      String url1 = "https://goetc-dev.com/API/AccountAPI/Signup";
      print(url1);
      Map<String, dynamic> body = {
        'Name': '' + yourname.text,
        'Email': '' + emailid.text,
        'MobileNo': '' + widget.mobileNumber.toString(),
      };
      print('registration api: ' + body.toString());
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final encoding = Encoding.getByName('utf-8');

      final jsonString = json.encode(body);
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
      if (msg == "Success") {
        int CustomerId = data1['CustomerId'];
        var UniqueId = data1['UniqueId'];
        var Name = yourname.text;
        var Email = emailid.text;
        var MobileNo = widget.mobileNumber.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('CustomerId', CustomerId);
        prefs.setString('UniqueId', UniqueId);
        prefs.setString('Name', Name);
        prefs.setString('Email', Email);
        prefs.setString('MobileNo', MobileNo);
        prefs.setString('IsCleaner', 'false');
        _showNotification();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ChooseNewLocations()),
            ModalRoute.withName('/'));

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
