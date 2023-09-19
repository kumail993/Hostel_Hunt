import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class student_portal extends StatefulWidget {
  @override
  _student_portalState createState() => _student_portalState();
}

class _student_portalState extends State<student_portal> {
  final _webViewKey = UniqueKey();
  bool _isLoadingPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Student Portal'),),
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>MyHomePage(),

              ),
            );
          },

          child:const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            key: _webViewKey,
            initialUrl: 'https://hms.hostel-hunt.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              setState(() {
                _isLoadingPage = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          if (_isLoadingPage)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}