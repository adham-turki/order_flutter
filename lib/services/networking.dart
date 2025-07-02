import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkingHelper {
  final String url;
  NetworkingHelper(this.url);

  Future<dynamic> postData(Map<String, dynamic> body) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse is List) {
      return decodedResponse;
    } else if (decodedResponse is Map) {
      return decodedResponse as Map<String, dynamic>;
    } else {
      throw Exception('Unexpected response formats');
    }
  }

  Future<Map<String, dynamic>?> updateData(Map<String, dynamic> body) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 404 ||
        response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> getData() async {
    try {
      Uri uri = Uri.parse(url);
      http.Response response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // String id
// Function to send the DELETE request to the API
  Future<bool> deleteData(Map<String, dynamic> body) async {
    Uri uri = Uri.parse(url);

    try {
      // Send the DELETE request with the body
      http.Response response = await http.delete(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
