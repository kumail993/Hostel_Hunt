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
  final List<dynamic> Images;

  Hostel( {
    required this.id,
    required this.HostelName,
    required this.postType,
    required this.postmeta,
    required this.PostContent,
    required this.Images
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['ID'],
      HostelName: json['post_title'],
      postType: json['post_type'],
      //postName: json['post_name'],
      postmeta: List<Map<String, dynamic>>.from(json['postmeta']),

      PostContent: json['post_content'],
        Images: json['imageGuids'],
    );

  }
  int compareTo(Hostel other) => HostelName.compareTo(other.HostelName,);
  String getAddress() {
    for (final meta in postmeta) {
      final String metaKey = meta['meta_key'];
      final String metaValue = meta['meta_value'];

      if (metaKey == 'fave_property_map_address') {
        return metaValue;
      }
    }

    // Return a default value or handle the case when the key is not found
    return 'Address Not Found';
  }

  String getRooms() {
    for (final meta in postmeta) {
      final String metaKey = meta['meta_key'];
      final String metaValue = meta['meta_value'];

      if (metaKey == 'fave_property_bedrooms') {
        return metaValue;
      }
    }

    // Return a default value or handle the case when the key is not found
    return 'Rooms Not Found';
  }

  String getBathroom() {
    for (final meta in postmeta) {
      final String metaKey = meta['meta_key'];
      final String metaValue = meta['meta_value'];

      if (metaKey == 'fave_property_bathrooms') {
        return metaValue;
      }
    }

    // Return a default value or handle the case when the key is not found
    return 'Bathroom Not Found';
  }

  String getRent() {
    for (final meta in postmeta) {
      final String metaKey = meta['meta_key'];
      final String metaValue = meta['meta_value'];

      if (metaKey == 'fave_property_price') {
        return metaValue;
      }
    }

    // Return a default value or handle the case when the key is not found
    return 'Address Not Found';
  }

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

