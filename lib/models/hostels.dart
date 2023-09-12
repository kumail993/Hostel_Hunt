import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
class Hostel {
  final int id;
  final String HostelName;
  final String postType;
  //final String postName;
  final List<Map<String, dynamic>> postmeta;
  final String PostContent;

  Hostel({
    required this.id,
    required this.HostelName,
    required this.postType,
    required this.postmeta,
    required this.PostContent
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['ID'],
      HostelName: json['post_title'],
      postType: json['post_type'],
      //postName: json['post_name'],
      postmeta: List<Map<String, dynamic>>.from(json['postmeta']),
      PostContent: json['post_content'],
    );
  }
  int compareTo(Hostel other) => HostelName.compareTo(other.HostelName,);
}

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

