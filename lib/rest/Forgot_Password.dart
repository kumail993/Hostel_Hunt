import 'dart:convert';
import 'package:findyournewhome/contants/utils.dart';
import 'package:http/http.dart' as http;

// Function to initiate the password reset.
Future<void> initiatePasswordReset(String email) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    // Password reset email sent successfully.
    // Display a success message to the user.
  } else {
    // Handle errors and display appropriate messages to the user.
  }
}