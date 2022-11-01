import 'package:flutter/material.dart';

class SearchLocation extends StatefulWidget {
  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
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
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: Image.asset(
                                "assets/choose.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 80,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                  // ignore: deprecated_member_use
                                  child: Image.asset(
                                    "assets/bglocations.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  child: FlatButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/location.png",
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Your Current Location',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  margin:
                                      EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/searchblack.png",
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Some Other Location',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                    color: Colors.transparent,
                                    textColor: Colors.black,
                                    onPressed: () {},
                                  ),
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
