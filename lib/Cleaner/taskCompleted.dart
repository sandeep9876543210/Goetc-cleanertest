import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:goetc/Cleaner/CleanerHomeScreen.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskCompleted extends StatefulWidget {

  var CustomerId;
  var MobileNo;
  var ServiceBookId;
  var BookingId;
  var otp;

  TaskCompleted({this.CustomerId,this.MobileNo,this.ServiceBookId,this.BookingId,this.otp});

  @override
  _TaskCompletedState createState() => _TaskCompletedState();
}


class _TaskCompletedState extends State<TaskCompleted> {

  @override
  void initState() {
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
  final feedbackController = TextEditingController();
  bool isLoading = true;
  int customerId1=0;


  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      MobileNo1 = prefs.getString('MobileNo')!;
      customerId1 = prefs.getInt('CustomerId')!;
    });
    String url = "https://goetc-dev.com/API/CleanerAPI/BookingDetails?BookingId="+widget.BookingId.toString();
    print('Get booking details'+url);
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

      setState(() {
        isLoading=false;
      });
    });

  }
  late ProgressDialog pr;
  final maxLines = 5;


  late String tenthDoc1;
  bool file2=false;
  TextEditingController vendor_image1 = new TextEditingController();
  final String uploadUrl1 = 'https://goetc-dev.com/API/CleanerAPI/PostBookingVideo';

  Future<String> uploadImage1(filepath, url) async {
    var request = MultipartRequest('POST', Uri.parse(url));
    request.files.add(await MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    var responseString = await res.stream.bytesToString();
    print(responseString);
    return responseString;
  }

  _tenthFilepicker1() async {
    var picked = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (picked != null) {
      setState(() {
        tenthDoc1 = picked.files.first.path!;
      });
      print(''+picked.files.first.path!);
      await pr.show();
      var res = await uploadImage( picked.files.first.path, uploadUrl1);
      print(res);
      Map data1 = jsonDecode(res);
      String fileName = picked.files.first.path!.split('/').last;
      print(fileName);
      vendor_image1.text = data1['fileName'].toString();


      String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingVideosInsertAPI";
      print(url1);
      Map<String, dynamic> body = {
        'BookingId': '' + widget.BookingId.toString(),
        'CleanerId': ''+customerId1.toString() ,
        'CustomerId': '' + widget.CustomerId.toString(),
        'VideoUrl': '' + vendor_image1.text.toString(),
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
      Map data11 = jsonDecode(response.body);
      print(data1);
      print(url1);
      file2=true;



      await pr.hide();
      setState(() {
        isLoading = true;
      });
    }
  }

  late String tenthDoc;
  bool file1=false;
  TextEditingController vendor_image = new TextEditingController();
  final String uploadUrl = 'https://goetc-dev.com/API/CleanerAPI/PostBookingImages';
  Future<String> uploadImage(filepath, url) async {
    var request = MultipartRequest('POST', Uri.parse(url));
    request.files.add(await MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    var responseString = await res.stream.bytesToString();
    print(responseString);
    return responseString;
  }

  _tenthFilepicker() async {
    var picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png',],
    );

    if (picked != null) {
      setState(() {
        tenthDoc = picked.files.first.path!;

      });
      print(''+picked.files.first.path!);
      await pr.show();

      var res = await uploadImage( picked.files.first.path, uploadUrl);
      print(res);
      Map data1 = jsonDecode(res);
      String fileName = picked.files.first.path!.split('/').last;
      print(fileName);
      vendor_image.text = data1['fileName'].toString();


      String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingImagesInsertAPI";
      print(url1);
      Map<String, dynamic> body = {
        'BookingId': '' + widget.BookingId.toString(),
        'CleanerId': ''+customerId1.toString() ,
        'CustomerId': '' + widget.CustomerId.toString(),
        'ImageUrl': '' + vendor_image.text.toString(),
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
      Map data11 = jsonDecode(response.body);
      print(data1);
      print(url1);
      file1=true;



      await pr.hide();
      setState(() {
        isLoading = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
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
                                    'Task Completed',
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
            body: GestureDetector(
              onTap: (){FocusScope.of(context).requestFocus(FocusNode());},
              child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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

                          Image.asset("assets/success.png",height: 150,width: 150,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'TASK COMPLETED',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                  'montserratbold',
                                  fontSize: 22,
                                  color: ConstantColors.darkGreen),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
                            child: Text(
                              'THANK YOU FOR YOUR SUPPORT',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                  'montserratregular',
                                  fontSize: 18,
                                  color: ConstantColors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                            child: Text(
                              'We have successfully completed task for Car Cleaning Service. Please share your feedback.',
                              maxLines: 5,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                  'montserratregular',
                                  fontSize: 14,
                                  color: ConstantColors.black),
                            ),
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Spacer(),
                                file1==true?GestureDetector(
                                  onTap: (){
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: ConstantColors.darkGreen,
                                    strokeWidth: 1,
                                    radius: Radius.circular(0),
                                    padding: EdgeInsets.all(6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 150,//MediaQuery.of(context).size.width*0.5,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        //color: Colors.red,
                                        child:
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Image.asset("assets/image.png",height:90,width:90,color: ConstantColors.darkGreen,),
                                            SizedBox(height: 10,),
                                            Text("UPLOAD PHOTO",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontFamily:
                                                'montserratregular',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ):GestureDetector(
                                  onTap: (){
                                    _tenthFilepicker();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: ConstantColors.orange,
                                    strokeWidth: 1,
                                    radius: Radius.circular(0),
                                    padding: EdgeInsets.all(6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 150,//MediaQuery.of(context).size.width*0.5,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        //color: Colors.red,
                                        child:
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Image.asset("assets/image.png",height:90,width:90,color: ConstantColors.orange,),
                                            SizedBox(height: 10,),
                                            Text("UPLOAD PHOTO",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontFamily:
                                                'montserratregular',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                file2==true?GestureDetector(
                                  onTap: (){
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: ConstantColors.darkGreen,
                                    strokeWidth: 1,
                                    radius: Radius.circular(0),
                                    padding: EdgeInsets.all(6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 150,//MediaQuery.of(context).size.width*0.5,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        //color: Colors.red,
                                        child:
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Image.asset("assets/videoCamera.png",height:90,width:90,color: ConstantColors.darkGreen,),
                                            SizedBox(height: 10,),
                                            Text("UPLOAD VIDEO",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontFamily:
                                                'montserratregular',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ):GestureDetector(
                                  onTap: (){
                                    _tenthFilepicker1();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: ConstantColors.orange,
                                    strokeWidth: 1,
                                    radius: Radius.circular(0),
                                    padding: EdgeInsets.all(6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(3.0)//
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 150,//MediaQuery.of(context).size.width*0.5,
                                        width: MediaQuery.of(context).size.width*0.4,
                                        //color: Colors.red,
                                        child:
                                        Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Image.asset("assets/videoCamera.png",height:90,width:90,color: ConstantColors.orange,),
                                            SizedBox(height: 10,),
                                            Text("UPLOAD VIDEO",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontFamily:
                                                'montserratregular',
                                                fontSize: 16,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.all(12),
                            height: 100,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)//
                                ),
                                color: Colors.white,
                                border: Border.all(color: Colors.white)
                            ),                            child: TextField(
                              maxLines: 4,
                              controller: feedbackController,
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
                                labelText: 'Write Feedback',
                                labelStyle: TextStyle(
                                  color: ConstantColors.greytext,
                                  fontFamily: 'montserratregular',
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  //color: ConstantColors.black,
                                  fontFamily: 'montserratregular',
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  13.0, 0.0, 13.0, 5.0),
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
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color:
                                        ConstantColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'montserratbold',
                                      ),
                                    ),
                                  ],
                                ),
                                color: ConstantColors.newcolor,
                                textColor: Colors.white,
                                onPressed: () {
                                  if(feedbackController.text==''){
                                    Fluttertoast.showToast(
                                        msg: "Enter feedback to submit",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }else{
                                    verifyregisteration();
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  Future<void> verifyregisteration() async {
    String url1 = "https://goetc-dev.com/API/CleanerAPI/BookingsCleanerReplyUpdateAPI";
    print(url1);
    Map<String, dynamic> body = {
      'BookingId': '' + widget.BookingId.toString(),
      'CleanerId': ''+customerId1.toString() ,
      'CustomerId': '' + widget.CustomerId.toString(),
      'CleanerReply': '' + feedbackController.text.toString(),
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CleanerHomeScreen()),
          ModalRoute.withName('/'));
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CleanerHomeScreen()),
          ModalRoute.withName('/'));
    }
    return;
  }

}
