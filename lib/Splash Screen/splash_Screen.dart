import 'dart:async';
import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:findyournewhome/Bottom_navbar/Home.dart';
class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  late SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();

    isLogin();
  }

  void isLogin() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Timer(Duration(seconds: 3), () {
      if (_sharedPreferences.getInt('userid') == null &&
          _sharedPreferences.getString('usermail') == null) {
        Route route = MaterialPageRoute(builder: (_) => LoginPage());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => home_page());
        Navigator.pushReplacement(context, route);
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

            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
              children:[

                SizedBox(
                  height: 150,
                  width: 150,
                  child:
                Image.asset('Assets/logo4.0.png',fit: BoxFit.fill,),
                ),
              const SizedBox(
                width: 0,
              ),

              const Text('Hostel Hunt',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              ),

              ]
                ),
                const SizedBox(height: 5,),
                const Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child:
                Text('Hunt Down Your Ideal Hostel',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,

                ),
                )
                ),
                const SizedBox(height: 20,),
                const Padding(padding: EdgeInsets.only(left: 20,right: 100),
                    child:
                    Text('Find your hostel easily and travel any where you want with us',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,

                      ),
                    )
                ),
        // const SizedBox(
        //   height: 200,
        // ),
        // Expanded(
        //   flex: 1,
        //   child:
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children:[
        // FittedBox(
        //
        //   child:Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //
        //       ElevatedButton(
        //           style: ButtonStyle(
        //               padding: MaterialStateProperty.all(
        //                 const EdgeInsets.symmetric(
        //                     vertical: 20.0, horizontal: 50.0),
        //               ),
        //               foregroundColor: MaterialStateProperty.all<
        //                   Color>(Theme.of(context).colorScheme.secondary,),
        //               backgroundColor: MaterialStateProperty.all<
        //                   Color>( Theme.of(context).colorScheme.primary,),
        //               shape: MaterialStateProperty.all<
        //                   RoundedRectangleBorder>(
        //                   RoundedRectangleBorder(
        //                     side:  BorderSide(color: Theme.of(context).colorScheme.primary,),
        //                     borderRadius: BorderRadius.circular(
        //                         18.0),
        //                   )
        //               )
        //           ),
        //           onPressed: () {
        //             // Navigator.pushReplacement(context,
        //             //   // MaterialPageRoute(builder: (context) =>const LoginPage(),
        //             //
        //             // ),
        //             if (_sharedPreferences.getInt('userid') == null &&
        //                 _sharedPreferences.getString('usermail') == null) {
        //               Route route = MaterialPageRoute(
        //                   builder: (_) => LoginPage());
        //               Navigator.pushReplacement(context, route);
        //             } else {
        //               Route route = MaterialPageRoute(
        //                   builder: (_) => MyHomePage());
        //               Navigator.pushReplacement(context, route);
        //             }
        //           },
        //           child: const Text(
        //               "Let's Start",
        //               style: TextStyle(fontSize: 20),
        //           )
        //       ),
        //
        //
        //       ],
        // ),
        // ),
          ]
            ),
        ),
        );
  }
}
