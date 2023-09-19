import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
Future userRegister(String name,String username,String email,String password, ) async{
  final response= await http.post(
      Uri.parse('${Utils.baseUrl}/Hostel-hunt/registeruser'),
      headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "user_nicename":name,
        "user_login":username,
        "user_email":email,
        "user_pass":password
      })
  );
  var DecodedData= jsonDecode(response.body);
  response.statusCode;
  return DecodedData;
}