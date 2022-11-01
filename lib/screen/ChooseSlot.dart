import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/AdditionalInfo.dart';
import 'package:goetc/screen/WashroomOrderPreview.dart';
import 'package:goetc/utils/BackendService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseSlot extends StatefulWidget {
  var noofwashrooms,
      nooftimes,
      CategoryName,
      PackageName,
      PackageId,
      ActualPrice,
      OfferPrice,
      ServiceBookId,
      BookingId;

  ChooseSlot(
      {this.noofwashrooms,
        this.nooftimes,
        this.CategoryName,
        this.PackageName,
        this.PackageId,
        this.ActualPrice,
        this.OfferPrice,
        this.ServiceBookId,
        this.BookingId});

  @override
  _SelectLocation createState() => _SelectLocation();
}

class _SelectLocation extends State<ChooseSlot> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  int CustomerId = 0;
  String country = '';
  String state = '';
  String city = '';
  bool isdataloaded=true;
  bool isdataloaded1=true;
  final CategoryName = TextEditingController();
  final Address = TextEditingController();
  final Price = TextEditingController();
  final PackageName = TextEditingController();
  final ServiceName = TextEditingController();
  final NoOfWashrooms = TextEditingController();
  final NoOfTimes = TextEditingController();
  final BookingId = TextEditingController();
  final City = TextEditingController();
  final State = TextEditingController();
  final Country = TextEditingController();
  final SlotDatestring = TextEditingController();
  final selectedSlotDatestring = TextEditingController();
  final selectedSlotTime = TextEditingController();
  List<dynamic> data=[];
  List<dynamic> data1=[];
  int _radioValue=100;
  int _radioValue1=100;
  List<dynamic> CitiesList=[];

  loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      country = prefs.getString('country')!;
      state = prefs.getString('state')!;
      city = prefs.getString('city')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });

    String url="https://goetc-dev.com/API/servicesAPI/ServicePreBookingDetails?ServiceBookId="+widget.ServiceBookId.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    Map data11 = jsonDecode(response11.body);
    String msg = data11['msg'];
    if(msg=='success'){
      CategoryName.text = data11['CategoryName'].toString();
      Address.text = data11['Address'].toString();
      Price.text = data11['Price'].toString();
      PackageName.text = data11['PackageName'].toString();
      ServiceName.text = data11['ServiceName'].toString();
      NoOfWashrooms.text = data11['NoOfWashrooms'].toString();
      NoOfTimes.text = data11['NoOfTimes'].toString();
      BookingId.text = data11['BookingId'].toString();
      City.text = data11['City'].toString();
      State.text = data11['State'].toString();
      Country.text = data11['Country'].toString();
    }
    loadingpackages();

  }

  Future<void> loadingpackages() async {
    String url="https://goetc-dev.com/API/ServicesAPI/GetAvailableSlotDates?BookingId="+BookingId.text.toString()+'&ServiceId=4';
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    data = jsonDecode(response11.body)['data'];
    print(""+data.toString());
    setState(() {
      isdataloaded=false;
    });

  }


  Future<void> loadingtime() async {
    setState(() {
      isdataloaded1=true;
    });
    String url="https://goetc-dev.com/API/ServicesAPI/GetAvailableSlotsTimings?BookingId="+BookingId.text.toString()+'&ServiceId=4'+'&SlotDate='+SlotDatestring.text.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    setState(() {
      data1 = jsonDecode(response11.body)['data'];
      print(""+data1.toString());

      isdataloaded1=false;
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
                                    'Washroom Information',
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
                                ),
                                Center(
                                  child: Image.asset(
                                    'assets/blackng.png',
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        child: TextField(
                                          readOnly: true,
                                          controller: NoOfWashrooms,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.3),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.3),
                                            ),
                                            border: OutlineInputBorder(),
                                            labelText: 'No of Washrooms',
                                            hintStyle:
                                            TextStyle(color: Colors.grey,fontFamily: 'montserratregular',),
                                            labelStyle:
                                            TextStyle(color: Colors.grey),
                                            hintText: 'No of Washrooms',

                                          ),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        child: TextField(
                                          readOnly: true,
                                          style: TextStyle(color: Colors.white),
                                          controller: NoOfTimes,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.3),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.3),
                                            ),
                                            border: OutlineInputBorder(),
                                            labelText: 'No Of Times',
                                            labelStyle:
                                            TextStyle(color: Colors.grey,fontFamily: 'montserratregular',),
                                            hintText: 'No Of Times',
                                            hintStyle: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                    ]),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                if (isdataloaded==true) SizedBox(width: 0,) else
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(15, 15, 0, 15),
                                        child: Text(
                                          'Select date for service',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: ConstantColors.black,
                                              fontFamily: 'montserratbold',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Center(
                                        child: Container(
                                          height: 100,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    _radioValue = index;
                                                    SlotDatestring.text=data[index]['SlotDatestring'];
                                                    loadingtime();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(1.0) //
                                                        ),
                                                        border: Border.all(
                                                            color: _radioValue==index?ConstantColors.newcolor1:ConstantColors.black,
                                                            width: 1.4)),
                                                    child: Container(
                                                      width: 90,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            ''+data[index]['DayName'],
                                                            style: TextStyle(
                                                                color: _radioValue==index?ConstantColors.newcolor1:ConstantColors.black,
                                                                fontFamily: 'montserratregular',
                                                                fontSize: 16.0),
                                                          ),
                                                          Text(
                                                            ''+data[index]['Day'].toString(),
                                                            style: TextStyle(
                                                                color: _radioValue==index?ConstantColors.newcolor1:ConstantColors.black,
                                                                fontFamily: 'montserratbold',
                                                                fontSize: 16.0),
                                                          ),
                                                          Text(
                                                            ''+data[index]['MonthName'],
                                                            style: TextStyle(
                                                                color: _radioValue==index?ConstantColors.newcolor1:ConstantColors.black,
                                                                fontFamily: 'montserratregular',
                                                                fontSize: 16.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                if (isdataloaded1==true) SizedBox(width: 0,) else
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(15, 15, 0, 10),
                                        child: Text(
                                          'Select time for service',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: ConstantColors.black,
                                              fontFamily: 'montserratbold',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Center(
                                        child: Container(
                                          height: 60,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: data1.length,
                                            itemBuilder: (context, index1) {
                                              return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    _radioValue1 = index1;
                                                    selectedSlotDatestring.text=''+data1[index1]['SlotDatestring'];
                                                    selectedSlotTime.text=''+data1[index1]['SlotTime'];
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(1.0) //
                                                        ),
                                                        border: Border.all(
                                                            color: _radioValue1==index1?ConstantColors.newcolor1:ConstantColors.black,
                                                            width: 1.4)),
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:10.0,right: 10.0),
                                                            child: Text(
                                                              ''+data1[index1]['SlotTime'],
                                                              style: TextStyle(
                                                                  color: _radioValue1==index1?ConstantColors.newcolor1:ConstantColors.black,
                                                                  fontFamily: 'montserratregular',
                                                                  fontSize: 16.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 15.0, 15.0, 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'If you save less than the membership price, we will refund the differnce',
                                          style: TextStyle(
                                              color: ConstantColors.greytext,
                                              fontFamily: 'montserratmedium',
                                              fontSize: 15.0),
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                          'CONTINUE BOOKING',
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
                                    color: ConstantColors.newcolor,
                                    onPressed: () {
                                        if(selectedSlotTime.text==''){
                                          Fluttertoast.showToast(
                                              msg: "Choose time slot to continue",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{
                                          if(selectedSlotDatestring.text==''){
                                            Fluttertoast.showToast(
                                                msg: "Choose Date",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }else if(selectedSlotTime.text==''){
                                            Fluttertoast.showToast(
                                                msg: "Choose time",
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
                                        }
                                      //Verify mobile number here
                                    },
                                  ),
                                ),
                                SizedBox(height: 35)
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
    String url1 =
        "https://goetc-dev.com/API/ServicesAPI/AddWashroomAddiotionalDetails";
    print(url1);
    Map<String, dynamic> body = {
      'CustomerId': '' + CustomerId.toString(),
      'ServiceId': '4',
      'NoOfWashrooms': '' + NoOfWashrooms.text.toString(),
      'NoOfTimes': '' + NoOfTimes.text.toString(),
      'BookingId ': '' + BookingId.text.toString(),
      'Instructions': '' + widget.ServiceBookId.toString(),

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
    if (msg == "Success") {
      verifyregisteration1();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => WashroomOrderPreviewScreen(
      //   noofwashrooms:widget.noofwashrooms.toString().replaceAll("Bathroom", "").replaceAll("s", "").trim(),
      //   nooftimes:widget.nooftimes.toString().replaceAll("time", "").replaceAll("s", "").trim(),
      //   CategoryName:widget.CategoryName.toString(),
      //   PackageName:widget.PackageName.toString(),
      //   PackageId:widget.PackageId.toString(),
      //   ActualPrice:widget.ActualPrice.toString(),
      //   OfferPrice:widget.OfferPrice.toString(),
      //   ServiceBookId:widget.ServiceBookId.toString(),
      //   BookingId:widget.BookingId.toString(),
      // )));
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
    String url1 =
        "https://goetc-dev.com/API/ServicesAPI/BookSlotDateandSlotTime";
    print(url1);
    Map<String, dynamic> body = {
      'CustomerId': '' + CustomerId.toString(),
      'BookingId ': '' + BookingId.text.toString(),
      'ServiceBookId ': '' + widget.ServiceBookId.toString(),
      'SlotDate': '' + selectedSlotDatestring.text.toString(),
      'SlotTime': '' + selectedSlotTime.text.toString(),
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
    if (msg == "Success") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WashroomOrderPreviewScreen(
        noofwashrooms:widget.noofwashrooms.toString().replaceAll("Bathroom", "").replaceAll("s", "").trim(),
        nooftimes:widget.nooftimes.toString().replaceAll("time", "").replaceAll("s", "").trim(),
        CategoryName:widget.CategoryName.toString(),
        PackageName:widget.PackageName.toString(),
        PackageId:widget.PackageId.toString(),
        ActualPrice:widget.ActualPrice.toString(),
        OfferPrice:widget.OfferPrice.toString(),
        ServiceBookId:widget.ServiceBookId.toString(),
        BookingId:widget.BookingId.toString(),
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
