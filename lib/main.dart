
import 'package:findyournewhome/Splash%20Screen/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      title: "Hostle Hunt",
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home:  const splash_screen(),
      debugShowCheckedModeBanner: false,

    );
  }
}
ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xE8080809),
  secondary: Color(0xfff7f8f6),
  surface: Color(0xff070707),
  background: Color(0xfff7ece6),
  error: Color(0xfffa0c03),
  onPrimary: Color(0xffaae76a),
  onSecondary: Color(0xffe8de2d),
  onSurface: Color(0xff0e0000),
  onError: Color(0xff070000),
  onBackground: Color(0xfff7ece6),

  brightness: Brightness.light,
);

// ColorScheme defaultColorScheme = const ColorScheme(
//   primary: Color(0xE8080809),
//   secondary: Color(0xfff7f8f6),
//   surface: Color(0xff070707),
//   background: Color(0xfff7ece6),
//   error: Color(0xfffa0c03),
//   onPrimary: Color(0xffaae76a),
//   onSecondary: Color(0xffe8de2d),
//   onSurface: Color(0xff0e0000),
//   onError: Color(0xff070000),
//   onBackground: Color(0xfff7ece6),
//
//   brightness: Brightness.light,
// );

//Color(0xbec4a4f5),
//secondary: Color(0xffffffff),
//primary: Color(0xE8090808),
//onPrimary: Color(0xffaae76a),