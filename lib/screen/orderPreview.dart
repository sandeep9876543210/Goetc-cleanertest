import 'dart:convert';
import 'dart:ffi';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:goetc/screen/paymentConfirmation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Webview.dart';

class OrderPreviewScreen extends StatefulWidget {
  var carmakerid,
      cartypeid,
      CategoryName,
      PackageName,
      PackageId,
      ActualPrice,
      OfferPrice,
      ActualPriceBIKE,
      OfferPriceBIKE,
      ServiceBookId,
      CustomerId,Carmaker1,Carmodel1;

  OrderPreviewScreen(
      {this.carmakerid,
        this.cartypeid,
        this.CategoryName,
        this.PackageName,
        this.PackageId,
        this.ActualPrice,
        this.OfferPrice,
        this.ActualPriceBIKE,
        this.OfferPriceBIKE,
        this.ServiceBookId,
        this.CustomerId,
        this.Carmaker1,
        this.Carmodel1});

  @override
  _OrderPreviewScreenState createState() => _OrderPreviewScreenState();
}

class _OrderPreviewScreenState extends State<OrderPreviewScreen> {
  bool isChecked = true;

  //instance of razorpay class
  late Razorpay _razorpay;

  final Name = TextEditingController();
  final promocode = TextEditingController();
  final Email = TextEditingController();
  final MobileNo = TextEditingController();
  int CustomerId = 0;
  final ServiceName = TextEditingController();
  final PackageName = TextEditingController();
  final Price = TextEditingController();
  final data1 = TextEditingController();
  final WhatsAppNumber = TextEditingController();
  final SocietyName = TextEditingController();
  final Landmark = TextEditingController();
  final Address = TextEditingController();
  final BlockNo = TextEditingController();
  final FlatNo = TextEditingController();
  final data2 = TextEditingController();
  final Basement = TextEditingController();
  final CarModel = TextEditingController();
  final CarMake = TextEditingController();
  final CarCategory = TextEditingController();
  final VehicleNumber = TextEditingController();
  final VehicleColor = TextEditingController();
  final Parking = TextEditingController();
  final DCLandMark = TextEditingController();
  final Instructions = TextEditingController();
  final DiscountType = TextEditingController();
  final BookingId11 = TextEditingController();
  final gsts = TextEditingController();
  double price = 0.0, gst = 0.0, total = 0.0;
  double MinimumOrderAmount=0.0;
  double Discount=0.0;
  double MaxDiscountAmount=0.0;
  double DiscountAmount=0.0;
  double FinalDiskamount=0.0;
  get maxline => null;

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Name.text = prefs.getString('Name')!;
      Email.text = prefs.getString('Email')!;
      MobileNo.text = prefs.getString('MobileNo')!.toString();
      CustomerId = prefs.getInt('CustomerId')!;
    });
    String url =
        "https://goetc-dev.com/API/servicesAPI/OrderPreview?ServiceId=1&CustomerId=" +
            CustomerId.toString() +
            '&ServiceBookId=' +
            widget.ServiceBookId.toString();
    print(url);
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      ServiceName.text = jsonDecode(response1.body)['ServiceName'];
      PackageName.text = jsonDecode(response1.body)['PackageName'];
      Price.text = jsonDecode(response1.body)['Price'].toString();
      data1.text = jsonDecode(response1.body)['data1'].toString();
      Name.text = jsonDecode(response1.body)['Name'].toString();
      Email.text = jsonDecode(response1.body)['Email'].toString();
      MobileNo.text = jsonDecode(response1.body)['MobileNo'].toString();
      WhatsAppNumber.text =jsonDecode(response1.body)['WhatsAppNumber'].toString();
      SocietyName.text = jsonDecode(response1.body)['SocietyName'].toString();
      Landmark.text = jsonDecode(response1.body)['DCLandMark'].toString();
      Address.text = jsonDecode(response1.body)['Address'].toString();
      BlockNo.text = jsonDecode(response1.body)['BlockNo'].toString();
      FlatNo.text = jsonDecode(response1.body)['FlatNo'].toString();
      data2.text = jsonDecode(response1.body)['data2'].toString();
      Basement.text = jsonDecode(response1.body)['Basement'].toString();
      CarModel.text = jsonDecode(response1.body)['CarModel'].toString();
      CarMake.text = jsonDecode(response1.body)['CarMake'].toString();
      CarCategory.text = jsonDecode(response1.body)['CarCategory'].toString();
      VehicleNumber.text =
          jsonDecode(response1.body)['VehicleNumber'].toString();
      VehicleColor.text = jsonDecode(response1.body)['VehicleColor'].toString();
      Parking.text = jsonDecode(response1.body)['Parking'].toString();
      DCLandMark.text = jsonDecode(response1.body)['DCLandMark'].toString();
      Instructions.text = jsonDecode(response1.body)['Instructions'].toString();
      BookingId11.text = jsonDecode(response1.body)['BookingId'].toString();
      price = jsonDecode(response1.body)['Price'];
      gst = price * 0.18;
      total = price + gst;
      print('' + price.toString());
      print('' + gst.toString());
      print('' + total.toString());
    });
  }

  showcardetails() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFFF1F3F2), Color(0xFFF1F3F2)]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Vehicle Information',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Basement ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + Basement.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Vehicle Color ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' +VehicleColor.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Car Make ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + CarMake.text,
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Car Model ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + CarModel.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Car Category ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + CarCategory.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Vehicle Number ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + VehicleNumber.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Land Mark ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + Landmark.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Parking No / Pillar No ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '' + Parking.text.toString(),
                                    style: TextStyle(
                                        color: ConstantColors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(),
                            gradient: LinearGradient(colors: <Color>[
                              Color(0xff161a49),
                              Color(0xff161a49)
                            ]),
                          ),
                          padding: EdgeInsets.fromLTRB(19.0, 12.0, 19.0, 12.0),
                          constraints: const BoxConstraints(
                              minWidth: 150.0, minHeight: 25.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'CLOSE',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'robotomedium',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  showpromocode() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFFF1F3F2), Color(0xFFF1F3F2)]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Have a coupon code?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 0.0, 20.0, 5.0),
                  child: TextField(
                    controller: promocode,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "montserratbold",fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: ConstantColors.white,
                      filled: true,
                      hintText: 'Please Enter Code',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,
                        onPressed: () async {
                          if(promocode.text==''){
                            Fluttertoast.showToast(
                                msg: "Please Enter promocode",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            if(FinalDiskamount==0.0){
                              String url =
                                  "https://goetc-dev.com/API/MasterAPI/CouponAvailability?PromoCode=" +
                                      promocode.text.toString() +
                                      '&Amount=' +
                                      price.toString()+'&ServiceId=1&CustomerId='+CustomerId.toString();
                              print(url);
                              var response1 =
                              await get(Uri.parse(url), headers: {"Accept": "application/json"});
                              Map data1 = jsonDecode(response1.body);
                              String msg = data1['msg'];
                              if (msg == "success") {
                                setState(() {
                                  MinimumOrderAmount = jsonDecode(response1.body)['MinimumOrderAmount'];
                                  Discount = jsonDecode(response1.body)['Discount'];
                                  DiscountType.text = jsonDecode(response1.body)['DiscountType'];
                                  MaxDiscountAmount = jsonDecode(response1.body)['MaxDiscountAmount'];
                                  if(price>MinimumOrderAmount){
                                    if(DiscountType.text=='Percent'){
                                      DiscountAmount=(price*(Discount/100));
                                      print(DiscountAmount.toString());
                                      if(DiscountAmount>MaxDiscountAmount){
                                        setState(() {
                                          FinalDiskamount=MaxDiscountAmount;
                                          total=price-FinalDiskamount;
                                          total=total+gst;
                                        });
                                      }else{
                                        setState(() {
                                          FinalDiskamount=DiscountAmount;
                                          total=price-FinalDiskamount;
                                          total=total+gst;
                                        });
                                      }
                                    }else{
                                      setState(() {
                                        FinalDiskamount=MaxDiscountAmount;
                                        total=price-FinalDiskamount;
                                        total=total+gst;
                                      });
                                    }
                                    Navigator.pop(context);

                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "You cant apply promo code for minimum order amount",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }

                                });
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Promo code invalid / expired.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Promocode already applied",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        elevation: 0,
                        splashColor: Color(0xff161a49),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Apply',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Lorin"),
                            ),
                          ],
                        ),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Color(0xff161a49),
                      ),
                      Spacer(),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,

                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(10.0),
                        elevation: 0,
                        splashColor: Color(0xff161a49),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Close',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Lorin"),
                            ),
                          ],
                        ),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Color(0xff161a49),
                      ),
                      Spacer(),

                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }


  showgstcode() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFFF1F3F2), Color(0xFFF1F3F2)]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Have a GST NO?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 0.0, 20.0, 5.0),
                  child: TextField(
                    controller: gsts,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "montserratbold",fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: ConstantColors.white,
                      filled: true,
                      hintText: 'Please Enter GST NO',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,
                        onPressed: () async {
                          if(gsts.text==''){
                            Fluttertoast.showToast(
                                msg: "Please Enter GST Number",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            Navigator.pop(context);
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        elevation: 0,
                        splashColor: Color(0xff161a49),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Apply',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Lorin"),
                            ),
                          ],
                        ),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Color(0xff161a49),
                      ),
                      Spacer(),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,

                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(10.0),
                        elevation: 0,
                        splashColor: Color(0xff161a49),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Close',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Lorin"),
                            ),
                          ],
                        ),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        color: Color(0xff161a49),
                      ),
                      Spacer(),

                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }


  late WebViewController controller1;

  showdescription() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFFF1F3F2), Color(0xFFF1F3F2)]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 400,
                      child: WebView(
                        initialUrl: 'https://goetc-dev.com/car-wash',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) {
                          controller1 = webViewController;
                        },
                        javascriptChannels: <JavascriptChannel>[
                          _toasterJavascriptChannel(context),
                        ].toSet(),
                        navigationDelegate: (NavigationRequest request)
                        {
                          print('allowing navigation to $request');
                          return NavigationDecision.navigate;
                        },
                        onPageStarted: (String url)
                        async {
                          print('Page started loading: $url');
                        },
                        onPageFinished: (String url)
                        async {
                          print('Page finished loading: $url');
                        },
                        gestureNavigationEnabled: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(),
                            gradient: LinearGradient(colors: <Color>[
                              Color(0xff161a49),
                              Color(0xff161a49)
                            ]),
                          ),
                          padding: EdgeInsets.fromLTRB(19.0, 12.0, 19.0, 12.0),
                          constraints: const BoxConstraints(
                              minWidth: 150.0, minHeight: 25.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'CLOSE',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'robotomedium',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }


  JavascriptChannel _toasterJavascriptChannel(BuildContext context)
  {
    return JavascriptChannel
      (
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message)
        {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        }
    );
  }

  Future<void> verifyregisteration() async {

    String url1 = "https://goetc-dev.com/API/servicesAPI/BookingServicesInsertAPI";
    print(url1);
    Map<String, dynamic> body = {
      'BookingId': '' +BookingId11.text.toString(),
      'ServiceId': '1',
      'ServiceCategoryId': '0',
      'ServiceNeedFor': '' +gsts.text.toString(),
      'PackageId': '' +widget.PackageId.toString(),
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
    return;
  }


  @override
  void initState() {
    super.initState();
    loaddata();
    initializeRazorPay();
  }

  void initializeRazorPay() {
    _razorpay = Razorpay();

    //3 event listeners in razorpay
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void launchRazorPay() {
    // int amountToPay = int.parse(amount.text) * 100;
    if(promocode.text=='AWS123'){
      var options = {
        'key': 'rzp_live_M4OBiRBsZdboFT',
        // 'amount': "" + (total * 100).toString(),
        'amount': "" + (1 * 100).toString(),
        'name': ""+Name.text,
        'description': "Car Cleaning",
        'prefill': {
          'contact': "" + MobileNo.text.toString(),
          'email': "" + Email.text
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        print("error: $e");
      }
    }else{
      var options = {
        'key': 'rzp_live_M4OBiRBsZdboFT',
        'amount': "" + (total * 100).toString(),
        // 'amount': "" + (1 * 100).toString(),
        'name': ""+Name.text,
        'description': "Car Cleaning",
        'prefill': {
          'contact': "" + MobileNo.text.toString(),
          'email': "" + Email.text
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        print("error: $e");
      }
    }

  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment successful");
    String url="https://goetc-dev.com/API/ServicesAPI/BookingInvoicesDetails?BookingId="+BookingId11.text.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    String urls = jsonDecode(response11.body)['Invoice'];
    print(''+urls);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentConfirmation(
                paymentid: "${response.paymentId}", totals: total.toString(),bookingid:urls,types:'Car Cleaning',newbookingids:''+BookingId11.text.toString())));
    //after successful we get these in response
    print(
        "------------------------${response.orderId} \n ${response.paymentId} \n ${response.signature} --------------------------------");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment failed");

    //after failure we get these
    print(
        "-----------------------${response.code} \n ${response.message}---------------------");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("-------------------payment failed----------------------");
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
                                    'Order Preview',
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
                            // Container(
                            //   width: MediaQuery.of(context).size.width,
                            //   height: 50,
                            //   color: Colors.transparent,
                            //   child: Stack(children: [
                            //     Center(
                            //       child: Image.asset(
                            //         'assets/blackng.png',
                            //         height: 350,
                            //         width: double.infinity,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding:
                            //           const EdgeInsets.fromLTRB(15, 15, 15, 8),
                            //       child: Text(
                            //         'Order Preview',
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.w600,
                            //             fontSize: 18,
                            //             color: ConstantColors.goldText),
                            //       ),
                            //     ),
                            //   ]),
                            // ),
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
                                Center(
                                  child: Image.asset(
                                    'assets/paymentpreview.png',
                                    height: 110,
                                    width: MediaQuery.of(context).size.width *
                                        0.95, //MediaQuery.of(context).size.height * 0.40
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 8, 0, 5),
                                  child: Text(
                                    'CAR CLEANING',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        widget.ActualPriceBIKE==null||widget.ActualPriceBIKE==''?'₹'+widget.ActualPrice:'₹'+(double.parse(widget.ActualPrice)+double.parse(widget.ActualPriceBIKE)).toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: ConstantColors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 10, 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ConstantColors
                                                    .newcolor1,
                                                width: 1.4)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 2, 8, 2),
                                          child: Text(
                                            ''+PackageName.text,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: ConstantColors.newcolor1,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                  child: Divider(height: 2, color: Colors.grey),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 8, 0),
                                      child: Image.asset(
                                        "assets/user.png",
                                        fit: BoxFit.fitWidth,
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                    Text(
                                      ''+Name.text.toString(),
                                      style: TextStyle(
                                        //fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 8, 0),
                                        child: Image.asset(
                                          "assets/email.png",
                                          fit: BoxFit.fitWidth,
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Text(
                                        '' + Email.text,
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 8, 0),
                                        child: Image.asset(
                                          "assets/whatsapp.png",
                                          fit: BoxFit.fitWidth,
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Text(
                                        WhatsAppNumber.text==''?MobileNo.text:WhatsAppNumber.text,
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 8),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 8, 0),
                                        child: Image.asset(
                                          "assets/locationblack.png",
                                          fit: BoxFit.fitWidth,
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          '' + Address.text,
                                          maxLines: 3,
                                          style: TextStyle(
                                            //fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          showcardetails();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ConstantColors
                                                        .newcolor1,
                                                    width: 1.3)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 2, 8, 2),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Vehicle Information',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: ConstantColors
                                                            .newcolor1,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 0),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                    child: Image.asset(
                                                      "assets/nextgold.png",
                                                      fit: BoxFit.fitWidth,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          showdescription();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ConstantColors
                                                        .newcolor1,
                                                    width: 1.3)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 2, 8, 2),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Description',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: ConstantColors
                                                            .newcolor1,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 0),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                    child: Image.asset(
                                                      "assets/nextgold.png",
                                                      fit: BoxFit.fitWidth,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0) //
                                        ),
                                        border: Border.all(
                                            color: ConstantColors.greytext,
                                            width: 0.6)),
                                    child:Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 5),
                                              child: Text(
                                                'Service Total',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 0, 10, 0),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                                child: Text(
                                                  '₹' + price.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: ConstantColors
                                                          .black,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 5),
                                              child: Text(
                                                'GST @ 18%',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 0, 10, 0),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                                child: Text(
                                                  '₹' + gst.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: ConstantColors
                                                          .black,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        FinalDiskamount==0.0?SizedBox():Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 5),
                                              child: Text(
                                                'Discount',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 0, 10, 0),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                                child: Text(
                                                  '(-) ₹' + FinalDiskamount.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: ConstantColors
                                                          .black,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            showgstcode();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 8, 10, 5),
                                                      child: gsts.text==''?Text(
                                                        'Do You Have GST No?',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                            ConstantColors
                                                                .textGold,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ):Text(
                                                        'GST No is : '+gsts.text,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                            ConstantColors
                                                                .textGold,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: ConstantColors.greytext,
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 5),
                                              child: Text(
                                                'Total Amount Payable',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: ConstantColors.green,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 0, 10, 0),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                                child: Text(
                                                  '₹' + total.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: ConstantColors
                                                          .green,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ) ,
                                  ),
                                ),



                                FinalDiskamount==0.0?GestureDetector(
                                  onTap: (){
                                    showpromocode();
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    child: Text(
                                      'Have a Coupon Code?',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: ConstantColors.textGold,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ):GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      FinalDiskamount=0.0;
                                      total = price + gst;
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          'Coupon Code applied successfully',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: ConstantColors.green,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ), //Have coupon code?
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'By clicking. I accept ',
                                                  style: TextStyle(
                                                      color: ConstantColors
                                                          .greytext,
                                                      fontFamily:
                                                      "montserratmedium",
                                                      fontSize: 14.0),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                WebviewScreen(
                                                                    WebviewUrl:
                                                                    'https://goetc-dev.com/User/API/PageDetails?PageTitle=terms-of-use'
                                                                        .toString(),
                                                                    Title:
                                                                    'Terms & Conditions')));
                                                  },
                                                  child: Text(
                                                    'Terms of Use',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily:
                                                        'montserratmedium',
                                                        fontSize: 13.0),
                                                  ),
                                                ),
                                                Text(
                                                  ' & ',
                                                  style: TextStyle(
                                                      color: ConstantColors
                                                          .greytext,
                                                      fontFamily:
                                                      'montserratmedium',
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => WebviewScreen(
                                                            WebviewUrl:
                                                            'https://goetc-dev.com/User/API/PageDetails?PageTitle=privacy-policy'
                                                                .toString(),
                                                            Title:
                                                            'Privacy Policy')));
                                              },
                                              child: Text(
                                                'Privacy Policy',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily:
                                                    'montserratmedium',
                                                    fontSize: 13.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ), //Terms and conditions
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    if(isChecked) {
                                      launchRazorPay();
                                    }else{
                                      showErrorDialog(context,
                                          'Please accept terms and conditions to proceed');
                                    }
                                  },
                                  child: Container(

                                    color: ConstantColors.newcolor,
                                    margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                                    child: FlatButton(
                                      minWidth: double.infinity,
                                      height: 50,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹'+total.toString(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: ConstantColors
                                                    .white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                          Text(
                                            'PROCEED TO PAY',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: ConstantColors
                                                    .white,
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
                                        if(isChecked) {
                                          launchRazorPay();
                                        }else{
                                          showErrorDialog(context,
                                              'Please accept terms and conditions to proceed');
                                        }

                                        //Verify mobile number here
                                      },
                                    ),
                                  ),
                                ), //Proceed to pay
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Image.asset('assets/razorpay.png'),
                            ), // Razorpay
                            SizedBox(
                              height: 15,
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

  //to release resources
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
