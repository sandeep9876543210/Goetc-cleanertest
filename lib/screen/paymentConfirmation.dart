import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Downloadinvocie.dart';
import 'HomeScreen.dart';

class PaymentConfirmation extends StatefulWidget {

  var paymentid,totals,bookingid,types,newbookingids;

  PaymentConfirmation({this.paymentid,this.totals,this.bookingid,this.types,this.newbookingids});


  @override
  _PaymentConfirmationState createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {

  int CustomerId=0;
  final SPaymentDate = TextEditingController();
  final Summary = TextEditingController();
  final BookingId = TextEditingController();
  final InvoiceDocument = TextEditingController();

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = prefs.getInt('CustomerId')!;
    });
    String url1="https://goetc-dev.com/API/ServicesAPI/BookingPaymentStatusAPI?BookingId="+widget.newbookingids.toString()+"&TransactionId="+widget.paymentid.toString();
    var response111 = await get(Uri.parse(url1),
        headers: {"Accept": "application/json"});
    print(''+url1);
    print(''+response111.body);

    String url="https://goetc-dev.com/API/ServicesAPI/BookingStatus?CustomerId="+CustomerId.toString()+'&BookingId='+widget.newbookingids;
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(''+url);
    print(''+response11.body);
    setState(() {
      SPaymentDate.text = jsonDecode(response11.body)['SPaymentDate'];
      Summary.text = jsonDecode(response11.body)['Summary'];
      BookingId.text = jsonDecode(response11.body)['BookingId'].toString();
      InvoiceDocument.text = jsonDecode(response11.body)['InvoiceDocument'].toString();
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
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
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
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen()),
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 8, 0),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      HomeScreen()),
                                                  (Route<dynamic> route) => false);
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
                                    'Payment Confirmation',
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
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Image.asset(
                                  'assets/success.png',
                                  height: 90,
                                  width: 90,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'PAYMENT COMPLETE',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: ConstantColors.textGold,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'THANK YOU FOR BOOKING SERVICE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: ConstantColors.textGold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 8),
                                  child: Text(
                                    'We have recieved your booking for Car Cleaning Service.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: ConstantColors.black),
                                  ),
                                ),

                                ///....
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                  child: SizedBox(
                                    height: 250,
                                    child: Stack(children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0) //
                                            ),
                                            border: Border.all(
                                                color: ConstantColors
                                                    .newcolor1,
                                                width: 1.4)),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10, 8, 10, 5),
                                                          child: Text(
                                                            'DATE',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                ConstantColors
                                                                    .textGold,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10, 0, 10, 8),
                                                          child: Text(
                                                            ''+SPaymentDate.text,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                ConstantColors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 8, 10, 5),
                                                      child: Text(
                                                        'TRANSACTION ID',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            ConstantColors
                                                                .textGold,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 10, 8),
                                                      child: Text(
                                                        ''+widget.paymentid,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 8, 10, 5),
                                                        child: Text(
                                                          'SUMMARY',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                              ConstantColors
                                                                  .textGold,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 0, 10, 8),
                                                        child: Text(
                                                          ''+widget.types,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                              Colors.black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10, 8, 10, 5),
                                                          child: Text(
                                                            'STATUS',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                ConstantColors
                                                                    .textGold,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              10, 0, 10, 8),
                                                          child: Text(
                                                            'Completed',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 8, 10, 5),
                                                      child: Text(
                                                        'TOTAL',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            ConstantColors
                                                                .textGold,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 10, 8),
                                                      child: Text(
                                                        '₹'+widget.totals,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 8, 10, 5),
                                                        child: Text(
                                                          'Package',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                              ConstantColors
                                                                  .textGold,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            10, 0, 10, 8),
                                                        child: Text(
                                                          ''+Summary.text,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                              Colors.black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),

                                ///....
                                SizedBox(
                                  height: 10,
                                ),
                                // InvoiceDocument.text==''?SizedBox(
                                //   width: 0,
                                //   height: 0,
                                // ):Container(
                                //   margin:
                                //   EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                //   child: FlatButton(
                                //     minWidth: double.infinity,
                                //     height: 50,
                                //     child: Row(
                                //       crossAxisAlignment:
                                //       CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //       MainAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //           'DOWNLOAD INVOICE',
                                //           style: TextStyle(
                                //               fontSize: 18.0,
                                //               color:
                                //               ConstantColors.white,
                                //               fontWeight: FontWeight.w600),
                                //         ),
                                //         SizedBox(width: 5),
                                //         Image.asset(
                                //           'assets/rightArrowWhite.png',
                                //           height: 20,
                                //           width: 20,
                                //         ),
                                //       ],
                                //     ),
                                //     color: ConstantColors.newcolor,
                                //     textColor: Colors.white,
                                //     onPressed: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) => Downloadinvoic(
                                //                   bookingid:InvoiceDocument.text)));
                                //       //Verify mobile number here
                                //     },
                                //   ),
                                // ),


                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 8),
                                  child: Text(
                                    'Thank for choosing us. You would receive you invoice on your registered mail id',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: ConstantColors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    onPressed: (){
                                      //
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen()),
                                              (Route<dynamic> route) => false);
                                    },
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/leftArrowWhite.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'BACK TO HOME',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    color: ConstantColors.newcolor,
                                    textColor: Colors.white,

                                  ),
                                ),

                                SizedBox(
                                  height: 15,
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
}
