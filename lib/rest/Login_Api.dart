import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> userlogin(String email, String password) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/Hostel-hunt/loginuser'),
      headers: { 'Content-Type': 'application/json',},
      body: jsonEncode({
        "user_login": email,
        "user_pass": password
      })
  );
  if(response.statusCode == 200){
    var DecodedData= jsonDecode(response.body);
    response.statusCode;
    return{
      "res" : DecodedData,
      "success" : true,
    };
  }
 else if (response.statusCode == 403) {
    Fluttertoast.showToast(msg: 'User Is Not Verified');
    return {
      'success': false,
    };
  }
  else if (response.statusCode == 500) {
    Fluttertoast.showToast(msg: 'Connection error');
    return {
      'success': false,
      'error': 'Conection problem'
    };
  }
  else if (response.statusCode == 401) {
    Fluttertoast.showToast(msg: 'Incorrect Email or password');
    return {
      'success': false,
    };
  }
  else {
    Fluttertoast.showToast(msg: 'Error Occured');
    return {
      'success': false,
    };
  }

  //return DecodedData;
}