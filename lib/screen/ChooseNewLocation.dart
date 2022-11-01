import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/CarCleaningDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
import 'WahroomDetails.dart';
import 'orderPreview.dart';

class ChooseNewLocations extends StatefulWidget {

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<ChooseNewLocations> {

  bool isChecked = false;
  int CustomerId = 0;
  int CarInfoId = 0;
  List<dynamic> CitiesList=[];

  @override
  void initState() {
    super.initState();
    loaddata();

  }

  bool isLoading = true;

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = prefs.getInt('CustomerId')!;
    });

    String url="https://goetc-dev.com/API/HomeAPI/CitiesList";
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CitiesList = jsonDecode(response11.body)['CitiesList'];
    setState(() {
      isLoading = false;
    });

  }
  List CountryIds = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
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
                                    'Choose Your City',
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
            backgroundColor: Colors.black,
            body: Container(
              color: Colors.white,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isLoading
                                      ? SizedBox(
                                    width: 0,
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: CitiesList.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 0.0,
                                        crossAxisSpacing: 0.0,
                                        childAspectRatio: 0.90,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          //mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child:
                                              Container(
                                                child: ChoiceChip(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(color: Color(0xFFF2F2F2), width: 1),
                                                      ),
                                                  label: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 16,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            height: 75,
                                                            width: 75,
                                                            decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                image: NetworkImage(''+CitiesList[index]['ImageUrl']),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        ''+ CitiesList[index]['CityName'],
                                                        style: TextStyle(fontFamily: 'Lorin'),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  selected: CountryIds.contains(0),
                                                  onSelected: (bool selected) async {
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    setState(()   {
                                                      prefs.setString('selectedlocatio', ''+CitiesList[index]['CityName']);
                                                      String? from = prefs.getString('from');
                                                      if(from=='carwash'){
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext context) => HomeScreen()),
                                                            ModalRoute.withName('/'));
                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (context) => CarCleaningDetails()));
                                                      }else if(from=='washroom'){
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext context) => HomeScreen()),
                                                            ModalRoute.withName('/'));
                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (context) =>
                                                            WashroomDetails()));
                                                      }else{
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext context) => HomeScreen()),
                                                            ModalRoute.withName('/'));
                                                      }


                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                ]
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
