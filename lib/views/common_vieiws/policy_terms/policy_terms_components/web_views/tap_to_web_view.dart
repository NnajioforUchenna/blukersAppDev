import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../loading_animation.dart';
import '../my_app_bar.dart';

class TapToWebView extends StatelessWidget {
  final String url;
  final String text;
  final String text2;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String appBarTitle;

  const TapToWebView({super.key, 
    this.url = 'https://google.com',
    this.text = 'Tap to Web View',
    this.text2 = '',
    this.textColor = const Color.fromRGBO(0, 0, 0, 1),
    // this.fontSize = 16,
    // this.fontWeight = FontWeight.w600,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w100,
    this.appBarTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _openWebView(
              context,
              url,
              appBarTitle,
            );
          },
          child: Container(
              // margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  void _openWebView(BuildContext context, String url, title) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingAnimation();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith(url)) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: MyAppBar(title: title),
          body: WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}
