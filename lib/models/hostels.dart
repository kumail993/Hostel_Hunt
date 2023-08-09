import 'dart:convert';

import 'package:findyournewhome/Reservation/reservation%20_screen.dart';
import 'package:findyournewhome/contants/utils.dart';
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
        Uri.parse('${Utils.baseUrl}/Hostel-hunt/reservation'),
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
  int compareTo(hostels other) => name.compareTo(other.name);
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