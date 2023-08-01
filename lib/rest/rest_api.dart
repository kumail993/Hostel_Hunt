import 'dart:convert';
import 'package:http/http.dart' as http;

import '../contants/utils.dart';
Future userlogin(String email,String password) async{
  print("1");
  // var headers = {
  //   'Content-Type': 'application/json'
  // };
  // var request = http.Request('POST', Uri.parse('http://192.168.18.141:3000/login/login'));
  // request.body = json.encode({
  //   "student_email": "kumail@gmail.com",
  //   "student_password": "54321"
  // });
  // request.headers.addAll(headers);
  //
  // http.StreamedResponse response = await request.send();
  //
  // if (response.statusCode == 200) {
  //   print(await response.stream.bytesToString());
  // }
  // else {
  //   print(response.reasonPhrase);
  // }
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