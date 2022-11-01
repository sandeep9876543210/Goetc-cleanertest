import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewScreen extends StatefulWidget
{
  static const String routeName = "/about_us";
  var WebviewUrl;
  var Title;

  WebviewScreen({this.WebviewUrl,this.Title});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<WebviewScreen>
{

  late WebViewController controller1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Column(
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
                                ''+widget.Title,
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WebView(
                  initialUrl: ''+widget.WebviewUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller1 = webViewController;
                    // _loadHtmlFromAssets();
                    //print("onWebViewCreated");
                  },
                  javascriptChannels: <JavascriptChannel>[
                    _toasterJavascriptChannel(context),
                  ].toSet(),
                  navigationDelegate: (NavigationRequest request)
                  {
                    if(request.url.contains("mailto:")) {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'support@goetc.in',
                        query: 'subject=App Feedback', //add subject and body here
                      );
                      var url = params.toString();
                      launch(url);
                      return NavigationDecision.prevent;
                    }
                    else if (request.url.contains("tel:")) {
                      launch(('tel://18001234382'));
                      return NavigationDecision.prevent;
                    }else {
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    }
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
            ),
          ],
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

}
