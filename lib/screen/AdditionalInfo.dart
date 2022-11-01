import 'dart:convert';

import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderPreview.dart';

class AdditionalInfo extends StatefulWidget {
  var carmakerid,
      cartypeid,
      CategoryName,
      PackageName,
      PackageId,
      ActualPrice,
      OfferPrice,
      ActualPriceBIKE,
      OfferPriceBIKE,
      ServiceBookId,Carmaker1,Carmodel1;

  AdditionalInfo(
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
        this.Carmaker1,
        this.Carmodel1});

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isChecked = false;

  int CustomerId = 0;
  int CarInfoId = 0;
  final Name = TextEditingController();
  bool _validateName = false;

  final Email = TextEditingController();
  bool _validateEmail = false;

  final MobileNo = TextEditingController();
  bool _validateMobileNo = false;

  final Basement = TextEditingController();
  bool _validateBasement = false;

  final CarModel = TextEditingController();
  bool _validateCarModel = false;

  final VehicleNumber = TextEditingController();
  bool _validateVehicleNumber = false;

  final VehicleColor = TextEditingController();
  bool _validateVehicleColor = false;

  final Parking = TextEditingController();
  bool _validateParking = false;

  final Landmark = TextEditingController();
  bool _validateLandmark = false;

  final Instructions = TextEditingController();
  bool _validateInstruction = false;

  final Field1 = TextEditingController();
  bool _validateField1 = false;

  final Field2 = TextEditingController();
  bool _validateField2 = false;

  final CarCategory = TextEditingController();
  bool _validateCarCategory = false;


  @override
  void initState() {
    super.initState();
    loaddata();
    print('car maker: '+widget.Carmaker1);
    print('car type: '+widget.Carmodel1);
    print('car category: '+widget.CategoryName);
  }

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Name.text = prefs.getString('Name')!;
      Email.text = prefs.getString('Email')!;
      MobileNo.text = prefs.getString('MobileNo')!.toString();
      CustomerId = prefs.getInt('CustomerId')!;
    });

    String url =
        "https://goetc-dev.com/API/servicesAPI/CarServiceDetails?CustomerId=" +
            CustomerId.toString();
    print(url);
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      print(''+response1.body.toString());
      CarInfoId = jsonDecode(response1.body)['CarInfoId'];
      if (CarInfoId == 0) {
        CarModel.text =widget.Carmodel1;
        Field1.text = widget.Carmaker1;
        CarCategory.text = widget.CategoryName;
      } else {
        Basement.text = jsonDecode(response1.body)['Basement'].toString();
        // CarModel.text = jsonDecode(response1.body)['CarModel'].toString();
        VehicleNumber.text =
            jsonDecode(response1.body)['VehicleNumber'].toString();
        VehicleColor.text =
            jsonDecode(response1.body)['VehicleColor'].toString();
        Parking.text = jsonDecode(response1.body)['Parking'].toString();
        Landmark.text = jsonDecode(response1.body)['Landmark'].toString();
        Instructions.text =
            jsonDecode(response1.body)['Instructions'].toString();
        // Field1.text = jsonDecode(response1.body)['Field1'].toString();
        Field2.text = jsonDecode(response1.body)['Field2'].toString();
        // CarCategory.text = jsonDecode(response1.body)['CarCategory'].toString();
      }
      CarModel.text =widget.Carmodel1;
      Field1.text = widget.Carmaker1;
      CarCategory.text = widget.CategoryName;
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
                                    'Vehical Information',
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              color: Colors.transparent,
                              child: Stack(children: [
                                Center(
                                  child: Image.asset(
                                    'assets/blackng.png',
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 8),
                                  child: Text(
                                    'Verify Your Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: ConstantColors.white),
                                  ),
                                ),
                              ]),
                            ),
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
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      readOnly: true,
                                      controller: MobileNo,
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
                                        labelText: 'Mobile Number',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '+91 00000 00000',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      readOnly: true,
                                      controller: Name,
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
                                        labelText: 'Your Name',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: 'Your Name',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                                    child: TextField(
                                      readOnly: true,
                                      controller: Email,
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
                                        labelText: 'Email Address',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: 'Email Address',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 15, 15, 8),
                                    child: Text(
                                      'Vehical Information',
                                      style: TextStyle(
                                          fontFamily: 'montserratsemibold',
                                          color: Colors.black,
                                          fontSize: 19),
                                    ),
                                  ), //Vehical Information
                                  ///...
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: Field1,
                                      textInputAction: TextInputAction.next,
                                      readOnly: true,
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
                                        labelText: 'Car Make in Model',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: CarModel,
                                      readOnly: true,

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
                                        labelText: 'Car Model',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: CarCategory,
                                      readOnly: true,
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
                                        labelText: 'Car Category',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: Basement,
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
                                        labelText: 'Basement',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        errorText: _validateBasement ? '' : null,
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: VehicleNumber,
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
                                        labelText: 'Vehicle Number',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        errorText: _validateVehicleNumber ? '' : null,

                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: VehicleColor,
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
                                        labelText: 'Vehicle Color',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        errorText: _validateVehicleColor ? '' : null,

                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: Parking,
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
                                        labelText: 'Parking No / Pillar No',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        errorText: _validateParking ? '' : null,

                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextField(
                                      controller: Landmark,
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
                                        labelText: 'Land Mark',
                                        labelStyle: TextStyle(
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: ConstantColors.greytext,
                                          fontFamily: 'montserratregular',
                                        ),
                                        errorText: _validateLandmark ? '' : null,

                                        // suffixIcon: IconButton(
                                        //   onPressed: () {},
                                        //   icon: Icon(Icons.arrow_drop_down),
                                        // ),
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
                                            'CONTINUE BOOKING',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: ConstantColors
                                                  .white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'montserratbold',
                                            ),
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
                                        if(Basement.text==''){
                                          setState(() {
                                            Basement.text=='' ? _validateBasement = true : _validateBasement = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Please enter basement",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                        else if(VehicleNumber.text==''){
                                          setState(() {
                                            _validateBasement = false;
                                            VehicleNumber.text=='' ? _validateVehicleNumber = true : _validateVehicleNumber = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Please enter vehicle number",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else if(VehicleColor.text==''){
                                          setState(() {
                                            _validateBasement = false;
                                            _validateVehicleNumber = false;
                                            VehicleColor.text=='' ? _validateVehicleColor = true : _validateVehicleColor = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Please enter vehicle color",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else if(Parking.text==''){
                                          setState(() {
                                            _validateVehicleNumber = false;
                                            _validateVehicleColor = false;
                                            _validateBasement = false;
                                            Parking.text=='' ? _validateParking = true : _validateParking = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Please enter Parking No / Pillar No",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else {
                                          setState(() {
                                            _validateVehicleNumber = false;
                                            _validateVehicleColor = false;
                                            _validateBasement = false;
                                            _validateParking = false;
                                          });
                                          verifyregisteration();
                                        }
                                        //Verify mobile number here
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

  Future<void> verifyregisteration() async {
    String url ="https://goetc-dev.com/API/servicesAPI/CarServiceDetails?CustomerId=" +CustomerId.toString();
    print(url);
    var response1 =
    await get(Uri.parse(url), headers: {"Accept": "application/json"});
    setState(() {
      CarInfoId = jsonDecode(response1.body)['CarInfoId'];
    });
    String url1 =
        "https://goetc-dev.com/API/servicesAPI/AddCarAddiotionalDetails";
    print(url1);
    Map<String, dynamic> body = {
      'CarInfoId': '' + CarInfoId.toString(),
      'CustomerId': '' + CustomerId.toString(),
      'ServiceId': '1',
      'Basement': '' + Basement.text.toString(),
      'CarModel': '' + CarModel.text.toString(),
      'CarCategory': '' + CarCategory.text.toString(),
      'VehicleNumber': '' + VehicleNumber.text.toString(),
      'VehicleColor': '' + VehicleColor.text.toString(),
      'Parking': '' + Parking.text.toString(),
      'CLandMark': '' + Landmark.text.toString(),
      'Field1': '' + Field1.text.toString(),
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
      int CustomerId = data1['CustomerId'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderPreviewScreen(
                carmakerid: widget.carmakerid.toString(),
                cartypeid: widget.cartypeid.toString(),
                CategoryName: widget.CategoryName.toString(),
                PackageName: widget.PackageName.toString(),
                PackageId: widget.PackageId.toString(),
                ActualPrice: widget.ActualPrice.toString(),
                OfferPrice: widget.OfferPrice.toString(),
                ActualPriceBIKE:widget.ActualPriceBIKE.toString(),
                OfferPriceBIKE:widget.OfferPriceBIKE.toString(),
                ServiceBookId: widget.ServiceBookId.toString(),
                CustomerId: CustomerId.toString(),
                Carmaker1: widget.Carmaker1.toString(),
                Carmodel1: widget.Carmodel1.toString(),

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
}
