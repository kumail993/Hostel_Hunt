import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
Future userlogin(String email,String password) async{
  print("1");
  final response= await http.post(
      Uri.parse('${Utils.baseUrl}/Hostel-hunt/login'),
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