import 'dart:async';
import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/AdditionalInfo.dart';
import 'package:goetc/screen/WashroomChoosePlans.dart';
import 'package:goetc/screen/choosePlan.dart';
import 'package:goetc/utils/BackendService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OtherScreen.dart';

class ChooseLocationsWashRoom extends StatefulWidget {

  var lats,longs;

  ChooseLocationsWashRoom({this.lats,this.longs});

  @override
  _ChooseLocationsWashRoom createState() => _ChooseLocationsWashRoom();
}

class _ChooseLocationsWashRoom extends State<ChooseLocationsWashRoom> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  final currentlocation = TextEditingController();
  bool _validatecurrentlocation = false;

  final society = TextEditingController();
  bool _validatesociety = false;

  final societyid = TextEditingController();
  bool _validatesocietyid = false;

  final flatno = TextEditingController();
  bool _validateflatno = false;

  final blockname = TextEditingController();
  bool _validateblockname = false;

  final cityname = TextEditingController();
  final CityName = TextEditingController();
  final statename = TextEditingController();
  final servicebookingid = TextEditingController();
  final NameSoc = TextEditingController();
  final SocietyName = TextEditingController();
  bool _validatesocietyname = false;

  String Name='';
  String Email='';
  String MobileNo='';

  int CustomerId = 0;
  Completer<GoogleMapController> _mapController = Completer();
  double lat=17.3850,lng=78.4867;
  double newlat=0.0,newlng=0.0;
  List<dynamic> CitiesList=[];
  List<dynamic> SocietiesList=[];

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lat=widget.lats;
      lng=widget.longs;
      CustomerId = prefs.getInt('CustomerId')!;
      Name = prefs.getString('Name')!;
      Email = prefs.getString('Email')!;
      MobileNo = prefs.getString('MobileNo')!;
    });
    CityName.text='Choose City';
    NameSoc.text='Choose Society';
    setState(() {
      // currentlocation.text = prefs.getString('selectedlocatio')!;
      CityName.text = prefs.getString('selectedlocatio')!;
      loadsocuerty();
      societyid.text="0";
    });

    String url1="https://goetc-dev.com/API/HomeAPI/CitiesList";
    var response11 = await get(Uri.parse(url1),
        headers: {"Accept": "application/json"});
    setState(() {
      CitiesList = jsonDecode(response11.body)['CitiesList'];

    });


    String url11 = "https://goetc-dev.com/API/ServicesAPI/BookPreServiceBooking";
    print(url11);
    Map<String, dynamic> body = {
      'CustomerId': '' +CustomerId.toString(),
      'ServiceName': 'Washroom Cleaning',
      'ServiceId': '4',
    };
    print('registration api: ' + body.toString());
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');
    final response = await post(
      Uri.parse(url11),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    Map data1 = jsonDecode(response.body);
    print(data1);
    print(url11);
    String msg = data1['msg'];
    servicebookingid.text = data1['ServiceBookId'].toString();


  }

  Future<void> _goToPlace() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                lat, lng),
            zoom: 14.0),
      ),
    );
  }

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
                                    'Select Your Address',
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
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 300.0,
                                        child: GoogleMap(
                                          gestureRecognizers: Set()
                                            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                            ..add(Factory<VerticalDragGestureRecognizer>(
                                                    () => VerticalDragGestureRecognizer())),
                                          mapType: MapType.normal,
                                          myLocationEnabled: true,
                                          onCameraMove: (CameraPosition cp) {
                                            LatLng center = cp.target;
                                            print('new lat :'+center.latitude.toString());
                                            print('new lat :'+center.longitude.toString());
                                            newlat=center.latitude;
                                            newlng=center.longitude;

                                          },
                                          onCameraIdle:() async {
                                            print('moved stopped');
                                            print('new lat stopped:'+newlat.toString());
                                            print('new lat stopped:'+newlng.toString());
                                            if(newlat==0.0||newlng==0.0){

                                            }else{
                                              List<Placemark> placemarks = await placemarkFromCoordinates(newlat, newlng);
                                              print(placemarks);
                                              Placemark place = placemarks[0];
                                              if(NameSoc.text=='Choose Society'){

                                              }else{
                                                currentlocation.text = '${place.street}, ${place.subLocality}, ${place.locality} , ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
                                                cityname.text='${place.locality}';
                                                statename.text='${place.administrativeArea}';
                                              }

                                            }
                                          },
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(widget.lats,widget.longs),
                                            zoom: 15,
                                          ),
                                          onMapCreated: (GoogleMapController controller) {
                                            _mapController.complete(controller);
                                          },
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset('assets/location1.png',width: 35,height: 35,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(17.0, 5, 10, 10),
                                    child: Container(
                                      height: 56,
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ConstantColors.greytext, width: 1.3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: CitiesList == null
                                          ?SizedBox(height: 0,width: double.infinity)
                                          :DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        hint: Text(
                                          ''+CityName.text,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: ConstantColors.greytext,
                                            fontFamily: 'montserratsemibold',),
                                        ),
                                        items: CitiesList.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(item['CityName'],style: TextStyle(color: Color(0xFF000000)),),
                                            value: item['CityName'].toString(),
                                          );
                                        }).toList(),
                                        onChanged: (value) async {
                                          setState(() {
                                            CityName.text=value.toString();
                                            loadsocuerty();
                                          });

                                        },

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(17.0, 5, 10, 10),
                                    child: Container(
                                      height: 56,
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ConstantColors.greytext, width: 1.3),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: SocietiesList == null
                                          ?SizedBox(height: 0,width: double.infinity)
                                          :DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        hint: Text(
                                          ''+NameSoc.text,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: ConstantColors.greytext,
                                            fontFamily: 'montserratsemibold',),
                                        ),
                                        items: SocietiesList.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(item['Name'],style: TextStyle(color: Color(0xFF000000)),),
                                            value: item['Name'].toString(),
                                          );
                                        }).toList(),
                                        onChanged: (value) async {
                                          setState(() {
                                            NameSoc.text=value.toString();
                                            for(int i=0;i<SocietiesList.length;i++){
                                              if(SocietiesList[i]['Name']==NameSoc.text){
                                                SocietyName.text=SocietiesList[i]['SocietyName'].toString();
                                                society.text=SocietiesList[i]['SocietyName'].toString();
                                                societyid.text=SocietiesList[i]['SocietyId'].toString();
                                                print(''+societyid.text.toString());
                                                print(''+society.text.toString());
                                              }
                                            }
                                          });
                                          if(NameSoc.text=='Others'){
                                            society.text='';
                                            societyid.text='0';
                                            currentlocation.text='';
                                          }else{
                                            loadlatlong(society.text);
                                          }
                                        },
                                      ),
                                    ),
                                  ),

                                  NameSoc.text=='Others'?Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: society,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Society',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        hintText: 'Society Name',
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        errorText: _validatesocietyname ? 'Please Enter Society Name' : null,

                                      ),
                                    ),
                                  ):SizedBox(width: 0,height: 0,),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: blockname,
                                      textInputAction: TextInputAction.next,

                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Block Name',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        hintText: 'Block Name',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        errorText: _validateblockname ? '' : null,

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: flatno,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Flat No',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        hintText: 'Flat No',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        errorText: _validateflatno ? '' : null,

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: currentlocation,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ConstantColors.greytext,
                                              width: 1.3),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Your Address',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        hintText: 'Your Address',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratsemibold',
                                        ),
                                        errorText: _validatecurrentlocation ? '' : null,

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(

                                    color: ConstantColors.newcolor,
                                    margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
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
                                            'SAVE & CONTINUE',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: ConstantColors
                                                    .white,
                                                fontFamily: 'montserratbold',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 8),
                                          Image.asset(
                                            'assets/rightArrowWhite.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if(blockname.text==''){
                                          setState(() {
                                            blockname.text=='' ? _validateblockname = true : _validateblockname = false;
                                            Fluttertoast.showToast(
                                                msg: "Please enter block name",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          });
                                        }else if(flatno.text==''){
                                          setState(() {
                                            _validateblockname=false;
                                          });
                                          setState(() {
                                            flatno.text.isEmpty ? _validateflatno = true : _validateflatno = false;
                                            Fluttertoast.showToast(
                                                msg: "Please enter flat number",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          });
                                        }else if(society.text==''){
                                          setState(() {
                                            _validateblockname=false;
                                            _validateflatno = false;
                                          });
                                          setState(() {
                                            society.text.isEmpty ? _validatesociety = true : _validatesociety = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Please enter address",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else {
                                          setState(() {
                                            _validateblockname=false;
                                            _validateflatno = false;
                                            _validatesociety = false;
                                          });
                                          if(societyid.text=='0'){
                                            verifyregisteration1();
                                          }else {
                                            verifyregisteration();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                ]),
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

  Future<void> loadsocuerty() async {
    String url1="https://goetc-dev.com/API/HomeAPI/SocietiesGetByCityName?CityName="+CityName.text;
    print(''+url1);
    SocietyName.text='';
    society.text='';
    societyid.text='0';
    NameSoc.text='Choose Society';
    var response11 = await get(Uri.parse(url1),
        headers: {"Accept": "application/json"});
    setState(() {
      SocietiesList = jsonDecode(response11.body)['SocietiesList'];
      SocietiesList.add({
        "SocietyId": 0,
        "Name": "Others",
        "SocietyName": "Prestige Tranqulity"
      });
    });


  }

  Future<void> loadlatlong(String societyy) async {
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+societyy+"&key=AIzaSyBA9yFkHCMgGONfhnCMaSxpbaMcqJasAYk";
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
      _goToPlace();
      print(''+lat.toString());
      print(''+lng.toString());
    });
  }

  Future<void> verifyregisteration() async {
    String url1 = "https://goetc-dev.com/API/servicesAPI/AddAddressDetails";
    print(url1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', 'India');
    prefs.setString('state', ''+statename.text.toString());
    prefs.setString('city', ''+ cityname.text.toString());
    Map<String, dynamic> body = {
      'CustomerId': '' + CustomerId.toString(),
      'Address': '' + currentlocation.text.toString(),
      'SocietyName': '' + society.text.toString(),
      'BlockNo': '' + blockname.text.toString(),
      'FlatNo': '' + flatno.text.toString(),
      'State': '' + statename.text.toString(),
      'City': '' + cityname.text.toString(),
      'ServiceBookId': '' + servicebookingid.text.toString(),

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
              builder: (context) => WashroomChoosePlans(servicebookingid:servicebookingid.text.toString())));
    } else {
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
  Future<void> verifyregisteration1() async {
    String url1 = "https://goetc-dev.com/API/ServicesAPI/AddNewLead";
    print(url1);

    Map<String, dynamic> body = {
      'Name ': '' + Name.toString(),
      'PhoneNo ': '' + MobileNo.toString(),
      'Email ': '' + Email.toString(),
      'Address': '' + currentlocation.text.toString(),
      'Subject': '' + society.text.toString(),
      'Comments': '' + blockname.text.toString(),
      'UpdatedBy': '' + flatno.text.toString(),
      'Gender': 'Washroom Cleaning' ,

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OtherSereen()));
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
