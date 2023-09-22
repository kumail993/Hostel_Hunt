import 'dart:async';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  late SharedPreferences _sharedPreferences;
  late ConnectivityResult _connectivityResult; // To store the connectivity status

  @override
  void initState() {
    super.initState();

    checkConnectivity(); // Check connectivity when the widget initializes
    isLogin();
  }

  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }

  void isLogin() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Timer(Duration(seconds: 3), () {
      if (_connectivityResult == ConnectivityResult.none) {
        // Handle no internet connectivity case
       showNoInternetDialog(context);
      }
      else {
        if (_sharedPreferences.getInt('userid') == null &&
            _sharedPreferences.getString('usermail') == null) {

          Route route = MaterialPageRoute(builder: (_) => LoginPage());
          Navigator.pushReplacement(context, route);
        } else {
          Route route = MaterialPageRoute(builder: (_) => home_page());
          Navigator.pushReplacement(context, route);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/splashScreen.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('Assets/logo4.0.png', fit: BoxFit.fill,),
                ),
                SizedBox(
                  width: 0,
                ),
                Text(
                  'Hostel Hunt',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Hunt Down Your Ideal Hostel',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 100),
              child: Text(
                'Find your hostel easily and travel anywhere you want with us',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(Icons.warning_amber_outlined),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'Assets/no internet.gif', // Replace with your image asset path
                height: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Please check your internet connection and try again.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();// Close the dialog
                //retryAction();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
