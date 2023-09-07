import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
Future userRegister(String name,String email,String password) async{
  final response= await http.post(
      Uri.parse('${Utils.baseUrl}/Hostel-hunt/register'),
      headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "student_name":name,
        "email":email,
        "password":password
      })
  );
  var DecodedData= jsonDecode(response.body);
  response.statusCode;
  return DecodedData;
}