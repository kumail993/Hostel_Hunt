//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../contants/utils.dart';
// import 'package:http/http.dart' as http;
//
//
// Future<void> fetchRoomTypes(int hostelId) async {
//   final response = await http.get(Uri.parse('${Utils.baseUrl}/Hostel-hunt/roomtype/$hostelId'));
//
//   if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body) as List<dynamic>;
//     roomTypeData = List<Map<String, dynamic>>.from(jsonData);
//     setState(() {});
//   } else {
//     throw Exception('Failed to load room types');
//   }
// }