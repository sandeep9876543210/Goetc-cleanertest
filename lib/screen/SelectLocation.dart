import 'dart:async';
import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/AdditionalInfo.dart';
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

class SelectLocation extends StatefulWidget {
  var carmakerid,
      cartypeid,
      CategoryName,
      PackageName,
      PackageId,
      ActualPrice,
      OfferPrice,
      ServiceBookId,Carmaker,Carmodel;

  SelectLocation(
      {this.carmakerid,
        this.cartypeid,
        this.CategoryName,
        this.PackageName,
        this.PackageId,
        this.ActualPrice,
        this.OfferPrice,
        this.ServiceBookId,
        this.Carmaker,
        this.Carmodel});

  @override
  _SelectLocation createState() => _SelectLocation();
}

class _SelectLocation extends State<SelectLocation> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  final currentlocation = TextEditingController();
  final society = TextEditingController();
  final societyid = TextEditingController();
  final flatno = TextEditingController();
  final blockname = TextEditingController();

  int CustomerId = 0;
  String country = '';
  String state = '';
  String city = '';
  Completer<GoogleMapController> _mapController = Completer();
  double lat=17.3850,lng=78.4867;
  double newlat=0.0,newlng=0.0;

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      country = prefs.getString('country')!;
      state = prefs.getString('state')!;
      city = prefs.getString('city')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    setState(() {
      currentlocation.text = prefs.getString('selectedlocatio')!;
    });
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
              backgroundColor: Colors.black,
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
                                              currentlocation.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                                            }
                                          },
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(lat,lng),
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
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                      TextFieldConfiguration(
                                        autofocus: true,
                                        controller: this.society,
                                        decoration: InputDecoration(
                                          hintText: 'Search Society',
                                          fillColor: ConstantColors.white,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return await BackendService
                                            .getSuggestions(pattern);
                                      },
                                      itemBuilder: (context,
                                          Map<String, String> suggestion) {
                                        return ListTile(
                                          title: Text(suggestion['Name']!),
                                        );
                                      },
                                      onSuggestionSelected:
                                          (Map<String, String> suggestion) {
                                        print('test' +   suggestion['Name']!);
                                        society.text =   suggestion['Name']!;
                                        societyid.text = suggestion['SocietyId']!.toString();
                                        print('test: ' +societyid.text.toString());
                                        loadlatlong();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: blockname,
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
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      controller: flatno,
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
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 10.0, 5.0),
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
                                                    .textLightGold,
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
                                      color: Colors.black,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if(blockname.text==''){
                                          Fluttertoast.showToast(
                                              msg: "Enter block name",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else if(flatno.text==''){
                                          Fluttertoast.showToast(
                                              msg: "Enter flat number",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else if(society.text==''){
                                          Fluttertoast.showToast(
                                              msg: "Choose society",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else {
                                          verifyregisteration();
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


  Future<void> loadlatlong() async {
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+society.text+"&key=AIzaSyBA9yFkHCMgGONfhnCMaSxpbaMcqJasAYk";
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
    Map<String, dynamic> body = {
      'CustomerId': '' + CustomerId.toString(),
      'Address': '' + currentlocation.text.toString(),
      'Landmark': '' + society.text.toString(),
      'BlockNo': '' + blockname.text.toString(),
      'FlatNo': '' + flatno.text.toString(),
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
              builder: (context) => AdditionalInfo(
                carmakerid: widget.carmakerid.toString(),
                cartypeid: widget.cartypeid.toString(),
                CategoryName: widget.CategoryName.toString(),
                PackageName: widget.PackageName.toString(),
                PackageId: widget.PackageId.toString(),
                ActualPrice: widget.ActualPrice.toString(),
                OfferPrice: widget.OfferPrice.toString(),
                ServiceBookId: widget.ServiceBookId.toString(),
                Carmaker1: widget.Carmaker.toString(),
                Carmodel1: widget.Carmodel.toString(),
              )));
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
