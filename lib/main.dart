
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
      home:  splash_screen(),
      debugShowCheckedModeBanner: false,

    );
  }
}
ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xff0fc1fa),
  secondary: Color(0xffffffff),
  surface: Color(0xff030000),
  background: Color(0xfff7ece6),
  error: Color(0xff0022a8),
  onPrimary: Color(0xfff7ece6),
  onSecondary: Color(0xfffff36c),
  onSurface: Color(0xff0e0000),
  onError: Color(0xff070000),
  onBackground: Color(0xfff7ece6),

  brightness: Brightness.light,
);

