import 'dart:convert';

import 'package:findyournewhome/reservation%20_screen.dart';
import 'package:http/http.dart' as http;
class hostels {
  final int id;
  final String name;
  final String photo;
  final String address;
  hostels({
    required this.id,
    required this.name,
    required this.photo,
    required this.address,
  }

  );
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
  //int compareTo(hostels other) => rent.compareTo(other.rent);
}
// class popular extends hostels{
//   popular({required super.address,required super.name,required super.photo,required super.rating,required super.type,required super.rent});
//
// }
// class Recommended extends hostels{
//   Recommended({required super.address,required super.name,required super.photo,required super.rating,required super.type,required super.rent});
// }
// class Nearest extends hostels{
//   Nearest({required super.name, required super.rating, required super.photo, required super.type, required super.address,required super.rent});
//
// }
// class Paid extends hostels{
//   Paid({required super.name, required super.rating, required super.photo, required super.type, required super.address,required super.rent});
// }
// class All extends hostels{
//   All({required super.name, required super.rating, required super.photo, required super.type, required super.address, required super.rent});
//
// }