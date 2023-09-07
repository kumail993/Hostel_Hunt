import 'dart:convert';

import 'package:http/http.dart'as http;

import '../contants/utils.dart';

Future<void> resendOtp(String email) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/Hostel-hunt/resendotp'),
    headers: {  'Content-Type':'application/json',},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 201) {
    // Successfully updated OTP
    print('OTP updated successfully');
  } else {
    // Handle errors here
    print('Error updating OTP: ${response.statusCode}');
  }
}