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

import 'ChooseNewLocation.dart';
import 'WahroomDetails.dart';
import 'Webview.dart';
import 'animated_custom_dialog.dart';
import 'completedOrders.dart';
import 'guest_dialog.dart';
import 'loginscreen.dart';
import 'personalInformation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final searchinput = TextEditingController();
  final currentlocation = TextEditingController();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  late PickResult selectedPlace;
  bool isLoading = false;
  bool _enabled = true;
  int CustomerId = 0;
  int _current = 0;
  List<dynamic> mobileBannersList = [];

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  String Name='';
  String Email='';
  String MobileNo='';
  List<dynamic> CitiesList=[];

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentlocation.text = prefs.getString('selectedlocatio')!;
      Name = prefs.getString('Name')!;
      Email = prefs.getString('Email')!;
      MobileNo = prefs.getString('MobileNo')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    print('' + currentlocation.text);
    print('' + CustomerId.toString());
    String url = "https://goetc-dev.com/API/HomeAPI/HomeBanners";
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      mobileBannersList = jsonDecode(response1.body)['BannersList'];
      _enabled=false;
    });
    String url1="https://goetc-dev.com/API/HomeAPI/CitiesList";
    var response11 = await get(Uri.parse(url1),
        headers: {"Accept": "application/json"});
    CitiesList = jsonDecode(response11.body)['CitiesList'];
    setState(() {
      isLoading = false;
    });

  }
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key



  Future<void> showcarmodel11s() async {
    showDialog(context: context,builder: (context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 25.0,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      color: Colors.white,
                      child: Text(
                        "Choose Your City",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    CitiesList.length == 0
                        ? Container()
                        : Container(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(
                              color: Colors.grey,
                            ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: CitiesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new InkWell(
                            //highlightColor: Colors.red,
                            //splashColor: Colors.blueAccent,
                            onTap: () {
                              setState(() {
                                currentlocation.text=CitiesList[index]['CityName'].toString();
                              });
                              setState(() async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('selectedlocatio', ''+CitiesList[index]['CityName'].toString());
                                Navigator.pop(context);
                              });
                            },
                            child: new Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
                                  Text(
                                    CitiesList[index]['CityName'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }



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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ConstantColors.newcolor2,
                            ),
                            child: Stack(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return PlacePicker(
                                        //         apiKey:
                                        //         'AIzaSyDGnxpom9wLZycdXo0RM8MjZGKyI8d879o',
                                        //         hintText: "Find a place ...",
                                        //         searchingText:
                                        //         "Please wait ...",
                                        //         selectText: "Select place",
                                        //         outsideOfPickAreaText:
                                        //         "Place not in area",
                                        //         initialPosition:
                                        //         kInitialPosition,
                                        //         useCurrentLocation: true,
                                        //         selectInitialPosition: true,
                                        //         usePinPointingSearch: true,
                                        //         usePlaceDetailSearch: true,
                                        //         onPlacePicked: (result) {
                                        //           selectedPlace = result;
                                        //           Navigator.of(context).pop();
                                        //           setState(() {
                                        //             print('' +
                                        //                 selectedPlace
                                        //                     .toString());
                                        //             print('' +
                                        //                 selectedPlace
                                        //                     .formattedAddress
                                        //                     .toString());
                                        //             movetoother();
                                        //           });
                                        //         },
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                        // showcarmodel11s();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) => ChooseNewLocations()),
                                            ModalRoute.withName('/'));

                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              currentlocation.text == ''
                                                  ? 'Feteching location'
                                                  : '' + currentlocation.text,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                  'montserrasemitbold',
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

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                //X:1125,Pro: 1170,Pro Max: 1284
                                  height: 200,
                                  width: double.infinity,
                                  child: isLoading
                                      ?Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey,
                                    enabled: true,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          //  height: 180,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ): CarouselSlider(
                                    items: [
                                      for(int i=0;i<mobileBannersList.length;i++)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(mobileBannersList[i]['ImageUrl'].toString()),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            //  height: 180,
                                            width: double.infinity,
                                          ),
                                        ),
                                    ],
                                    options: CarouselOptions(
                                        height: 400,
                                        viewportFraction: 1.0,
                                        initialPage: 0,
                                        reverse: false,
                                        autoPlay: true,
                                        aspectRatio: 5.0,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                                        enlargeCenterPage: false,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: mobileBannersList.asMap().entries.map((entry) {
                                  return _current == entry.key
                                      ? GestureDetector(
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ConstantColors.newcolor23),
                                    ),
                                  ):GestureDetector(
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ConstantColors.newcolor),
                                    ),
                                  );
                                }).toList(),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   height: 180,
                              //   child: _enabled
                              //       ? Center(
                              //       child: Shimmer.fromColors(
                              //         baseColor: Colors.grey,
                              //         highlightColor: Colors.blueGrey,
                              //         enabled: _enabled,
                              //         child: Container(
                              //           height: 200.0,
                              //           width:
                              //           MediaQuery.of(context).size.width,
                              //           margin: EdgeInsets.symmetric(
                              //               horizontal: 5.0),
                              //           decoration: BoxDecoration(
                              //             color: ConstantColors.shimmergrey,
                              //           ),
                              //         ),
                              //       ))
                              //       : CarouselSlider(
                              //     options: CarouselOptions(
                              //         height: 400,
                              //         viewportFraction: 1.0,
                              //         initialPage: 0,
                              //         reverse: false,
                              //         autoPlay: true,
                              //         aspectRatio: 5.0,
                              //         autoPlayInterval: Duration(seconds: 3),
                              //         autoPlayAnimationDuration: Duration(milliseconds: 800),
                              //         enlargeCenterPage: false,
                              //         scrollDirection: Axis.horizontal,
                              //         onPageChanged: (index, reason) {
                              //           setState(() {
                              //             _current = index;
                              //           });
                              //         }),
                              //     items: <Widget>[
                              //       for (var i = 0;i < mobileBannersList.length;i++)
                              //         Container(
                              //           decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //               image:NetworkImage(
                              //                   mobileBannersList[i]['ImageUrl'].toString()),
                              //               fit: BoxFit.fill,
                              //             ),
                              //             borderRadius: BorderRadius.circular(20.0),
                              //           ),
                              //           //  height: 180,
                              //           width: double.infinity,
                              //         ),
                              //
                              //
                              //     ],
                              //   ),
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: mobileBannersList.map((url) {
                              //     int index = mobileBannersList.indexOf(url);
                              //     return Container(
                              //       width: 8.0,
                              //       height: 8.0,
                              //       margin: EdgeInsets.symmetric(
                              //           vertical: 10.0, horizontal: 2.0),
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         color: _current == index
                              //             ? Color.fromRGBO(0, 0, 0, 0.9)
                              //             : Color.fromRGBO(0, 0, 0, 0.4),
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              // Divider(
                              //   color: ConstantColors.greytext,
                              //   height: 1,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarCleaningDetails()));
                                            },
                                            child: SizedBox(
                                              height: 15,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarCleaningDetails()));
                                            },
                                            child: Image.asset(
                                              'assets/carwashtranparent.png',
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarCleaningDetails()));
                                            },
                                            child: Text(
                                              ' Car Cleaning          ',
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontFamily: 'montserratmedium'),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarCleaningDetails()));
                                            },
                                            child: SizedBox(
                                              height: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        height: 135,
                                        child: VerticalDivider(
                                          color: ConstantColors.greytext,
                                          width: 0.1,)),
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
                                      height: 4,
                                      child: Container(
                                        color: ConstantColors.whiteBg,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10,top:5),
                                    child:
                                    Image.asset('assets/hometxt.png'),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 4,
                              child: Container(
                                color: ConstantColors.whiteBg,
                              )),

                          Container(
                            width: double.infinity,
                            child: ColoredBox(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right:20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      'OUR CLEANING SERVICES',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "montserratbold",
                                        color: ConstantColors.newcolor,
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                    Text(
                                      'Choose from our exceptional Car and Washroom Cleaning Services',
                                      style: new TextStyle(
                                          fontSize: 14.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratmedium'),
                                    ),
                                    SizedBox(height: 10,),

                                    GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CarCleaningDetails()));
                                        },
                                        child: Image.asset('assets/carcean.png')),
                                    SizedBox(height: 10,),

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarCleaningDetails()));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Car Cleaning',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "montserratbold",
                                              color: ConstantColors.newcolor,
                                            ),
                                          ),

                                          Spacer(),
                                          Image.asset(
                                            "assets/rightArrowBlack.png",
                                            fit: BoxFit.fitWidth,
                                            color: ConstantColors.newcolor1,
                                            height: 23,
                                            width: 23,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarCleaningDetails()));
                                      },
                                      child: Text(
                                        'Let your Car Shine like New. Explore our exceptional Car daily cleaning services at your doorstep.',
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            color: ConstantColors.greytext,
                                            fontFamily: 'montserratmedium'),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WashroomDetails()));
                                        },
                                        child: Image.asset('assets/carceann.png')),

                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WashroomDetails()));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Washroom Cleaning',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "montserratbold",
                                              color: ConstantColors.newcolor,
                                            ),
                                          ),

                                          Spacer(),
                                          Image.asset(
                                            "assets/rightArrowBlack.png",
                                            fit: BoxFit.fitWidth,
                                            color: ConstantColors.newcolor1,
                                            height: 23,
                                            width: 23,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WashroomDetails()));
                                      },
                                      child: Text(
                                        'Make your washroom free from stains, odour & germs. Our Washroom services starts from Rs. 199 (1 Wash, 1 Washroom).',
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            color: ConstantColors.greytext,
                                            fontFamily: 'montserratmedium'),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: 10,),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: ConstantColors.newcolor, // status bar color
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 39,
                  child: Image.asset("assets/logoobg.png"),
                ),
              ],
            ),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 15, 5),
              child: GestureDetector(
                onTap: () {
                  if(Email=='guest@guest.com') {
                    showAnimatedDialog(context, GuestDialog(), isFlip: true);
                  }else {
                    _key.currentState!.openDrawer();
                  }
                },
                child: Image.asset(
                  "assets/sidemenu.png",
                ),
              ),
            ),
          ),
          drawer: new Drawer(
              child: Container(
                color: Color(0xff161A49),
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
                    Center(child: Text(MobileNo==''? "":MobileNo,style: TextStyle(
                        color: Color(0xffffffff),fontSize: 18),)),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
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
                          color: Color(0xffffffff),
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
                          color: Color(0xffffffff),
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
                          color: Color(0xffffffff),
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
                          color: Color(0xffffffff),
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
                          color: Color(0xffffffff),
                        ),
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'support@goetc.in',
                            query: 'subject=App Feedback', //add subject and body here
                          );
                          var url = params.toString();
                          await launch(url);
                        }
                    ),
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
                          color: Color(0xffffffff),
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
                          "Refunds & Payment Policy",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
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
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=privacy-policy'
                                          .toString(),Title:'Privacy Policy')));
                        }),
                    // ListTile(
                    //     leading: Image.asset(
                    //       'assets/career.png',
                    //       height: 20,
                    //       width: 20,
                    //       color: Colors.white,
                    //     ),
                    //     title: Text(
                    //       "Careers",
                    //       style: TextStyle(color: Color(0xffffffff)),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 15,
                    //       color: Color(0xffffffff),
                    //     ),
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => WebviewScreen(
                    //                   WebviewUrl:'https://goetc.kekahire.com/'
                    //                       .toString(),Title:'Careers')));
                    //     }),
                    ListTile(
                        leading: Image.asset(
                          'assets/businessman.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Register As a Professional",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/ProfessionalRegistration'
                                          .toString(),Title:'Register As a Professional')));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/contract.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Terms of use",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=terms-of-use'
                                          .toString(),Title:'Terms of use')));
                        }),
                    // ListTile(
                    //     leading: Image.asset(
                    //       'assets/faq.png',
                    //       height: 20,
                    //       width: 20,
                    //       color: Colors.white,
                    //     ),
                    //     title: Text(
                    //       "FAQ",
                    //       style: TextStyle(color: Color(0xffffffff)),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 15,
                    //       color: Color(0xffffffff),
                    //     ),
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => WebviewScreen(
                    //                   WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=faqs'
                    //                       .toString(),Title:'FAQ')));
                    //     }),

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
                          color: Color(0xffffffff),
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
      currentlocation.text = prefs.getString('selectedlocatio')!;
    });
  }
}





