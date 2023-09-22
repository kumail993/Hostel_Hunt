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
  int compareTo(Hostel other) {
    // Compare by HostelName first
    int nameComparison = HostelName.compareTo(other.HostelName);

    // If the names are the same, compare by rent
    if (nameComparison == 0) {
      String rent1 = getRent(); // Get the rent for this hostel
      String rent2 = other.getRent(); // Get the rent for the other hostel

      // Convert the rent values to integers for comparison
      int rentComparison = int.tryParse(rent1) ?? 0;
      int otherRentComparison = int.tryParse(rent2) ?? 0;

      // Compare the rent values
      return rentComparison.compareTo(otherRentComparison);
    }

    return nameComparison;
  }
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
    return 'price Not Found';
  }

  String getAgent() {
    for (final meta in postmeta) {
      final String metaKey = meta['meta_key'];
      final String metaValue = meta['meta_value'];

      if (metaKey == 'fave_agents') {
        return metaValue;
      }
    }

    // Return a default value or handle the case when the key is not found
    return 'price Not Found';
  }

  Future Reservation(int storedId, String name, String email, String phone,
      String type, String agentid, int login_id) async {
    print("1");
    final response = await http.post(
        Uri.parse('${Utils.baseUrl}/Hostel-hunt/webreservation'),
        headers: { 'Content-Type': 'application/json',},
        body: jsonEncode({
          "Hostel_id": storedId,
          "reservation_name": name,
          "reservation_email": email,
          "reservation_phone": phone,
          "type": type,
          "enquiry_to" :agentid,
          "login_id":login_id,
        })
    );
    //print(Login_id);
    var DecodedData = jsonDecode(response.body);
    print(DecodedData);
    response.statusCode;
    print(response.statusCode);
    return DecodedData;
// }
  }

}




