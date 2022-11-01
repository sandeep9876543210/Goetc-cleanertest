import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ChooseLocationsWashroom.dart';
import 'WashroomChoosePlans.dart';
import 'animated_custom_dialog.dart';
import 'guest_dialog.dart';

class WashroomDetails extends StatefulWidget {
  @override
  _WashroomDetails createState() => _WashroomDetails();
}

class _WashroomDetails extends State<WashroomDetails> {

  String currentlocation = '';
  final searchinput = TextEditingController();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  late PickResult selectedPlace;
  bool isLoading = false;
  bool _enabled = false;


  @override
  void initState() {
    super.initState();
    loaddata();
  }

  String Name = '';
  String Email = '';
  String MobileNo = '';
  int CustomerId = 0;

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
      Name = prefs.getString('Name')!;
      Email = prefs.getString('Email')!;
      MobileNo = prefs.getString('MobileNo')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    loadlatlong(''+ currentlocation);

    print('' + currentlocation);
  }


  double lat=17.3850,lng=78.4867;


  Future<void> loadlatlong(String societys) async {
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+societys+"&key=AIzaSyBA9yFkHCMgGONfhnCMaSxpbaMcqJasAYk";
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    var place_id;
    setState(() {
      place_id = jsonDecode(response1.body)['predictions'][0]['place_id'];
      print(place_id);
      getlatlong(place_id);
    });
  }

  Future<void> getlatlong(var paceid) async {
    String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id='+paceid+'&key=AIzaSyBA9yFkHCMgGONfhnCMaSxpbaMcqJasAYk';
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      lat = jsonDecode(response1.body)['result']['geometry']['location']['lat'];
      lng = jsonDecode(response1.body)['result']['geometry']['location']['lng'];
      print(''+lat.toString());
      print(''+lng.toString());
    });
  }

  late ProgressDialog pr;
  late WebViewController controller1;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
        message: 'Loading',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(10.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          backgroundColor: ConstantColors.white,
          bottomNavigationBar: Container(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                // margin:
                // EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),

                color: ConstantColors.newcolor,
                margin: const EdgeInsets.only(left: 5.0,right: 5),
                child: FlatButton(
                  minWidth: double.infinity,
                  height: 50,
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Service',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: ConstantColors
                                .white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/rightArrowWhite.png',
                        height: 20,
                        width: 20,

                      ),
                    ],
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (Email == 'guest@guest.com') {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('from', 'washroom');
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    } else {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          ChooseLocationsWashRoom(lats:lat,longs:lng)));
                    }

                  },
                ),
              ),
            ),
          ),
          body: ColoredBox(
            color: ConstantColors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 60,
                          color: ConstantColors.newcolor,
                          child: Stack(children: [
                            Center(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 8, 0),
                                      child: Image.asset(
                                        "assets/leftArrowWhite.png",
                                        fit: BoxFit.fitWidth,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Container(
                                      height: 39,
                                      child: Image.asset("assets/logoobg.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),

                Expanded(
                  child: WebView(
                    initialUrl: 'https://goetc-dev.com/wash-room',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller1 = webViewController;
                      // _loadHtmlFromAssets();
                      //print("onWebViewCreated");
                    },
                    javascriptChannels: <JavascriptChannel>[
                      _toasterJavascriptChannel(context),
                    ].toSet(),
                    navigationDelegate: (NavigationRequest request) {
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) async {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) async {
                      print('Page finished loading: $url');
                    },
                    gestureNavigationEnabled: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel
      (
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        }
    );
  }

  Future<void> movetoother() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'selectedlocatio', '' + selectedPlace.formattedAddress.toString());
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
    });
  }
}