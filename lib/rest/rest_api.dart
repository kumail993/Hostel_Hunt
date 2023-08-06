import 'dart:convert';
import 'package:http/http.dart' as http;

import '../contants/utils.dart';
Future userlogin(String email,String password) async{
  print("1");
  final response= await http.post(
  Uri.parse('http://192.168.18.141:3000/login/login'),
  headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "student_email":email,
        "student_password":password
      })
  );
  var DecodedData= jsonDecode(response.body);
  print(DecodedData);
  response.statusCode;
  print(response.statusCode);
  return DecodedData;
}


Future userRegister(String name,String email,String password) async{
  print("1");
  final response= await http.post(
      Uri.parse('http://192.168.18.141:3000/login/register'),
      headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "student_name":name,
        "email":email,
        "password":password
      })
  );
  var DecodedData= jsonDecode(response.body);
  print(DecodedData);
  response.statusCode;
  print(response.statusCode);
  return DecodedData;
}


Future OTP(String otp) async{
  print("1");
  final response= await http.post(
      Uri.parse('http://192.168.18.141:3000/login/register'),
      headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "otp":otp,
      })
  );
  var DecodedData= jsonDecode(response.body);
  print(DecodedData);
  response.statusCode;
  print(response.statusCode);
  return DecodedData;
}
