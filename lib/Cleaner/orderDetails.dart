import 'dart:convert';
import 'dart:math';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:goetc/screen/OTPScreen.dart';
import 'package:goetc/screen/OTPVerification.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {

  var BookingId;

  OrderDetails({this.BookingId});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();

}


class _OrderDetailsState extends State<OrderDetails> {
  late AppsflyerSdk appsflyerSdk;
  String afDevKey = "MoSSbBCoEmz7vNiJccYMmY";
  String appId = "com.goetc.goetccleanertest";
  void appflyer(){
    try {
      Map appsFlyerOptions = {
        "afDevKey": afDevKey,
        "afAppId": appId,
        "isDebug": true
      };

      appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

      appsflyerSdk.initSdk(
          registerConversionDataCallback: true,
          registerOnAppOpenAttributionCallback: true,
          registerOnDeepLinkingCallback: true);
      appsflyerSdk.logEvent(
          "orderDetailsscreen", {"JD Pressed Key": "JD Pressed Value"});
    } catch (e) {
      print('error print ${e}');
    }
  }

  @override
  void initState() {
    appflyer();
    super.initState();
    loadData();
  }
  String MobileNo1='';

  final customerId = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final mobileNo = TextEditingController();
  final whatsAppNumber = TextEditingController();
  final alternateMobileNo = TextEditingController();
  final gender = TextEditingController();
  final serviceBookId = TextEditingController();
  final carMakeId = TextEditingController();
  final carMake = TextEditingController();
  final carModelId = TextEditingController();
  final carModel = TextEditingController();
  final categoryName = TextEditingController();
  final packageId = TextEditingController();
  final packageName = TextEditingController();
  final amoundPaid = TextEditingController();
  final noOfTimes = TextEditingController();
  final noOfWashrooms = TextEditingController();
  final slotTime = TextEditingController();
  final flatNo = TextEditingController();
  final blockNo = TextEditingController();
  final countryName = TextEditingController();
  final stateName = TextEditingController();
  final cityName = TextEditingController();
  final societyName = TextEditingController();
  final address = TextEditingController();
  final bookingId = TextEditingController();
  final couponCode = TextEditingController();
  final couponDiscount = TextEditingController();
  final transactionId = TextEditingController();
  final paymentMethod = TextEditingController();
  final paymentMode = TextEditingController();
  final paymentStatus = TextEditingController();
  final paymentDate = TextEditingController();
  final basement = TextEditingController();
  final vehicleNumber = TextEditingController();
  final vehicleColor = TextEditingController();
  final parking = TextEditingController();
  final landMark = TextEditingController();
  final Status = TextEditingController();
  bool isLoading = true;
  var code;

  void hitOtp() async{
    var rng = new Random();
    code = rng.nextInt(900000) + 100000;
    String url='https://api.textlocal.in/send/?apikey=NjM2YzQyNzU0ZjU2NjIzMTUxNDE0OTY3NWE0YjUwNzQ=&sender=ECTETC&numbers=+91'+mobileNo.text.toString()+'&message=Dear Customer, ETC Login OTP is '+code.toString()+'\nDo not Disclose this OTP\nFor More Detail Mail us at support@goetc.in - TEAM ETC';
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    print(data);
    print(url);
    String msg=data['status'];
    print(msg);
    if(msg=="success"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(
                CustomerId: customerId.text.toString(),
                MobileNo: mobileNo.text.toString(),
                ServiceBookId: serviceBookId.text.toString(),
                BookingId: bookingId.text.toString(),
                otp: code.toString(),
              )));
    }else{
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  int customerId1=0;

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      MobileNo1 = prefs.getString('MobileNo')!;
      customerId1 = prefs.getInt('CustomerId')!;
    });
    String url = "https://goetc-dev.com/API/CleanerAPI/BookingDetails?BookingId="+widget.BookingId.toString();//+BookingId;
    print(''+url);
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      //whatsAppNumber.text ==''?MobileNo.text:WhatsAppNumber.text;
      customerId.text = jsonDecode(response1.body)['CustomerId'].toString();
      name.text = jsonDecode(response1.body)['Name'].toString();
      email.text = jsonDecode(response1.body)['Email'].toString();
      mobileNo.text = jsonDecode(response1.body)['MobileNo'].toString();
      whatsAppNumber.text = jsonDecode(response1.body)['WhatsAppNumber'].toString();
      alternateMobileNo.text = jsonDecode(response1.body)['AlternateMobileNo'].toString();
      gender.text = jsonDecode(response1.body)['Gender'].toString();
      serviceBookId.text = jsonDecode(response1.body)['ServiceBookId'].toString();
      carMakeId.text = jsonDecode(response1.body)['CarMakeId'].toString();
      carMake.text = jsonDecode(response1.body)['CarMake'].toString();
      carModelId.text = jsonDecode(response1.body)['CarModelId'].toString();
      carModel.text = jsonDecode(response1.body)['CarModel'].toString();
      categoryName.text = jsonDecode(response1.body)['CategoryName'].toString();
      packageId.text = jsonDecode(response1.body)['PackageId'].toString();
      packageName.text = jsonDecode(response1.body)['packageName'].toString();
      amoundPaid.text = jsonDecode(response1.body)['AmoundPaid'].toString();
      noOfTimes.text = jsonDecode(response1.body)['NoOfTimes'].toString();
      noOfWashrooms.text = jsonDecode(response1.body)['NoOfWashrooms'].toString();
      slotTime.text = jsonDecode(response1.body)['SlotTime'].toString();
      flatNo.text = jsonDecode(response1.body)['FlatNo'].toString();
      blockNo.text = jsonDecode(response1.body)['BlockNo'].toString();
      countryName.text = jsonDecode(response1.body)['CountryName'].toString();
      stateName.text = jsonDecode(response1.body)['StateName'].toString();
      cityName.text = jsonDecode(response1.body)['CityName'].toString();
      societyName.text = jsonDecode(response1.body)['SocietyName'].toString();
      address.text = jsonDecode(response1.body)['Address'].toString();
      bookingId.text = jsonDecode(response1.body)['BookingId'].toString();
      couponCode.text = jsonDecode(response1.body)['CouponCode'].toString();
      couponDiscount.text = jsonDecode(response1.body)['CouponDiscount'].toString();
      transactionId.text = jsonDecode(response1.body)['TransactionId'].toString();
      paymentMethod.text = jsonDecode(response1.body)['PaymentMethod'].toString();
      paymentMode.text = jsonDecode(response1.body)['PaymentMode'].toString();
      paymentStatus.text = jsonDecode(response1.body)['PaymentStatus'].toString();
      paymentDate.text = jsonDecode(response1.body)['PaymentDate'].toString();
      basement.text = jsonDecode(response1.body)['Basement'].toString();
      vehicleNumber.text = jsonDecode(response1.body)['VehicleNumber'].toString();
      vehicleColor.text = jsonDecode(response1.body)['VehicleColor'].toString();
      parking.text = jsonDecode(response1.body)['Parking'].toString();
      landMark.text = jsonDecode(response1.body)['LandMark'].toString();
      Status.text = jsonDecode(response1.body)['Status'].toString();
      setState(() {
        isLoading=false;
      });
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
                                    'Order Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'montserratbold',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),                      ]),
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

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
                      SizedBox(height: 10),
                      noOfTimes.text==''?ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children:[
                            isLoading
                                ? SizedBox(width: 10,height: 20,)
                                : Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //
                                    ),
                                    border: Border.all(
                                        color: ConstantColors.green, width: 0.6)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/carwashtranparent.png',
                                            width: 30,
                                            height: 30,),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Car Cleaning',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: "montserratmedium",
                                              color: ConstantColors.gbluend,
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex:1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Block',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+blockNo.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  'Basement',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+basement.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  'Landmark',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                landMark.text==""?SizedBox(width: 0):Text(landMark.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  'Car number',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+vehicleNumber.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'flat',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+flatNo.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  'Parking',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+parking.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  'Car make & Model',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+carMake.text+'&'+carModel.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),





                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                /*    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Block',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+blockNo.text,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'flat',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+flatNo.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),*/
                                   /* Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Basement',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+basement.text,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Parking',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+parking.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ), Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 8,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Landmark',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                landMark.text==""?SizedBox(width: 0):Text(landMark.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      Spacer(),
                                        Flexible(
                                          flex: 8,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Car make & Model',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+carMake.text+'&'+carModel.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),   Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Car number',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+vehicleNumber.text,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      *//*  Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+Status.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),*//*
                                      ],
                                    ),*/
                                   SizedBox(height: 20,)
                                   /* SizedBox(height: 10),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        'Society Name',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      child: Text(
                                        ''+societyName.text,
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        'Address',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                      child: Text(
                                        ''+societyName.text,
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),

                              ),
                            )
                          ]
                      ):ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children:[
                            isLoading
                                ? SizedBox(width: 10,height: 20,)
                                : Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //
                                    ),
                                    border: Border.all(
                                        color: ConstantColors.green, width: 0.6)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/washroom.png',
                                            width: 30,
                                            height: 30,),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Washroom Cleaning',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: "montserratmedium",
                                              color: ConstantColors.gbluend,
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+paymentDate.text,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No of Washrooms',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+noOfWashrooms.text.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'No of Times',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+noOfTimes.text.toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'SlotTime',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+slotTime.text.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'FlatNo',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+flatNo.text.toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'BlockNo',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+blockNo.text.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Landmark',
                                                style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                ''+landMark.text,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: ConstantColors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  ''+paymentStatus.text,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ConstantColors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        'Society Name',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      child: Text(
                                        ''+societyName.text,
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text(
                                        'Address',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                      child: Text(
                                        ''+societyName.text,
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: ConstantColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            )
                          ]
                      ),
                      SizedBox(height: 10,),
                      // Status.text=='Completed'?SizedBox(width:0,height: 0,):Container(
                      //   margin:
                      //   EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                      //   child: FlatButton(
                      //     minWidth: double.infinity,
                      //     height: 50,
                      //     child: Text(
                      //       'START TASK',
                      //       style: TextStyle(fontSize: 18.0,fontFamily: "montserratbold",),
                      //     ),
                      //     color: ConstantColors.newcolor,
                      //     textColor: Colors.white,
                      //     onPressed: () {
                      //       hitOtp();
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
