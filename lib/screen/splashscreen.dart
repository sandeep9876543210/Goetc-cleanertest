import 'dart:async';
import 'package:goetc/Cleaner/CleanerHomeScreen.dart';
import 'package:goetc/Cleaner/orderDetails.dart';
import 'package:goetc/Cleaner/taskCompleted.dart';
import 'package:goetc/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';

import 'chooseLocation.dart';
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2;

  var fltrNotification;
  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('bg');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
   // _appflayer();
    _loadWidget();
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

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? MobileNo = prefs.getString('MobileNo');
    prefs.setString('from', 'splash');
    try {
      Timer(
          Duration(seconds: 1),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
      if(MobileNo==null){
        Timer(Duration(seconds: 1),
                ()=>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) => LoginScreen()
                    )
                )
        );
      }else{
        String? selectedlocatio = prefs.getString('selectedlocatio');
        String? IsCleaner = prefs.getString('IsCleaner');

        if(IsCleaner=='true'){
          Timer(Duration(seconds: 1),
                  ()=>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) => CleanerHomeScreen()//HomeScreen()
                      )
                  )
          );
        }else{
          Timer(Duration(seconds: 1),
                  ()=>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) => CleanerHomeScreen()//HomeScreen()
                      )
                  )
          );
        }
      }
    } catch (error) {
      // _showNotification();
      Timer(
          Duration(seconds: 1),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height ,
              child: Image.asset("assets/bgg.png",fit: BoxFit.fill,),
            ),
            Center(child: Image.asset("assets/splashanimated.gif")),
            // new Container(
            //   decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //       image: new AssetImage("assets/bgg.png"),
            //       fit: BoxFit.fitWidth,
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            //   child: new Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Container(
            //           padding: new EdgeInsets.fromLTRB(60, 0, 60, 0),
            //           width: MediaQuery.of(context).size.width,
            //           height: MediaQuery.of(context).size.height * 0.30,
            //           child: Image.asset("assets/lo.png"),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
