import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'WashroomOrderPreview.dart';
import 'orderPreview.dart';

class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  bool isLoading = true;
  List<dynamic> CarWashBookingslist=[];
  List<dynamic> WashRoomBookingslist=[];
  String currentlocation='';
  int CustomerId=0;
  String country='';
  String state='';
  String city='';
  bool isdataloaded=true;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });

    String url="https://goetc-dev.com/API/ServicesAPI/RecentBookingsList?CustomerId="+CustomerId.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(""+url);
    CarWashBookingslist = jsonDecode(response11.body)['CarWashBookingslist'];
    WashRoomBookingslist = jsonDecode(response11.body)['WashRoomBookingslist'];
    setState(() {
      isdataloaded=false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  late ProgressDialog dialog;

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
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      child: GestureDetector(
                                        onTap: () {
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
                                    'My Orders',
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
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            if (isdataloaded==true) SizedBox(width: 0,) else
                              GestureDetector(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: CarWashBookingslist.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: SizedBox(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(3.0) //
                                                  ),
                                                  border: Border.all(
                                                      color: ConstantColors.textGold, width: 0.6)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/carwashtranparent.png',
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Car Cleaning',
                                                          style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontFamily: "montserratmedium",
                                                            color: ConstantColors.goldText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Car Maker',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+CarWashBookingslist[index]['CarMake'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Vehicle Number',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+CarWashBookingslist[index]['VehicleNumber'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(height: 5),
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
                                                              'Payment Method',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+CarWashBookingslist[index]['PaymentMethod'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Car Model',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+CarWashBookingslist[index]['CarModel'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Transaction ID',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+CarWashBookingslist[index]['TransactionId'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Package Name',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+CarWashBookingslist[index]['PackageName'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Booked Date',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+CarWashBookingslist[index]['BookedDate'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Expiry Date',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+CarWashBookingslist[index]['ExpiryDate'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Payment Status',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+CarWashBookingslist[index]['PaymentStatus'],
                                                              style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: ConstantColors.green,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                                        child: SizedBox(
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Total Paid',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                '₹'+CarWashBookingslist[index]['AmountPaid'].toString(),
                                                                style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    color: ConstantColors.green,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  CarWashBookingslist[index]['PaymentStatus']=='Pending'?SizedBox(height: 5):SizedBox(width: 0,height: 0,),
                                                  CarWashBookingslist[index]['PaymentStatus']=='Pending'?Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: MaterialButton(
                                                          height: 30,
                                                          onPressed: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => OrderPreviewScreen(
                                                                      carmakerid: CarWashBookingslist[index]['CarMake'].toString(),
                                                                      cartypeid: CarWashBookingslist[index]['CarMake'].toString(),
                                                                      CategoryName: CarWashBookingslist[index]['ServiceName'].toString(),
                                                                      PackageName: CarWashBookingslist[index]['PackageName'].toString(),
                                                                      PackageId: CarWashBookingslist[index]['PackageId'].toString(),
                                                                      ActualPrice: CarWashBookingslist[index]['AmountPaid'].toString(),
                                                                      OfferPrice: "0.0",
                                                                      ActualPriceBIKE:"0.0",
                                                                      OfferPriceBIKE:"0.0",
                                                                      ServiceBookId: CarWashBookingslist[index]['ServiceBookId'].toString(),
                                                                      CustomerId: CarWashBookingslist[index]['CustomerId'].toString(),
                                                                      Carmaker1: CarWashBookingslist[index]['PaymentStatus'].toString(),
                                                                      Carmodel1: CarWashBookingslist[index]['PaymentStatus'].toString(),

                                                                    )));
                                                          },
                                                          padding: EdgeInsets.all(10.0),
                                                          elevation: 0,
                                                          splashColor: Color(0xff161a49),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                'Complete Order',
                                                                style: TextStyle(
                                                                    color: Color(0xFFFFFFFF),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w800,
                                                                    fontFamily: "Lorin"),
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                                          color: Color(0xff161a49),
                                                        ),
                                                      ),
                                                    ],
                                                  ):SizedBox(width: 0,height: 0,),
                                                  SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )

                                  ],
                                ),
                              ),

                            if (isdataloaded==true) SizedBox(width: 0,) else
                              GestureDetector(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: WashRoomBookingslist.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: SizedBox(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(3.0) //
                                                  ),
                                                  border: Border.all(
                                                      color: ConstantColors.textGold, width: 0.6)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/washroom.png',
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Washroom Cleaning',
                                                          style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontFamily: "montserratmedium",
                                                            color: ConstantColors.goldText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
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
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+WashRoomBookingslist[index]['BookedDate'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'No Of Washrooms',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+WashRoomBookingslist[index]['NoOfWashrooms'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'No Of Times',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+WashRoomBookingslist[index]['NoOfTimes'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Package Name',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+WashRoomBookingslist[index]['PackageName'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Transaction ID',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+WashRoomBookingslist[index]['TransactionId'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: ConstantColors.black,
                                                                fontWeight: FontWeight.bold,
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
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Package Mode',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                ''+WashRoomBookingslist[index]['PaymentMode'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: ConstantColors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                              'Payment Status',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: ConstantColors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              ''+WashRoomBookingslist[index]['PaymentStatus'],
                                                              style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: ConstantColors.green,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.fromLTRB(0, 0, 15, 5),
                                                        child: SizedBox(
                                                          width: 130,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Total Paid',
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  color: ConstantColors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 2),
                                                              Text(
                                                                '₹'+WashRoomBookingslist[index]['AmountPaid'].toString(),
                                                                style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    color: ConstantColors.green,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  WashRoomBookingslist[index]['PaymentStatus']=='Pending'?SizedBox(height: 5):SizedBox(width: 0,height: 0,),
                                                  WashRoomBookingslist[index]['PaymentStatus']=='Pending'?Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: MaterialButton(
                                                          height: 30,
                                                          onPressed: () async {
                                                            Navigator.push(
                                                                context, MaterialPageRoute(builder: (context) => WashroomOrderPreviewScreen(
                                                              noofwashrooms:WashRoomBookingslist[index]['NoOfWashrooms'].toString().replaceAll("Bathroom", "").replaceAll("s", "").trim(),
                                                              nooftimes:WashRoomBookingslist[index]['NoOfTimes'].toString().replaceAll("time", "").replaceAll("s", "").trim(),
                                                              CategoryName:WashRoomBookingslist[index]['PaymentStatus'].toString(),
                                                              PackageName:WashRoomBookingslist[index]['PackageName'].toString(),
                                                              PackageId:WashRoomBookingslist[index]['PackageId'].toString(),
                                                              ActualPrice:WashRoomBookingslist[index]['AmountPaid'].toString(),
                                                              OfferPrice:"0.0",
                                                              ServiceBookId:WashRoomBookingslist[index]['ServiceBookId'].toString(),
                                                              BookingId:WashRoomBookingslist[index]['BookingId'].toString(),
                                                            )));
                                                          },
                                                          padding: EdgeInsets.all(10.0),
                                                          elevation: 0,
                                                          splashColor: Color(0xff161a49),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                'Complete Order',
                                                                style: TextStyle(
                                                                    color: Color(0xFFFFFFFF),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w800,
                                                                    fontFamily: "Lorin"),
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                                          color: Color(0xff161a49),
                                                        ),
                                                      ),
                                                    ],
                                                  ):SizedBox(width: 0,height: 0,),

                                                  SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )

                                  ],
                                ),
                              ),


                            // if (isdataloaded==true) SizedBox(width: 0,) else
                            //   GestureDetector(
                            //     child: Column(
                            //       children: [
                            //         ListView.builder(
                            //           scrollDirection: Axis.vertical,
                            //           shrinkWrap: true,
                            //           physics: BouncingScrollPhysics(),
                            //           itemCount: WashRoomBookingslist.length,
                            //           itemBuilder: (context, index) {
                            //             return GestureDetector(
                            //               onTap: (){
                            //
                            //               },
                            //               child: Row(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 children: [
                            //                   Padding(
                            //                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            //                     child: SizedBox(
                            //                       height: 245,
                            //                       child: Container(
                            //                         decoration: BoxDecoration(
                            //                             borderRadius:
                            //                             BorderRadius.all(Radius.circular(3.0) //
                            //                             ),
                            //                             border: Border.all(
                            //                                 color: ConstantColors.textGold, width: 0.6)),
                            //                         child: Column(
                            //                           crossAxisAlignment: CrossAxisAlignment.start,
                            //                           mainAxisAlignment: MainAxisAlignment.start,
                            //                           children: [
                            //                             Padding(
                            //                               padding: const EdgeInsets.all(8.0),
                            //                               child: Row(
                            //                                 children: [
                            //                                   Image.asset(
                            //                                     'assets/washroom.png',
                            //                                     width: 30,
                            //                                     height: 30,
                            //                                   ),
                            //                                   SizedBox(
                            //                                     width: 5,
                            //                                   ),
                            //                                   Text(
                            //                                     'Washroom Cleaning',
                            //                                     style: TextStyle(
                            //                                       fontSize: 17.0,
                            //                                       fontFamily: "montserratmedium",
                            //                                       color: ConstantColors.goldText,
                            //                                     ),
                            //                                   ),
                            //                                 ],
                            //                               ),
                            //                             ),
                            //                             SizedBox(height: 5),
                            //                             Row(
                            //                               crossAxisAlignment: CrossAxisAlignment.start,
                            //                               mainAxisAlignment: MainAxisAlignment.start,
                            //                               children: [
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(10, 0, 10, 5),
                            //                                   child: Column(
                            //                                     mainAxisAlignment: MainAxisAlignment.start,
                            //                                     crossAxisAlignment:
                            //                                     CrossAxisAlignment.start,
                            //                                     children: [
                            //                                       Text(
                            //                                         'Date',
                            //                                         style: TextStyle(
                            //                                           fontSize: 14.0,
                            //                                           color: ConstantColors.black,
                            //                                         ),
                            //                                       ),
                            //                                       SizedBox(height: 2),
                            //                                       Text(
                            //                                         ''+WashRoomBookingslist[index]['BookedDate'],
                            //                                         style: TextStyle(
                            //                                           fontSize: 16.0,
                            //                                           color: ConstantColors.black,
                            //                                         ),
                            //                                       ),
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                                 Spacer(),
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(0, 0, 15, 5),
                            //                                   child: SizedBox(
                            //                                     width: 130,
                            //                                     child: Column(
                            //                                       mainAxisAlignment:
                            //                                       MainAxisAlignment.start,
                            //                                       crossAxisAlignment:
                            //                                       CrossAxisAlignment.start,
                            //                                       children: [
                            //                                         Text(
                            //                                           'No of Washrooms',
                            //                                           style: TextStyle(
                            //                                             fontSize: 14.0,
                            //                                             color: ConstantColors.black,
                            //                                           ),
                            //                                         ),
                            //                                         SizedBox(height: 2),
                            //                                         Text(
                            //                                           ''+WashRoomBookingslist[index]['NoOfWashrooms'].toString(),
                            //                                           style: TextStyle(
                            //                                             fontSize: 16.0,
                            //                                             color: ConstantColors.black,
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                             SizedBox(height: 5),
                            //                             Row(
                            //                               crossAxisAlignment: CrossAxisAlignment.start,
                            //                               mainAxisAlignment: MainAxisAlignment.start,
                            //                               children: [
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(10, 0, 10, 5),
                            //                                   child: Column(
                            //                                     mainAxisAlignment: MainAxisAlignment.start,
                            //                                     crossAxisAlignment:
                            //                                     CrossAxisAlignment.start,
                            //                                     children: [
                            //                                       Text(
                            //                                         'No of Times',
                            //                                         style: TextStyle(
                            //                                           fontSize: 14.0,
                            //                                           color: ConstantColors.black,
                            //                                         ),
                            //                                       ),
                            //                                       SizedBox(height: 2),
                            //                                       Text(
                            //                                         ''+WashRoomBookingslist[index]['NoOfTimes'].toString(),
                            //                                         style: TextStyle(
                            //                                           fontSize: 16.0,
                            //                                           color: ConstantColors.black,
                            //                                         ),
                            //                                       ),
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                                 Spacer(),
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(0, 0, 15, 5),
                            //                                   child: SizedBox(
                            //                                     width: 130,
                            //                                     child: Column(
                            //                                       mainAxisAlignment:
                            //                                       MainAxisAlignment.start,
                            //                                       crossAxisAlignment:
                            //                                       CrossAxisAlignment.start,
                            //                                       children: [
                            //                                         Text(
                            //                                           'Package Name',
                            //                                           style: TextStyle(
                            //                                             fontSize: 14.0,
                            //                                             color: ConstantColors.black,
                            //                                           ),
                            //                                         ),
                            //                                         SizedBox(height: 2),
                            //                                         Text(
                            //                                           ''+WashRoomBookingslist[index]['PackageName'],
                            //                                           style: TextStyle(
                            //                                             fontSize: 16.0,
                            //                                             color: ConstantColors.black,
                            //                                           ),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                             SizedBox(height: 5),
                            //                             Row(
                            //                               crossAxisAlignment: CrossAxisAlignment.start,
                            //                               mainAxisAlignment: MainAxisAlignment.start,
                            //                               children: [
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(10, 0, 10, 5),
                            //                                   child: Column(
                            //                                     mainAxisAlignment: MainAxisAlignment.start,
                            //                                     crossAxisAlignment:
                            //                                     CrossAxisAlignment.start,
                            //                                     children: [
                            //                                       Text(
                            //                                         'Payment Status',
                            //                                         style: TextStyle(
                            //                                           fontSize: 14.0,
                            //                                           color: ConstantColors.black,
                            //                                         ),
                            //                                       ),
                            //                                       SizedBox(height: 2),
                            //                                       Text(
                            //                                         ''+WashRoomBookingslist[index]['PaymentStatus'],
                            //                                         style: TextStyle(
                            //                                             fontSize: 15.0,
                            //                                             color: ConstantColors.green,
                            //                                             fontWeight: FontWeight.bold),
                            //                                       ),
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                                 Spacer(),
                            //                                 Padding(
                            //                                   padding:
                            //                                   const EdgeInsets.fromLTRB(0, 0, 15, 5),
                            //                                   child: SizedBox(
                            //                                     width: 130,
                            //                                     child: Column(
                            //                                       mainAxisAlignment:
                            //                                       MainAxisAlignment.start,
                            //                                       crossAxisAlignment:
                            //                                       CrossAxisAlignment.start,
                            //                                       children: [
                            //                                         Text(
                            //                                           'Total Paid',
                            //                                           style: TextStyle(
                            //                                             fontSize: 14.0,
                            //                                             color: ConstantColors.black,
                            //                                           ),
                            //                                         ),
                            //                                         SizedBox(height: 2),
                            //                                         Text(
                            //                                           '₹'+WashRoomBookingslist[index]['AmountPaid'].toString(),
                            //                                           style: TextStyle(
                            //                                               fontSize: 15.0,
                            //                                               color: ConstantColors.green,
                            //                                               fontWeight: FontWeight.bold),
                            //                                         ),
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                             SizedBox(height: 5),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             );
                            //           },
                            //         )
                            //
                            //       ],
                            //     ),
                            //   ),

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
