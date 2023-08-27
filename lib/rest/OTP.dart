
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../UserAuthentication/Screens/Login_page.dart';
import '../contants/utils.dart';

class ConnectivityHelper {
  static Future<void> verifyOTP(String userEmail, String otp,context) async {
    final url = Uri.parse('${Utils.baseUrl}/Hostel-Hunt/otpverification'); // Replace with your actual URL

    final response = await http.post(
      url,
      body: {
        'email': userEmail,
        'otp': otp,
      },
    );

    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg: "Email Verified Successfully");
      Route route= MaterialPageRoute(builder: (_)=> LoginPage());
      Navigator.pushReplacement(context, route);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
      // Perform any actions you need after successful verification
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Invalid OTP");
      print('Invalid OTP');
      // Handle invalid OTP case
    } else {
      Fluttertoast.showToast(msg: "Error verifying OTP");
      print('Error verifying OTP');
      // Handle other error cases
    }
  }
}



// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../contants/utils.dart';
//
//
//
// Future OTP(String otp, String email) async{
//   print("1");
//   final response= await http.post(
//       Uri.parse('${Utils.baseUrl}/Hostel-hunt/otpverification'),
//       headers: {  'Content-Type':'application/json',},
//       body: jsonEncode({
//         "otp":otp,
//         "email":email
//       })
//   );
//   var DecodedData= jsonDecode(response.body);
//   print(DecodedData);
//   response.statusCode;
//   print(response.statusCode);
//   return DecodedData;
// }
