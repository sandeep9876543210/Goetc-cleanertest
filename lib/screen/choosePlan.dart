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

import 'AdditionalInfo.dart';

class ChoosePlans extends StatefulWidget {

  var servicebookingid;

  ChoosePlans({this.servicebookingid});

  @override
  _ChoosePlansState createState() => _ChoosePlansState();
}

class _ChoosePlansState extends State<ChoosePlans> {

  bool isChecked = false;
  List<dynamic> CarMakeList=[];
  List<dynamic> CarModelList=[];
  List<dynamic> data=[];
  List<dynamic> data1=[];
  bool isLoading = true;

  final cartype = TextEditingController();
  final cartypeid = TextEditingController();
  final carmaker = TextEditingController();
  final carmakerid = TextEditingController();
  final ServiceCategoryId = TextEditingController();
  final ServiceId = TextEditingController();
  final CategoryName = TextEditingController();
  final CategoryNameID = TextEditingController();
  final CategoryNamePrice = TextEditingController();
  final PackageId = TextEditingController();
  final PackageName = TextEditingController();
  final ActualPrice = TextEditingController();
  final OfferPrice = TextEditingController();
  final ActualPriceBIKE = TextEditingController();
  final OfferPriceBIKE = TextEditingController();
  late ProgressDialog pr;
  bool isdataloaded=true;
  TextEditingController nameController = TextEditingController();
  int _radioValue=100;
  String currentlocation='';
  int CustomerId=0;
  String country='';
  String state='';
  String city='';
  int indexes=1000;
  List<String> times1 = [];


  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      carmaker.text='Choose Car Make';
      cartype.text='Choose Car Model';
      CategoryName.text='Choose Car Category';
      currentlocation = prefs.getString('selectedlocatio')!;
      country = prefs.getString('country')!;
      state = prefs.getString('state')!;
      city = prefs.getString('city')!;
      CustomerId = prefs.getInt('CustomerId')!;
    });
    String url="https://goetc-dev.com/API/MasterAPI/CarMakeList";
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CarMakeList = jsonDecode(response11.body)['CarMakeList'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String _countyDropDownValue ="Select Options";
  String selectedCountryName='Audi';
  String countryname ="";
  int countryId = 0;

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
                                    'Car Cleaning',
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
                                    height: 335,
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
                                        padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
                                        child: Center(
                                          child: Text(
                                            'Please choose Your Car Make & Model.',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w600,
                                                fontSize: 18,
                                                color: ConstantColors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(17.0, 10, 10, 5),
                                        child: Container(
                                          height: 56,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Color(0xFFF2F2F2), width: 1.3),
                                              borderRadius: BorderRadius.circular(5),
                                              ),
                                          child: CarMakeList == null
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
                                              ''+carmaker.text,
                                              style: TextStyle(
                                                  fontFamily: 'montserratregular',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0,
                                                  color: Color(0xFFFFFFFF)),
                                            ),
                                            items: CarMakeList.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item['CarMakeName'],style: TextStyle(color: Color(0xFF000000)),),
                                                value: item['CarMakeName'].toString(),
                                              );
                                            }).toList(),
                                            onChanged: (value) async {
                                              setState(() {
                                                carmaker.text=value.toString();
                                                cartype.text='Choose Car Model';
                                                CategoryName.text='Choose Car Category';
                                              });
                                              setState(()  {
                                                for(int i=0;i<CarMakeList.length;i++){
                                                  if(CarMakeList[i]['CarMakeName']==carmaker.text){
                                                    carmakerid.text=CarMakeList[i]['CarMakeId'].toString();
                                                    hitapis();
                                                  }
                                                }
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
                                        padding: const EdgeInsets.fromLTRB(17.0, 10, 10, 10),
                                        child: Container(
                                          height: 56,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFF2F2F2), width: 1.3),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: CarMakeList == null
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
                                              ''+cartype.text,
                                              style: TextStyle(
                                                  fontFamily: 'montserratregular',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0,
                                                  color: Color(0xFFFFFFFF)),
                                            ),
                                            items: carmaker.text=='Choose Car Make'?times1.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item,style: TextStyle(color: Color(0xFF000000)),),
                                                value: item.toString(),
                                              );
                                            }).toList():CarModelList.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item['ModelName'],style: TextStyle(color: Color(0xFF000000)),),
                                                value: item['ModelName'].toString(),
                                              );
                                            }).toList(),
                                            onTap: (){
                                              if(carmaker.text=='Choose Car Make'){
                                                Fluttertoast.showToast(
                                                    msg: "Please choose car model",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }

                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                cartype.text=value.toString();
                                              });
                                              setState(() {
                                                for(int i=0;i<CarModelList.length;i++){
                                                  if(CarModelList[i]['ModelName']==cartype.text){
                                                    cartypeid.text=CarModelList[i]['CarModelId'].toString();
                                                    hitapis1();
                                                  }
                                                }

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
                                        padding: const EdgeInsets.fromLTRB(17.0, 10, 10, 10),
                                        child: Container(
                                          height: 56,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Color(0xFFF2F2F2), width: 1.3),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: CarMakeList == null
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
                                              ''+CategoryName.text,
                                              style: TextStyle(
                                                  fontFamily: 'montserratregular',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.0,
                                                  color: Color(0xFFFFFFFF)),
                                            ),
                                            items:times1.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(item,style: TextStyle(color: Color(0xFF000000)),),
                                                value: item.toString(),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                            },

                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              fillColor: MaterialStateProperty.all(Color(0xFFF2F2F2)),
                                              activeColor: ConstantColors.black,
                                              checkColor: ConstantColors.black,
                                              value: isChecked,
                                              hoverColor: ConstantColors.white,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                    loadingpackages();
                                                });
                                              },
                                            ),
                                            Text(
                                              ' Want to add daily 2 wheeler cleaning\n too just for Rs 199/- click here',
                                              style: TextStyle(
                                                  color: ConstantColors.white,
                                                  fontFamily:"montserratmedium",
                                                  fontSize: 15.0),
                                            ),

                                          ],
                                        ),
                                      ),


                                    ]),
                              ],
                            ),
                            // Have You Required Bike Service too?
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
                                                color:  ConstantColors.newcolor1,
                                                width: 1.4)),
                                        child: Column(
                                          children: [
                                            if (isdataloaded==true) SizedBox(width: 0,) else
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    data1.isEmpty?
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
                                                                          ConstantColors.newcolor1,
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
                                                    ):ListView.builder(
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
                                                              ActualPriceBIKE.text=data1[index]['ActualPrice'].toString();
                                                              OfferPriceBIKE.text=data1[index]['OfferPrice'].toString();
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
                                                                    ActualPriceBIKE.text=data1[index]['ActualPrice'].toString();
                                                                    OfferPriceBIKE.text=data1[index]['OfferPrice'].toString();
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
                                                                      fontSize: 16.0),
                                                                ),
                                                              ),
                                                              index==0?Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    5.0, 0.0, 0.0, 0.0),
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
                                                                          ConstantColors.newcolor1,
                                                                          fontFamily: 'montserratsemibold',
                                                                          fontSize: 14.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ):SizedBox(width: 0,),
                                                              Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    5.0, 0.0, 5.0, 0.0),
                                                                child: Row(
                                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: [
                                                                    Text('₹'+data[index]['ActualPrice'].toString()+" + "+'₹'+data1[index]['ActualPrice'].toString(),
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontFamily: 'montserratsemibold',
                                                                          fontSize: 14.0),
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
    if(carmakerid.text==''){
      Fluttertoast.showToast(
          msg: "Select Car Make",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(cartypeid.text==''){
      Fluttertoast.showToast(
          msg: "Select Car Model",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(PackageId.text==''){
      Fluttertoast.showToast(
          msg: "Choose Package",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else {
      print('carmakerid  '+carmakerid.text.toString());
      print('cartypeid  '+cartypeid.text.toString());
      String url1 = "https://goetc-dev.com/API/ServicesAPI/BookPreServiceBooking";
      print(url1);
      Map<String, dynamic> body = {
        'CarMakeId': '' +carmakerid.text,
        'CarModelId': '' +cartypeid.text,
        'CategoryName': '' +CategoryName.text,
        'PackageId': '' +PackageId.text,
        'Address': '' +currentlocation,
        'Price': '' +ActualPriceBIKE.text==''?ActualPrice.text.toString():(double.parse(ActualPrice.text)+double.parse(ActualPriceBIKE.text)).toString(),
        'PackageName': '' +PackageName.text,
        'City': '' +city,
        'State': ''+state ,
        'Country': ''+country ,
        'CustomerId': '' +CustomerId.toString(),
        'ServiceName': 'Car Cleaning',
        'ServiceId': '1',
        'ServiceBookId': ''+widget.servicebookingid.toString(),
        'IsBike': 'Yes',
        'BikePrice': ''+ActualPriceBIKE.text.toString(),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdditionalInfo(
          carmakerid:carmakerid.text.toString(),
          cartypeid:cartypeid.text.toString(),
          CategoryName:CategoryName.text.toString(),
          PackageName:PackageName.text.toString(),
          PackageId:PackageId.text.toString(),
          ActualPrice:ActualPrice.text.toString(),
          OfferPrice:OfferPrice.text.toString(),
          ActualPriceBIKE:ActualPriceBIKE.text.toString(),
          OfferPriceBIKE:OfferPriceBIKE.text.toString(),
          ServiceBookId:widget.servicebookingid.toString(),
          Carmaker1:carmaker.text.toString(),
          Carmodel1:cartype.text.toString(),
        )));
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

  Future<void> hitapis() async {
    pr.show();
    String url="https://goetc-dev.com/API/MasterAPI/GetCarModelByCarMake?CarMakeId="+carmakerid.text.toString();
    print(''+url);
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CarModelList = jsonDecode(response11.body)['CarMakeList'];
    print(""+url);
    setState(() {
      pr.hide();
    });
    pr.hide();

  }
  Future<void> hitapis1() async {
    pr.hide();
    String url="https://goetc-dev.com/API/MasterAPI/GetCarCategoryByCarModel?CarMakeId="+carmakerid.text.toString()+'&CarModelId='+cartypeid.text.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CategoryName.text = jsonDecode(response11.body)['CategoryName'];
    ServiceId.text = jsonDecode(response11.body)['ServiceId'].toString();
    ServiceCategoryId.text = jsonDecode(response11.body)['ServiceCategoryId'].toString();
    print(""+url);
    print(""+ServiceCategoryId.text.toString());
    loadingpackages();

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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                color: Colors.white,
                child: Text(
                  "Select Your Car Model",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: CarMakeList.length == 0
                    ? Container()
                    : Container(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(
                          color: Colors.grey,
                        ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: CarMakeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        //highlightColor: Colors.red,
                        //splashColor: Colors.blueAccent,
                        onTap: () {
                          setState(() {
                            indexes=index;
                            carmaker.text = CarMakeList[index]['CarMakeName'];
                            carmakerid.text =CarMakeList[index]['CarMakeId'].toString();
                            Navigator.pop(context);
                          });
                        },
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
                              Text(
                                CarMakeList[index]['CarMakeName'],
                              ),
                              indexes == index
                                  ? Icon(
                                Icons.radio_button_checked,
                                color: ConstantColors.newcolor1,
                              )
                                  : Icon(Icons.radio_button_unchecked),
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
        ),
      );
    });
  }

  Future<void> showcarmodel11s23() async {

    pr.show();
    String url="https://goetc-dev.com/API/MasterAPI/GetCarModelByCarMake?CarMakeId="+carmakerid.text.toString();
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    CarModelList = jsonDecode(response11.body)['CarMakeList'];
    print(""+url);
    setState(() {
      pr.hide();
    });
    pr.hide();

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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                color: Colors.white,
                child: Text(
                  "Select Your Car Category",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: CarModelList.length == 0
                    ? Container()
                    : Container(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(
                          color: Colors.grey,
                        ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: CarModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        //highlightColor: Colors.red,
                        //splashColor: Colors.blueAccent,
                        onTap: () {
                          setState(() {
                            cartype.text = CarModelList[index]['ModelName'];
                            cartypeid.text =CarModelList[index]['CarModelId'].toString();
                            Navigator.pop(context);
                            loadingservices();
                          });
                        },
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
                              Text(
                                CarModelList[index]['ModelName'],
                              ),
                              indexes == index
                                  ? Icon(
                                Icons.radio_button_checked,
                                color: Colors.amber,
                              )
                                  : Icon(Icons.radio_button_unchecked),
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
        ),
      );
    });
  }

  Future<void> loadingservices() async {

  }

  int id = 1;
  String radioItem = 'Mango';



  Future<void> loadingpackages() async {
    data1=[];
    if(isChecked==true){
      String url = "https://goetc-dev.com/API/ServicesAPI/GetPlansByCarCategory?ServiceCategoryId=" +
          ServiceCategoryId.text.toString() + "&ServiceBookId=" +
          widget.servicebookingid.toString()+'&IsBike=yes';
      var response11 = await get(Uri.parse(url),
          headers: {"Accept": "application/json"});
      print("" + url);
      data = jsonDecode(response11.body)['data'];
      data1 = jsonDecode(response11.body)['data1'];
      print("" + data.toString());
      print("" + data1.toString());
      setState(() {
        isdataloaded = false;
      });
    }else {
      String url = "https://goetc-dev.com/API/ServicesAPI/GetPlansByCarCategory?ServiceCategoryId=" +
          ServiceCategoryId.text.toString() + "&ServiceBookId=" +
          widget.servicebookingid.toString();
      var response11 = await get(Uri.parse(url),
          headers: {"Accept": "application/json"});
      print("" + url);
      data = jsonDecode(response11.body)['data'];
      print("" + data.toString());
      setState(() {
        isdataloaded = false;
      });
    }
  }

}
// class ChoosePlan {
//   int PackageId;
//   int ServiceId;
//   int ServiceCategoryId;
//   String PackageName;
//   int DurationinDays;
//   double ActualPrice;
//   double OfferPrice;
//   String ServiceType;
//   int NoofServices;
//   String Description;
//   int OrderNo;
//   ChoosePlan({this.PackageId, this.ServiceId,this.ServiceCategoryId,this.PackageName,
//   this.DurationinDays,this.ActualPrice,this.OfferPrice,this.ServiceType,this.NoofServices,this.Description,this.OrderNo});
// }