import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goetc/constant/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'WashroomChoosePlans.dart';

class Downloadinvoic extends StatefulWidget {

  var bookingid;

  Downloadinvoic({this.bookingid});



  @override
  _WashroomDetails createState() => _WashroomDetails();
}

class _WashroomDetails extends State<Downloadinvoic> {

  String currentlocation='';
  final searchinput = TextEditingController();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  late PickResult selectedPlace;
  bool isLoading = false;
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future<void> loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
    });
    print(''+currentlocation);
    document = await PDFDocument.fromURL(""+widget.bookingid,
    );
    setState(() => _isLoading = false);

  }
   late WebViewController controller1;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          backgroundColor: ConstantColors.whiteBg,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Stack(children: [
                          Container(
                            width: double.infinity,
                            child: Image.asset(
                              "assets/blackng.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 8, 0),
                                    child: Image.asset(
                                      "assets/leftArrowWhite.png",
                                      fit: BoxFit.fitWidth,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.pop(context);
                                  },

                                ),
                                Text(
                                  'Invoice',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                    child: PDFViewer(
                document: document,
                zoomSteps: 1,
                //uncomment below line to preload all pages
                // lazyLoad: false,
                // uncomment below line to scroll vertically
                // scrollDirection: Axis.vertical,

                //uncomment below code to replace bottom navigation with your own
                /* navigationBuilder:
                        (context, page, totalPages, jumpToPage, animateToPage) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.first_page),
                            onPressed: () {
                              jumpToPage()(page: 0);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              animateToPage(page: page - 2);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              animateToPage(page: page);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.last_page),
                            onPressed: () {
                              jumpToPage(page: totalPages - 1);
                            },
                          ),
                        ],
                      );
                    }, */
              ),
                  ),
            ],
          ),
        ),
      ),
    );
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
  Future<void> movetoother() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedlocatio', ''+selectedPlace.formattedAddress.toString());
    setState(() {
      currentlocation = prefs.getString('selectedlocatio')!;
    });
  }
}
