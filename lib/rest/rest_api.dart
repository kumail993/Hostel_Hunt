import 'dart:convert';
import 'package:http/http.dart' as http;

import '../contants/utils.dart';
import '../models/cars.dart';
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

//----------------------Registration----------------------------------------//

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
//--------------OTP Verification---------------------------///////////////

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


//---------------get data fro dataabse-----------------------------------//

Future<List<hostels>> fetchPremiumHostel() async {
  final response = await http.get(
      Uri.parse('http://192.168.18.141:3000/login/premiumhostels'));
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    return responseData.map((json) =>
        hostels(
            id: json['hostel_id'],
            name: json['hostel_name'],
            address: json['hostel_address'],
            photo: json['hostel_image'])).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<List<hostels>> fetchRatedHostel() async {
  final response = await http.get(
      Uri.parse('http://192.168.18.141:3000/login/ratedhostels'));
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    return responseData.map((json) =>
        hostels(
            id: json['hostel_id'],
            name: json['hostel_name'],
            address: json['hostel_address'],
            photo: json['hostel_image'])).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}

//----------------Reservation------------------------//

  Future Reservation(int storedId, String name, String email, String phone,
      String type) async {
    print("1");
    final response = await http.post(
        Uri.parse('http://192.168.18.141:3000/login/reservation'),
        headers: { 'Content-Type': 'application/json',},
        body: jsonEncode({
          "Hostel_id": storedId,
          "reservation_name": name,
          "reservation_email": email,
          "reservation_phone": phone,
          "type": type
        })
    );
    var DecodedData = jsonDecode(response.body);
    print(DecodedData);
    response.statusCode;
    print(response.statusCode);
    return DecodedData;
// }
  }