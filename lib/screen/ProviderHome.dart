import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/CarCleaningDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'WahroomDetails.dart';
import 'Webview.dart';
import 'completedOrders.dart';
import 'loginscreen.dart';
import 'personalInformation.dart';

class ProviderHomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<ProviderHomeScreen> {
  String currentlocation = '';
  final searchinput = TextEditingController();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  late PickResult selectedPlace;
  bool isLoading = false;
  bool _enabled = true;
  int CustomerId = 0;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    loaddata();
  }
  String Name='';
  String Email='';
  String MobileNo='';

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
      Name = prefs.getString('Name')!;
      Email = prefs.getString('Email')!;
      MobileNo = prefs.getString('MobileNo')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    print('' + currentlocation);
    print('' + CustomerId.toString());

  }
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          key: _key, // Assign the key to Scaffold.
          backgroundColor: Colors.white,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.black,
                            child: Stack(children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PlacePicker(
                                                apiKey:
                                                'AIzaSyDGnxpom9wLZycdXo0RM8MjZGKyI8d879o',
                                                hintText: "Find a place ...",
                                                searchingText:
                                                "Please wait ...",
                                                selectText: "Select place",
                                                outsideOfPickAreaText:
                                                "Place not in area",
                                                initialPosition:
                                                kInitialPosition,
                                                useCurrentLocation: true,
                                                selectInitialPosition: true,
                                                usePinPointingSearch: true,
                                                usePlaceDetailSearch: true,
                                                onPlacePicked: (result) {
                                                  selectedPlace = result;
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    print('' +
                                                        selectedPlace
                                                            .toString());
                                                    print('' +
                                                        selectedPlace
                                                            .formattedAddress
                                                            .toString());
                                                    movetoother();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 8, 0),
                                            child: Image.asset(
                                              "assets/loc.png",
                                              fit: BoxFit.fitWidth,
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              currentlocation == ''
                                                  ? 'Feteching location'
                                                  : '' + currentlocation,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:'montserrasemitbold',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 15, 0),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/blackng.png',
                                  height: 20,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: ConstantColors.greytext,
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
//mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarCleaningDetails()));
                                      },
                                      child: new Column(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Image.asset(
                                            'assets/carwashtranparent.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          Text(
                                            ' Car Cleaning          ',
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontFamily: 'montserratmedium'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        height: 135,
                                        child: VerticalDivider(
                                            color: ConstantColors.greytext)),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WashroomDetails()));
                                      },
                                      child: new Column(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Image.asset(
                                            'assets/washroom.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          Text(
                                            'Washroom Cleaning',
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontFamily: 'montserratmedium'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Divider(
                                color: ConstantColors.greytext,
                                height: 1,
                              )
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: ColoredBox(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 15,
                                      child: Container(
                                        color: ConstantColors.whiteBg,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child:
                                    Image.asset('assets/serviceflow.png'),
                                  ),

// Padding(
//   padding: const EdgeInsets.only(left:20.0,top: 5),
//   child: Text(
//     'Our Cleaning Services',
//     style: TextStyle(
//         fontSize: 18.0,
//         fontFamily: 'montserratmedium',
//         fontWeight: FontWeight.bold,
//         color: Colors.black),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 20.0,top: 5),
//   child:  Text(
//     'Hygienic & single-use products | low-contact services',
//     textAlign: TextAlign.start,
//     style: new TextStyle(fontSize: 14.0,color: Colors.grey,fontFamily: 'montserratmedium',),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(left:20.0,right: 20.0),
//   child: Row(
//     children: [
//       Flexible(
//         flex: 1,
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             SizedBox(height: 10,),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(5.0),
//               child: Image.asset('assets/carclean.png',height: 100,fit: BoxFit.fill,)
//             ),
//
//             SizedBox(height: 5,),
//             Text(
//               ' Car Cleaning',
//               style: new TextStyle(fontSize: 15.0,color: Colors.black,fontFamily: 'montserratmedium'),
//             ),
//             SizedBox(height: 5,),
//           ],
//         ),
//       ),
//       SizedBox(width: 10),
//       Flexible(
//         flex: 1,
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             SizedBox(height: 10,),
//             ClipRRect(
//                 borderRadius: BorderRadius.circular(5.0),
//                 child: Image.asset('assets/cleanin.png',fit: BoxFit.fill,height: 100),
//             ),
//             SizedBox(height: 5,),
//             Text(
//               ' Washroom Cleaning',
//               style: new TextStyle(fontSize: 15.0,color: Colors.black,fontFamily: 'montserratmedium'),
//             ),
//             SizedBox(height: 5,),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.black, // status bar color
            title: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ETC',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: ConstantColors.textLightGold,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'montserratsemibold',
                  ),
                ),
              ),
            ),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
// Scaffold.of(context).openDrawer();
                    _key.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    "assets/sidemenu.png",
//fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

          ),
          drawer: new Drawer(
              child: Container(
                color: Color(0xff000000),
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(Name==''? "":Name,style: TextStyle(color: Color(0xffffffff),fontSize: 18),)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(MobileNo==''? "":MobileNo,style: TextStyle(color: Color(0xffffffff),fontSize: 18),)),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                        leading: Image.asset(
                          'assets/myprofile.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "My Profile",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => PersonalInformation()));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/myorder.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "My Orders",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => CompletedOrders()));
                        }),

                    ListTile(
                        leading: Image.asset(
                          'assets/whatsapp.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Whatsapp Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          launch("https://wa.me/919381280841");
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/phonecall.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Call Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          launch(('tel://18001234382'));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/email.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Email Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'support@goetc.in',
                            query: 'subject=App Feedback', //add subject and body here
                          );
                          var url = params.toString();
                          await launch(url);
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/about.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "About Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=about-us'
                                          .toString(),Title:'About Us')));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/returnbox.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Return & Refund Policy",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=refunds-payment-policy'
                                          .toString(),Title:'Return & Refund Policy')));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/privacy.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=privacy-policy'
                                          .toString(),Title:'Privacy Policy')));
                        }),

                    ListTile(
                        leading: Image.asset(
                          'assets/logout.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Logout",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xff897e34),
                        ),
                        onTap: () async {
                          SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => LoginScreen()),
                              ModalRoute.withName('/'));
                        }),

                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> movetoother() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'selectedlocatio', '' + selectedPlace.formattedAddress.toString());
    final splitNames = selectedPlace.formattedAddress.toString().split(',');
    print(splitNames.length.toString());
    String country = splitNames[splitNames.length - 1];
    String state = splitNames[splitNames.length - 2]
        .replaceAll("0", "")
        .replaceAll("1", "")
        .replaceAll("2", "")
        .replaceAll("3", "")
        .replaceAll("9", "")
        .replaceAll("8", "")
        .replaceAll("7", "")
        .replaceAll("6", "")
        .replaceAll("5", "")
        .replaceAll("4", "");
    String city = splitNames[splitNames.length - 3];
    prefs.setString('country', '' + country);
    prefs.setString('state', '' + state);
    prefs.setString('city', '' + city);
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
    });
  }
}





