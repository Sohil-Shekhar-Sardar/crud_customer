import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://lab.pixel6.co/api/';

  Future<Map<String, dynamic>> verifyPan(String panNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-pan.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'panNumber': panNumber}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify PAN');
    }
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/get-postcode-details.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'postcode': postcode}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get postcode details');
    }
  }
}
