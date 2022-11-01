import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/searchLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class chooseLocation extends StatefulWidget {
  @override
  _chooseLocationState createState() => _chooseLocationState();
}

class _chooseLocationState extends State<chooseLocation> {


  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  late PickResult selectedPlace;

  List<dynamic> CitiesList=[];
  bool isLoading = true;

  getData() async {
    String url="https://goetc-dev.com/API/HomeAPI/CitiesList";
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CitiesList = jsonDecode(response11.body)['CitiesList'];
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
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
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 80,
                                  margin:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                  // ignore: deprecated_member_use
                                  child: Image.asset(
                                    "assets/bglocations.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),

                                Container(
                                  margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/location.png",
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Select your city',
                                          style: TextStyle(fontSize: 18.0,fontFamily: 'montserratmedium',),
                                        ),
                                      ],
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      showcarmodel11s();

                                    },
                                  ),
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
                              getdata(CitiesList[index]['CityName'].toString());

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

  getdata(String citu) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(()   {
      prefs.setString('selectedlocatio', ''+citu);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()));
    });
  }


  Future<void> movetoother() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedlocatio', ''+selectedPlace.formattedAddress.toString());
    final splitNames= selectedPlace.formattedAddress.toString().split(',');
    print(splitNames.length.toString());
    String country=splitNames[splitNames.length-1];
    String state=splitNames[splitNames.length-2].replaceAll("0", "").replaceAll("1", "").replaceAll("2", "").replaceAll("3", "").replaceAll("9", "").replaceAll("8", "").replaceAll("7", "").replaceAll("6", "").replaceAll("5", "").replaceAll("4", "");
    String city=splitNames[splitNames.length-3];
    prefs.setString('country', ''+country);
    prefs.setString('state', ''+state);
    prefs.setString('city', ''+city);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen()));
  }
}
