import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;
import '../models/hostels.dart';



Future<List<Hostel>> fetchPostData() async {
  final response = await http.get(Uri.parse('${Utils.baseUrl}/Hostel-hunt/hostelsfromweb'));
  //print(response.body);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Hostel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
// Future<List<hostels>> fetchPremiumHostel() async {
//   final response = await http.get(
//       Uri.parse('${Utils.baseUrl}/Hostel-hunt/premiumhostels'));
//   print('Response Status Code: ${response.statusCode}');
//   if (response.statusCode == 200) {
//     final List<dynamic> responseData = json.decode(response.body);
//     return responseData.map((json) =>
//         hostels(
//             id: json['hostel_id'],
//             name: json['hostel_name'],
//             address: json['hostel_address'],
//             photo: json['hostel_image'])).toList();
//   } else {
//     throw Exception('Failed to fetch data');
//   }
// }
//
// Future<List<hostels>> fetchRatedHostel() async {
//   final response = await http.get(
//       Uri.parse('${Utils.baseUrl}/Hostel-hunt/ratedhostels'));
//   print('Response Status Code: ${response.statusCode}');
//   if (response.statusCode == 200) {
//     final List<dynamic> responseData = json.decode(response.body);
//     return responseData.map((json) =>
//         hostels(
//             id: json['hostel_id'],
//             name: json['hostel_name'],
//             address: json['hostel_address'],
//             photo: json['hostel_image'])).toList();
//   } else {
//     throw Exception('Failed to fetch data');
//   }
// }
//
// Future<List<hostels>> fetchAllHostel() async {
//   final response = await http.get(
//       Uri.parse('${Utils.baseUrl}/Hostel-hunt/Allhostels'));
//   print('Response Status Code: ${response.statusCode}');
//   if (response.statusCode == 200) {
//     final List<dynamic> responseData = json.decode(response.body);
//     return responseData.map((json) =>
//         hostels(
//             id: json['hostel_id'],
//             name: json['hostel_name'],
//             address: json['hostel_address'],
//             photo: json['hostel_image'])).toList();
//   } else {
//     throw Exception('Failed to fetch data');
//   }
//  }