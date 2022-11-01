
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:goetc/Cleaner/orderDetails.dart';
import 'package:goetc/screen/WahroomDetails.dart';
import 'package:goetc/screen/Webview.dart';
import 'package:goetc/screen/animated_custom_dialog.dart';
import 'package:goetc/screen/completedOrders.dart';
import 'package:goetc/screen/guest_dialog.dart';
import 'package:goetc/screen/loginscreen.dart';
import 'package:goetc/screen/personalInformation.dart';
import 'package:flutter/material.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:images_picker/images_picker.dart';




class CleanerHomeScreen extends StatefulWidget {
  @override
  _CleanerHomeScreenState createState() => _CleanerHomeScreenState();
}


class _CleanerHomeScreenState extends State<CleanerHomeScreen> {

  bool isLoading = true;
  bool isLoading1 = true;
  List<dynamic> bookingsList=[];
  int customerId=0;
  int SocietyId=0;
  String country='';
  String state='';
  String city='';
  String name='';
  String email='';
  String mobileNo='';
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  String createDate='';
  String createDate1='';
  String CleanerCities='';
  String CleanerAreas='';
  String CleanerSocieties='';
  late DateTime pickedDate;
  late DateTime presntDate;

  getData() async {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      createDate = formatter.format(DateTime.now());
      createDate1 = formatter.format(DateTime.now());
      print(''+createDate);
      name = prefs.getString('Name')!;
      email = prefs.getString('Email')!;
      mobileNo = prefs.getString('MobileNo')!;
      customerId = prefs.getInt('CustomerId')!;
      CleanerCities = prefs.getString('CleanerCities')!;
      CleanerAreas = prefs.getString('CleanerAreas')!;
      // CleanerSocieties = prefs.getString('CleanerSocieties')!;
    });
    print('Login Customer id is: ' + customerId.toString());
    // String url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString();

    String url1="https://goetc-dev.com/API/ServicesAPI/CleanerSocieties?MobileNo="+mobileNo;
    print(''+url1);
    var response11wqe = await get(Uri.parse(url1),
        headers: {"Accept": "application/json"});
    CitiesList = jsonDecode(response11wqe.body)['CleanerSocieties'];
    print(''+CitiesList.toString());

    if(CitiesList==null){

    }else{
      if(CitiesList.length>0){
        setState(() {
          CleanerSocieties=CitiesList[0]['Name'].toString();
          SocietyId=CitiesList[0]['SocietyId'];
          print(''+SocietyId.toString());
          print(''+CleanerSocieties.toString());

        });
        String url;
        url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString()+'&Bookings=Today&SocietyId='+SocietyId.toString();
        var response11 = await get(Uri.parse(url),
            headers: {"Accept": "application/json"});
        print("Get recent bookings: "+url);
        bookingsList = jsonDecode(response11.body)['BookingsList'];
        // print("Bookings list data is: " +bookingsList.toString());
        print("Bookings count is: "+bookingsList.length.toString());

      }
    }

    setState(() {
      isLoading=false;
    });
  }
  List<dynamic> CitiesList=[];

  Future<void> showcarmodel11s() async {
    showDialog(context: context,builder: (context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 25.0,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      color: Colors.white,
                      child: Text(
                        "Choose Society",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    CitiesList.length == 0
                        ? Container()
                        : Container(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(
                              color: Colors.grey,
                            ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: CitiesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new InkWell(
                            //highlightColor: Colors.red,
                            //splashColor: Colors.blueAccent,
                            onTap: () async {
                              setState(() {
                                CleanerSocieties=CitiesList[index]['Name'].toString();
                                SocietyId=CitiesList[index]['SocietyId'];
                              });
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              setState(()  {
                                prefs.setString('CleanerSocieties', ''+CitiesList[index]['Name'].toString());
                                Navigator.pop(context);
                              });
                              setState(() {
                                isLoading=true;
                              });
                              getData();
                            },
                            child: new Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                    // I have used my own CustomText class to customise TextWidget.
                                  Text(
                                    CitiesList[index]['Name'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  getData1() async {
    // String url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString();

    String url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString()+'&StartDate==Today';
    var response11 = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print("Get recent bookings: "+url);
    bookingsList = jsonDecode(response11.body)['BookingsList'];
    // print("Bookings list data is: " +bookingsList.toString());
    print("Bookings count is: "+bookingsList.length.toString());
    setState(() {
      isLoading=false;
    });
  }

  late AppsflyerSdk appsflyerSdk;
  String afDevKey = "MoSSbBCoEmz7vNiJccYMmY";
  String appId = "com.goetc.goetccleanertest";

  void appflyer()async{
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
          "CleanerHomescreen", {"JD Pressed Key": "JD Pressed Value"});
      appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
        switch (dp.status) {
          case Status.FOUND:
            print(dp.deepLink?.toString());
            print("deep link value1: ${dp.deepLink}");
            print("deep link value2: ${dp.deepLink?.deepLinkValue}");
            break;
          case Status.NOT_FOUND:
            print("deep link not found");
            break;
          case Status.ERROR:
            print("deep link error: ${dp.error}");
            break;
          case Status.PARSE_ERROR:
            print("deep link status parsing error");
            break;
        }
      });

    } catch (e) {
      print('error print ${e}');
    }
  }

  @override
  void initState() {
    appflyer();
    super.initState();
    print('customer id${customerId.toString()}');
    pickedDate = DateTime.now();
    presntDate=DateTime.now();

   // _appsflyerSdk.setCollectIMEI(true);
    //_appsflyerSdk.setImeiData("imei");

    // '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',

    getData();
  }
bool dates=true;
  void _pickDate() async {
    DateTime? date = await showDatePicker(
        context: this.context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50));
    if (date != null) {
      setState(() {
        pickedDate = date;
        createDate='${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
        String present='${presntDate.day}/${presntDate.month}/${presntDate.year}';
        print('presnet date $date');
        print('picked date $createDate');
        present==createDate?dates=true:dates=false;

      });

      if(createDate!=createDate1){
        String url;
        if(SocietyId==0){
          url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString()+'&StartDate='+createDate;
        }else{
          url="https://goetc-dev.com/API/CleanerAPI/bookingsList?CleanerId="+customerId.toString()+'&StartDate='+createDate+'&SocietyId='+SocietyId.toString();
        }
        var response11 = await get(Uri.parse(url),
            headers: {"Accept": "application/json"});
        print("Get recent bookings: "+url);
        bookingsList = jsonDecode(response11.body)['BookingsList'];
        // print("Bookings list data is: " +bookingsList.toString());
        print("Bookings count is: "+bookingsList.length.toString());


        setState(() {
          isLoading=false;
        });
      }

    }
  }
  String? path='';
  void opencamera()async{
    List<Media>? res = await ImagesPicker.openCamera(
      // pickType: PickType.video,
      pickType: PickType.image,
      quality: 0.8,
      maxSize: 800,
      // cropOpt: CropOption(
      //   aspectRatio: CropAspectRatio.wh16x9,
      // ),
      maxTime: 15,
    );

    if (res != null) {
       path=res[0].path;
      print('path--$path}');
      setState(() {
     sendimagetoApi();
      });
    }

  }
  sendimagetoApi()async{
    Response response=await post(Uri.parse('https://goetc-dev.com/API/CleanerAPI/PostBookingImages'),body: {
      'image':path,
    });
    if (response.statusCode == 200) {
      Map mapresponse = json.decode(response.body);
      String msg=mapresponse['msg'];
      print("updated msg---"+msg);

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          key: _key, // Assign the key to Scaffold.
          backgroundColor: Colors.white,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: ConstantColors.newcolor,
                      child: Stack(children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          showcarmodel11s();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                              ),
                                              color: Colors.transparent,
                                              border: Border.all(color: Colors.white)
                                          ),
                                          height:38,
                                          //color: Colors.red,
                                          child:
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text("Society",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Image.asset(
                                                'assets/filter.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          _pickDate();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                              ),
                                              color: Colors.transparent,
                                              border: Border.all(color: Colors.white)
                                          ),
                                          height:38,
                                          //color: Colors.red,
                                          child:
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text("Date",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Image.asset(
                                                'assets/filter.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                  SizedBox(width: 10,),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10,),
                                Text(
                                  'Society:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: ConstantColors.white,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  ' '+CleanerSocieties,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: ConstantColors.white,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: ConstantColors.white,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  ''+createDate,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: ConstantColors.white,
                                  ),
                                ),
                                SizedBox(width: 10,),

                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ]),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                      child: Text(
                        "SCHEDULE : ${bookingsList.length}",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    Expanded(
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children:[
                            isLoading
                                ? Shimmer.fromColors(
                              baseColor: ConstantColors.disablegrey1,
                              highlightColor: ConstantColors.disablegrey1,
                              enabled: true,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24.0, 23.0, 24, 0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border.all(
                                              color: Color(0xFFF2F2F2), width: 1),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: 64.0,
                                                width: 56.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(8, 14, 0, 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(1.0),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.6,
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  new Text(
                                                    '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF141E28)
                                                          .withOpacity(0.45),
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                      fontFamily: "Lorin",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                : bookingsList.length==0?Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Center(
                                  child: Text(
                                    "No Schedule Found",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                ),
                              ],
                            ):GestureDetector(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: bookingsList.length,
                                    itemBuilder: (context, index) {
                                      return (bookingsList[index]["ServiceName"] == "Car Cleaning")
                                          ?GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => OrderDetails(
                                                    BookingId:  bookingsList[index]['BookingId'].toString(),
                                                  )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: SizedBox(
                                            child: Container(

                                              decoration: BoxDecoration(
                                                  gradient: bookingsList[index]['Status']=='Completed'? LinearGradient(
                                                      colors: [Color(0xff27763d), Color(0xff72ac47)],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                  ):bookingsList[index]['Status']=='Rejected'?LinearGradient(
                                                    colors: [Color(0xffbc2831), Color(0xfffc636c)],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ):LinearGradient(
                                                    colors: [Color(0xffffffff), Color(0xffffffff)],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  // color: bookingsList[index]['Status']=='Completed'?Colors.green[400]:bookingsList[index]['Status']=='Rejected'?Colors.red[400]:Colors.white,
                                                  borderRadius:

                                                  BorderRadius.all(Radius.circular(5.0) //
                                                  ),
                                                  border: Border.all(
                                                      color: ConstantColors.green, width: 0.6)),
                                              child:

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15,top: 10),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Car Maker & Car Model',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(bookingsList[index]['CarMake']==''?
                                                            '':bookingsList[index]['CarMake']+'&\n'+bookingsList[index]['CarModel'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Text(
                                                              'Basement',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['Basement'],
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Text(
                                                              'Timings',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['SlotTime'],
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),



                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10,top: 10),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Vehicle Number',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['VehicleNumber'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Text(
                                                              'Parking/Piller No',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['Parking'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          bookingsList[index]['TaskName']=='Exterior Cleaning'?
                                                          ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(5)),child:
                                                          Image.asset('assets/externalclean.png', width:74,height: 30,),):SizedBox(width: 0,height: 0,),

                                                          bookingsList[index]['TaskName']=='Internal Cleaning'?
                                                          ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(5)),child:
                                                          Image.asset('assets/internalclean.png',
                                                            width:74,height: 30,))
                                                        :SizedBox(width: 0,height: 0,),
                                                          bookingsList[index]['TaskName']=='Shampoo Wash'?
                                                          ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(5)),child:
                                                          Image.asset('assets/shampoo.png',
                                                            width:74,height: 30,)):SizedBox(width: 0,height: 0,),
                                                          SizedBox(height: 40,),
                                                          bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                            padding: const EdgeInsets.only(right:8.0),
                                                            child: SizedBox(width: 74,height: 30,),
                                                          ):GestureDetector(
                                                            onTap: ()async{
                                                              // Capture a photo
                                                              dates?opencamera():'';
                                                              //  verifyregisteration(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']);
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right:8.0),
                                                              child: SizedBox(
                                                                width: 74,height: 30,
                                                                child:dates? Image.asset('assets/accept.png',
                                                                  width: 30,
                                                                  height: 30,):Image.asset("assets/acceptgrey.png",width: 30,height: 30,),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20,),
                                                          bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                            padding: const EdgeInsets.only(right:8.0),
                                                            child: SizedBox(width: 30,height: 30,),
                                                          ):GestureDetector(
                                                            onTap: (){
                                                              dates? showpromocode(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']):'';
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right:8.0),
                                                              child: SizedBox(
                                                                width: 74,height: 30,
                                                                child: dates?Image.asset('assets/remove.png',
                                                                  width: 30,
                                                                  height: 30,):Image.asset('assets/removegrey.png',width: 30,height: 30,),
                                                              ),
                                                            ),
                                                          ),




                                                        ],
                                                      ),

                                                 /*     Flexible(
                                                        flex:8,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.fromLTRB(10, 15, 10, 5),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Car Maker & Car Model',
                                                                style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 3),
                                                              Text(bookingsList[index]['CarMake']==''?
                                                                '':bookingsList[index]['CarMake']+'&'+bookingsList[index]['CarModel'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
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
                                                          const EdgeInsets.fromLTRB(0, 15, 15, 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Vehicle Number',
                                                                style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 3),
                                                              Text(
                                                                ''+bookingsList[index]['VehicleNumber'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),*/
                                                   /*   Spacer(),
                                                      bookingsList[index]['TaskName']=='Exterior Cleaning'?Image.asset('assets/externalclean.png',
                                                        width:74,height: 30,):SizedBox(width: 0,height: 0,),
                                                      bookingsList[index]['TaskName']=='Internal Cleaning'?Image.asset('assets/internalclean.png',
                                                        width:74,height: 30,):SizedBox(width: 0,height: 0,),
                                                      bookingsList[index]['TaskName']=='Shampoo Wash'?Image.asset('assets/shampoo.png',
                                                        width:74,height: 30,):SizedBox(width: 0,height: 0,),*/
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
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
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['Basement'],
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Parking/Piller No',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['Parking'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: SizedBox(width: 74,height: 30,),
                                                      ):GestureDetector(
                                                        onTap: ()async{
                                                          // Capture a photo
                                                          dates?opencamera():'';
                                                        //  verifyregisteration(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: SizedBox(
                                                            width: 74,height: 30,
                                                            child:dates? Image.asset('assets/accept.png',
                                                              width: 30,
                                                              height: 30,):Image.asset("assets/acceptgrey.png",width: 30,height: 30,),
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
                                                              'Timings',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['SlotTime'],
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: SizedBox(width: 30,height: 30,),
                                                      ):GestureDetector(
                                                        onTap: (){
                                                          dates? showpromocode(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']):'';
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: SizedBox(
                                                            width: 74,height: 30,
                                                            child: dates?Image.asset('assets/remove.png',
                                                              width: 30,
                                                              height: 30,):Image.asset('assets/removegrey.png',width: 30,height: 30,),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),*/

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          :GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => OrderDetails(
                                                    BookingId:  bookingsList[index]['BookingId'].toString(),
                                                  )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: SizedBox(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: bookingsList[index]['Status']=='Completed'?Colors.green[400]:bookingsList[index]['Status']=='Rejected'?Colors.red[400]:Colors.white,
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10.0) //
                                                  ),
                                                  border: Border.all(
                                                      color: ConstantColors.green, width: 0.6)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  // Padding(
                                                  //   padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Image.asset('assets/washroom.png',
                                                  //         width: 30,
                                                  //         height: 30,),
                                                  //       SizedBox(
                                                  //         width: 5,
                                                  //       ),
                                                  //       Text(
                                                  //         'Washroom Cleaning',
                                                  //         overflow: TextOverflow.ellipsis,
                                                  //         maxLines: 1,
                                                  //         style: TextStyle(
                                                  //           fontSize: 15.0,
                                                  //           fontFamily: "montserratmedium",
                                                  //           color: ConstantColors.gbluend,
                                                  //         ),
                                                  //       ),
                                                  //       Spacer(),
                                                  //       Container(
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius: BorderRadius.all(Radius.circular(18.0)//
                                                  //           ),
                                                  //           color: ConstantColors.newcolor,
                                                  //           // border: Border.all(color: Colors.white)
                                                  //         ),
                                                  //         height:36,
                                                  //         width: 135,
                                                  //         //color: Colors.red,
                                                  //         child:
                                                  //         Row(
                                                  //           children: [
                                                  //             Spacer(),
                                                  //             Text("MORE INFO ",
                                                  //               style: TextStyle(
                                                  //                 color: Colors.white,
                                                  //                 fontWeight: FontWeight.w500,
                                                  //                 fontSize: 15,
                                                  //               ),
                                                  //             ),
                                                  //
                                                  //             Icon(
                                                  //               Icons.arrow_forward_ios,
                                                  //               size: 15,
                                                  //               color: Color(0xffffffff),
                                                  //             ),
                                                  //
                                                  //             SizedBox(width: 8,)
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       SizedBox(width: 10)
                                                  //
                                                  //     ],
                                                  //   ),
                                                  // ),
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
                                                              'Slot',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['SlotTime'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
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
                                                                'Date',
                                                                style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 3),
                                                              Text(
                                                                ''+bookingsList[index]['PaymentDate'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: SizedBox(width: 30,height: 30,),
                                                      ):GestureDetector(
                                                        onTap: (){
                                                          verifyregisteration(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Image.asset('assets/accept.png',
                                                            width: 30,
                                                            height: 30,),
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
                                                              'No of Times',
                                                              style: TextStyle(
                                                                fontSize: 11.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                              ''+bookingsList[index]['NoOfTimes'],
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
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
                                                                'No of Washrooms',
                                                                style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                              SizedBox(height: 3),
                                                              Text(
                                                                ''+bookingsList[index]['NoOfWashrooms'],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: bookingsList[index]['Status']=='Completed'?Colors.white:bookingsList[index]['Status']=='Rejected'?Colors.white:Colors.black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      bookingsList[index]['Status']=='Completed'||bookingsList[index]['Status']=='Rejected'?Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: SizedBox(width: 30,height: 30,),
                                                      ):GestureDetector(
                                                        onTap: (){
                                                          showpromocode(bookingsList[index]['TaskId'],bookingsList[index]['CleanerId'],bookingsList[index]['CustomerId']);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Image.asset('assets/remove.png',
                                                            width: 30,
                                                            height: 30,),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ],
            ),
          ),
          // bottomNavigationBar: Container(
          //   height: 50,
          //   width: double.infinity,
          //   child:isLoading1==true?TextButton(
          //     child: Text('Start Task',
          //       style: TextStyle(
          //           fontSize: 18.0,
          //           color:
          //           ConstantColors.white,
          //           fontWeight: FontWeight.w600),),
          //     style: TextButton.styleFrom(
          //       backgroundColor: ConstantColors.newcolor,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         isLoading1=false;
          //       });
          //     },
          //   ):TextButton(
          //     child: Text('End Task',
          //       style: TextStyle(
          //           fontSize: 18.0,
          //           color:
          //           ConstantColors.white,
          //           fontWeight: FontWeight.w600),),
          //     style: TextButton.styleFrom(
          //       backgroundColor: ConstantColors.newcolor,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         isLoading1=true;
          //       });
          //     },
          //   ),
          //
          // ),

          appBar: AppBar(
            backgroundColor: ConstantColors.newcolor, // status bar color
            title: Container(
              height: 50,
              child: Image.asset("assets/logo.png"),
            ),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
// Scaffold.of(context).openDrawer();
                    if(email=='guest@guest.com') {
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    }else {
                      _key.currentState!.openDrawer();
                    }
                  },
                  child: Image.asset(
                    "assets/sidemenu.png",
//fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

          ),
          drawer: new Drawer(
              child: Container(
                color: Color(0xff161A49),
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(name==''? "":name,style: TextStyle(color: Color(0xffffffff),fontSize: 18),)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text(mobileNo==''? "":mobileNo,style: TextStyle(color: Color(0xffffffff),fontSize: 18),)),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    ListTile(
                        leading: Image.asset(
                          'assets/myprofile.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "My Profile",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => PersonalInformation()));
                        }),

                    // ListTile(
                    //     leading: Image.asset(
                    //       'assets/myorder.png',
                    //       height: 20,
                    //       width: 20,
                    //       color: Colors.white,
                    //     ),
                    //     title: Text(
                    //       "My Orders",
                    //       style: TextStyle(color: Color(0xffffffff)),
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 15,
                    //       color: Color(0xffffffff),
                    //     ),
                    //     onTap: () {
                    //       Navigator.push(
                    //           context, MaterialPageRoute(builder: (context) => CompletedOrders()));
                    //     }),

                    ListTile(
                        leading: Image.asset(
                          'assets/whatsapp.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Whatsapp Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          launch("https://wa.me/919381280841");
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/phonecall.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Call Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          launch(('tel://18001234382'));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/email.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Email Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'support@goetc.in',
                            query: 'subject=App Feedback', //add subject and body here
                          );
                          var url = params.toString();
                          await launch(url);
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/about.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "About Us",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=about-us'
                                          .toString(),Title:'About Us')));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/returnbox.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Return & Refund Policy",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=refunds-payment-policy'
                                          .toString(),Title:'Return & Refund Policy')));
                        }),
                    ListTile(
                        leading: Image.asset(
                          'assets/privacy.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebviewScreen(
                                      WebviewUrl:'https://goetc-dev.com/User/API/PageDetails?PageTitle=privacy-policy'
                                          .toString(),Title:'Privacy Policy')));
                        }),

                    ListTile(
                        leading: Image.asset(
                          'assets/logout.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Logout",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xffffffff),
                        ),
                        onTap: () async {
                          SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => LoginScreen()),
                              ModalRoute.withName('/'));
                        }),

                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> verifyregisteration(var Bookingid,var cleanerid,var customerid) async {
    String url='https://goetc-dev.com/API/CleanerAPI/BookingTasksUpdateAPI?TaskId='+Bookingid.toString()+'&Status=Completed&CleanerId='+cleanerid.toString();
    var response11wqe = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(''+url);
    print(''+response11wqe.body);
    // String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingsCleanerReplyUpdateAPI";
    // String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingStatusInsertAPI";
    // print(url1);
    // Map<String, dynamic> body = {
    //   'BookingId': '' + Bookingid.toString(),
    //   'CleanerId': ''+cleanerid.toString() ,
    //   'CustomerId': '' + customerid.toString(),
    //   'Status': 'Completed' ,
    //   'CleanerReply': 'Completed' ,
    // };
    // print('registration api: ' + body.toString());
    // final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // final encoding = Encoding.getByName('utf-8');
    // final response = await post(
    //   Uri.parse(url1),
    //   headers: headers,
    //   body: body,
    //   encoding: encoding,
    // );
    // Map data1 = jsonDecode(response.body);
    // print(data1);
    // print(url1);
    // String msg = data1['msg'];
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CleanerHomeScreen()),
        ModalRoute.withName('/'));
    return;
  }
  final promocode = TextEditingController();

  showpromocode(var Bookingid,var cleanerid,var customerid) {
    List<String> items=['I Did not Clean the Car','Vehicle not available in parking\n(empty parking)'];
    String? dropdownValue=items.first;
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
                        'Feedback!',
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
                  padding:
                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:  StatefulBuilder(
                      builder: (BuildContext context, StateSetter dropDownState){
                        return DropdownButton<String>(
                          value: dropdownValue,
                          underline: Container(),
                          items: items.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value, style: TextStyle(fontWeight: FontWeight.w500),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            dropDownState(() {
                              dropdownValue = value;
                            });
                          },
                        );
                      }
                  ),
                ),

               /* Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 0.0, 20.0, 5.0),
                  child:
                  DropdownButton<String>(
                    iconDisabledColor: null,
                    value: items.first,
                  //  icon: const Icon(Icons.),
                    elevation: 0,
                  //  style: const TextStyle(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                       items.first = value!;
                       print('valuee--${items.first}');
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ),*/

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
                                msg: "Please Enter Comments",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            verifyregisteration1(Bookingid,cleanerid,customerid);
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        elevation: 0,
                        splashColor: Color(0xff161a49),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Submit',
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

  Future<void> verifyregisteration1(var Bookingid,var cleanerid,var customerid) async {
    // String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingStatusInsertAPI";
    // print(url1);
    // Map<String, dynamic> body = {
    //   'BookingId': '' + Bookingid.toString(),
    //   'CleanerId': ''+cleanerid.toString() ,
    //   'CustomerId': '' + customerid.toString(),
    //   'Status': 'Rejected' ,
    //   'CleanerReply': ''+promocode.text ,
    // };
    // print('registration api: ' + body.toString());
    // final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // final encoding = Encoding.getByName('utf-8');
    // final response = await post(
    //   Uri.parse(url1),
    //   headers: headers,
    //   body: body,
    //   encoding: encoding,
    // );
    // Map data1 = jsonDecode(response.body);
    // print(data1);
    // print(url1);
    String url='https://goetc-dev.com/API/CleanerAPI/BookingTasksUpdateAPI?TaskId='+Bookingid.toString()+'&Status=Rejected&CleanerId='+cleanerid.toString()+'&CleanerComments='+promocode.text;
    var response11wqe = await get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    print(''+url);
    print(''+response11wqe.body);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CleanerHomeScreen()),
        ModalRoute.withName('/'));
    return;
  }
}





