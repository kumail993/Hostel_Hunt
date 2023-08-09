import 'dart:convert';
import 'package:http/http.dart' as http;



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




//----------------Reservation------------------------//

//   Future Reservation(int storedId, String name, String email, String phone,
//       String type) async {
//     print("1");
//     final response = await http.post(
//         Uri.parse('http://192.168.130.237:3000/login/reservation'),
//         headers: { 'Content-Type': 'application/json',},
//         body: jsonEncode({
//           "Hostel_id": storedId,
//           "reservation_name": name,
//           "reservation_email": email,
//           "reservation_phone": phone,
//           "type": type
//         })
//     );
//     var DecodedData = jsonDecode(response.body);
//     print(DecodedData);
//     response.statusCode;
//     print(response.statusCode);
//     return DecodedData;
// // }
//   }