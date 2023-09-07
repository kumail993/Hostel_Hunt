import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
class hostels {
  final int id;
  final String name;
  final String photo;
  final String address;
  List<Map<String, dynamic>> roomTypeData = [];
  hostels({
    required this.id,
    required this.name,
    required this.photo,
    required this.address,
  }

  );
  Future Reservation(int storedId, String name, String email, String phone,
      String type, int Login_id) async {
    print("1");
    final response = await http.post(
        Uri.parse('${Utils.baseUrl}/Hostel-hunt/reservation'),
        headers: { 'Content-Type': 'application/json',},
        body: jsonEncode({
          "Hostel_id": storedId,
          "reservation_name": name,
          "reservation_email": email,
          "reservation_phone": phone,
          "type": type,
          "login_id" :Login_id,
        })
    );
    print(Login_id);
    var DecodedData = jsonDecode(response.body);
    print(DecodedData);
    response.statusCode;
    print(response.statusCode);
    return DecodedData;
// }
  }

  int compareTo(hostels other) => name.compareTo(other.name,);
}

