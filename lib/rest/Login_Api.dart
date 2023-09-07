import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
Future userlogin(String email,String password) async{
  final response= await http.post(
      Uri.parse('${Utils.baseUrl}/Hostel-hunt/login'),
      headers: {  'Content-Type':'application/json',},
      body: jsonEncode({
        "student_email":email,
        "student_password":password
      })
  );
  if (response.statusCode == 403){

    Fluttertoast.showToast(msg: 'User Is Not Verified');
  }
  if(response.statusCode == 500){
    Fluttertoast.showToast(msg: 'Connection error');
  }
  if(response.statusCode==401){
    Fluttertoast.showToast(msg: 'Incorrect Email or password');
  }
  var DecodedData= jsonDecode(response.body);
  response.statusCode;
  return DecodedData;
}