import 'dart:convert';
import 'dart:ffi';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/SelectLocation.dart';
import 'package:goetc/utils/MultipleNotifier3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseSlot.dart';
import 'SelectLocationWashroom.dart';

class WashroomChoosePlans extends StatefulWidget {

  var servicebookingid;

  WashroomChoosePlans({this.servicebookingid});

  @override
  _ChoosePlansState createState() => _ChoosePlansState();
}

class _ChoosePlansState extends State<WashroomChoosePlans> {

  bool isChecked = false;
  bool isLoading = true;
  late ProgressDialog pr;
  bool isdataloaded=true;
  TextEditingController nameController = TextEditingController();
  TextEditingController noofwashrooms = TextEditingController();
  TextEditingController nooftimes = TextEditingController();
  TextEditingController roomselection = TextEditingController();
  TextEditingController timesselection = TextEditingController();
  TextEditingController ServiceCategoryId = TextEditingController();
  TextEditingController ServiceId = TextEditingController();
  TextEditingController CategoryName = TextEditingController();
  int _radioValue=100;
  String currentlocation='';
  int CustomerId=0;
  String country='';
  String state='';
  String city='';
  List<String> rooms = ["1 Bathroom","2 Bathrooms","3 Bathrooms","4 Bathrooms"];
  List<String> times = ["1 time","2 times","4 times"];
  List<String> times1 = [];
  List<dynamic> data=[];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      noofwashrooms.text='No of Washrooms';
      nooftimes.text='No of Times (Per Month)';
      currentlocation = prefs.getString('selectedlocatio')!;
      country = prefs.getString('country')!;
      state = prefs.getString('state')!;
      city = prefs.getString('city')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    setState(() {
      isLoading = false;
    });
  }

  final PackageId = TextEditingController();
  final PackageName = TextEditingController();
  final ActualPrice = TextEditingController();
  final OfferPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    pr= ProgressDialog(context);
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
                                    'Washroom Cleaning',
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
            backgroundColor: Colors.white,//ConstantColors.whiteBg,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.40,
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
                                    height: 250,
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
                                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                                        child: Text(
                                          'Please choose No of Washrooms &\n No of Times.',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 18,
                                              color: ConstantColors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(17.0, 15, 10, 10),
                                        child: Container(
                                          height: 56,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFF2F2F2), width: 1.3),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: rooms == null
                                              ?SizedBox(height: 0,width: double.infinity)
                                              :DropdownButton(
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            hint: Text(
                                              noofwashrooms.text,
                                              style: TextStyle(
                                                  fontFamily: 'montserratregular',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0,
                                                  color: Color(0xFFFFFFFF)),
                                            ),
                                            items: rooms.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item,style: TextStyle(color: Color(0xFF000000)),),
                                                value: item.toString(),
                                              );
                                            }).toList(),
                                            onChanged: (value) async {
                                              setState(() {
                                                noofwashrooms.text=value.toString();
                                              });

                                            },
                                            // items: CountryList.map((valueItem) {
                                            //   return DropdownMenuItem(
                                            //     value: valueItem,
                                            //     child: Text(valueItem),
                                            //   );
                                            // }).toList(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(17.0, 15, 10, 10),
                                        child: Container(
                                          height: 56,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFF2F2F2), width: 1.3),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: times == null
                                              ?SizedBox(height: 0,width: double.infinity)
                                              : DropdownButton(
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            hint: Text(
                                              ''+nooftimes.text,
                                              style: TextStyle(
                                                  fontFamily: 'montserratregular',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0,
                                                  color: Color(0xFFFFFFFF)),
                                            ),
                                            onTap: (){
                                              if(noofwashrooms.text=='No of Washrooms'){
                                                Fluttertoast.showToast(
                                                    msg: "Please choose no of washrooms",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            },
                                            items: noofwashrooms.text=='No of Washrooms'?times1.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item,style: TextStyle(color: Color(0xFF000000)),),
                                                value: item.toString(),
                                              );
                                            }).toList():times.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item,style: TextStyle(color: Color(0xFF000000)),),
                                                value: item.toString(),
                                              );
                                            }).toList(),
                                            onChanged: (value) async {
                                              setState(() {
                                                nooftimes.text=value.toString();
                                                loadingpackages();
                                              });
                                            },

                                          ),
                                        ),
                                      ),


                                    ]),
                              ],
                            ),
                            Stack(
                              children: [

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
                            ), //Curve white bg

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isdataloaded==true) SizedBox(width: 0,) else
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                    child: Text(
                                      'Choose Your Plan',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: ConstantColors.black,
                                          fontFamily: 'montserratbold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                  child: SizedBox(
                                    child: Stack(children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1.0) //
                                            ),
                                            border: Border.all(
                                                color: ConstantColors
                                                    .newcolor1,
                                                width: 1.4)),
                                        child: Column(
                                          children: [
                                            if (isdataloaded==true) SizedBox(width: 0,) else
                                              GestureDetector(

                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: BouncingScrollPhysics(),
                                                      itemCount: data.length,
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: (){
                                                            setState(() {
                                                              _radioValue = index;
                                                              PackageName.text=data[index]['PackageName'];
                                                              PackageId.text=data[index]['PackageId'].toString();
                                                              ActualPrice.text=data[index]['ActualPrice'].toString();
                                                              OfferPrice.text=data[index]['OfferPrice'].toString();

                                                            });
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              new Radio(
                                                                value: index,
                                                                groupValue: _radioValue,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _radioValue = index;
                                                                    PackageName.text=data[index]['PackageName'];
                                                                    PackageId.text=data[index]['PackageId'].toString();
                                                                    ActualPrice.text=data[index]['ActualPrice'].toString();
                                                                    OfferPrice.text=data[index]['OfferPrice'].toString();
                                                                  });
                                                                },
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0),
                                                                child: Text(
                                                                  ''+data[index]['PackageName'],
                                                                  style: TextStyle(
                                                                      color:Colors.black,
                                                                      fontFamily: 'montserratsemibold',
                                                                      fontSize: 18.0),
                                                                ),
                                                              ),
                                                              index==0?Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    10.0, 0.0, 0.0, 0.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      'POPULAR',
                                                                      style: TextStyle(
                                                                          color:
                                                                          ConstantColors
                                                                              .newcolor1,
                                                                          fontFamily: 'montserratsemibold',
                                                                          fontSize: 16.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ):SizedBox(width: 0,),
                                                              Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    10.0, 0.0, 10.0, 0.0),
                                                                child: Row(
                                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: [
                                                                    Text('₹'+data[index]['ActualPrice'].toString(),
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontFamily: 'montserratsemibold',
                                                                          fontSize: 16.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )

                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
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
                                    onPressed: () {
                                      verifyregisteration();


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
    if(noofwashrooms.text==''){
      Fluttertoast.showToast(
          msg: "Choose number of washrooms",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(nooftimes.text==''){
      Fluttertoast.showToast(
          msg: "Choose number of times",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(PackageId.text==''){
      Fluttertoast.showToast(
          msg: "Choose package",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else {
      String url1 = "https://goetc-dev.com/API/ServicesAPI/BookPreServiceBooking";
      print(url1);
      Map<String, dynamic> body = {
        'CustomerId': '' +CustomerId.toString(),
        'NoOfWashrooms': '' +noofwashrooms.text.toString().replaceAll("Bathroom", "").replaceAll("s", "").trim(),
        'NoOfTimes': '' +nooftimes.text.toString().replaceAll("time", "").replaceAll("s", "").trim(),
        'CategoryName': '' +CategoryName.text,
        'PackageId': '' +PackageId.text,
        'PackageName': '' +PackageName.text,
        'Price': '' +ActualPrice.text.toString(),
        'Address': '' +currentlocation,
        'ServiceName': 'Washroom Cleaning',
        'ServiceId': '4',
        'City': '' +city,
        'State': ''+state ,
        'Country': ''+country ,
        'ServiceBookId': '' + widget.servicebookingid.toString(),

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
        int ServiceBookId = data1['ServiceBookId'];
        print(''+ServiceBookId.toString());
        loadingpackagessaads(ServiceBookId);
      } else {
        Fluttertoast.showToast(
            msg: "Choose plan details",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }

    return;
  }

  Future<void> loadingpackagessaads(int ServiceBookId) async {
    String url="https://goetc-dev.com/API/servicesAPI/ServicePreBookingDetails?ServiceBookId="+ServiceBookId.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    Map data1 = jsonDecode(response11.body);
    String msg = data1['msg'];
    if(msg=='success'){
      int BookingId = data1['BookingId'];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChooseSlot(
        noofwashrooms:noofwashrooms.text.toString().replaceAll("Bathroom", "").replaceAll("s", "").trim(),
        nooftimes:nooftimes.text.toString().replaceAll("time", "").replaceAll("s", "").trim(),
        CategoryName:CategoryName.text.toString(),
        PackageName:PackageName.text.toString(),
        PackageId:PackageId.text.toString(),
        ActualPrice:ActualPrice.text.toString(),
        OfferPrice:OfferPrice.text.toString(),
        ServiceBookId:widget.servicebookingid.toString(),
        BookingId:BookingId.toString(),
      )));

    }


  }

  Future<void> loadingpackages() async {
    String url="https://goetc-dev.com/API/ServicesAPI/GetWashroomCategoryByCount?NoOfWashrooms="+noofwashrooms.text.toString().replaceAll("Bathroom", "").replaceAll("s", "").trim()+"&NoOfTimes="+nooftimes.text.toString().replaceAll("time", "").replaceAll("s", "").trim();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    ServiceCategoryId.text = jsonDecode(response11.body)['ServiceCategoryId'].toString();
    ServiceId.text = jsonDecode(response11.body)['ServiceId'].toString();
    CategoryName.text = jsonDecode(response11.body)['CategoryName'].toString();
    loadingpackagesfromserviceid();
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

  Future<void> showcarmodel11s() async {
    showDialog(context: context,builder: (context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        elevation: 25.0,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.white,
              child: Text(
                "Select No of Washrooms",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: rooms.length == 0
                  ? Container()
                  : Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Colors.grey,
                      ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: rooms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      //highlightColor: Colors.red,
                      //splashColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          noofwashrooms.text = rooms[index];
                          Navigator.pop(context);
                        });
                      },
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
                            Text(rooms[index],),
                           Icon(Icons.radio_button_unchecked),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ), //Custom ListView
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: ConstantColors.newcolor,
                textColor: Colors.white,
                child: Text(
                  "Cancel", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  Future<void> showcarmodel11saddssas() async {
    showDialog(context: context,builder: (context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        elevation: 25.0,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.white,
              child: Text(
                "Select No of times per month",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: times.length == 0
                  ? Container()
                  : Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Colors.grey,
                      ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: times.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      //highlightColor: Colors.red,
                      //splashColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          nooftimes.text = times[index];
                          Navigator.pop(context);
                          loadingpackages();
                        });
                      },
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
                            Text(times[index],),
                           Icon(Icons.radio_button_unchecked),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ), //Custom ListView
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: ConstantColors.newcolor,
                textColor: Colors.white,
                child: Text(
                  "Cancel", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }


  Future<void> loadingpackagesfromserviceid() async {
    String url="https://goetc-dev.com/API/ServicesAPI/GetPlansByCarCategory?ServiceCategoryId="+ServiceCategoryId.text.toString()+"&ServiceBookId="+ServiceId.text;
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    data = jsonDecode(response11.body)['data'];
    print(""+data.toString());
    setState(() {
      isdataloaded=false;
    });
  }
}