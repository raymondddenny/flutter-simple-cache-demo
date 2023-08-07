import 'dart:convert';
import 'dart:io'; // Import dart:io to access SocketException

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiServices {
  final Client client;
  ApiServices(this.client);
  final String url = "https://rickandmortyapi.com/api";

  Future<T> getMethod<T>({
    String queryParams = '',
    required T Function(Map<String, dynamic>) parser,
  }) async {
    final dynamicUrl = url + queryParams;
    var response = await client.get(Uri.parse(dynamicUrl));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      if (T == List) {
        return decodedJson as T; // If T is a List, return the decoded JSON list directly
      } else {
        // T is not a List, expect a single object (map)
        if (decodedJson is Map<String, dynamic>) {
          // Use the provided parser function to convert the JSON map to the desired type
          return parser(decodedJson);
        } else {
          throw Exception("Failed to fetch data: Invalid JSON format.");
        }
      }
    } else {
      debugPrint("Error: ${response.statusCode}");
      throw Exception("Failed to fetch data");
    }
  }

  Future<T> postMethod<T>({String endPoint = '', dynamic body}) async {
    try {
      final dynamicUrl = url + endPoint;
      var response = await client.post(
        Uri.parse(dynamicUrl),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as T;
        return data;
      } else {
        debugPrint("Error: ${response.statusCode}");
        throw Exception("Failed to post data");
      }
    } on SocketException {
      debugPrint("Error: No internet connection");
      throw Exception("No internet connection");
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Failed to post data");
    }
  }

  Future<T> putMethod<T>({String endPoint = '', dynamic body}) async {
    try {
      final dynamicUrl = url + endPoint;
      var response = await client.put(
        Uri.parse(dynamicUrl),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as T;
        return data;
      } else {
        debugPrint("Error: ${response.statusCode}");
        throw Exception("Failed to put data");
      }
    } on SocketException {
      debugPrint("Error: No internet connection");
      throw Exception("No internet connection");
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Failed to put data");
    }
  }

  Future<T> deleteMethod<T>({String endPoint = ''}) async {
    try {
      final dynamicUrl = url + endPoint;
      var response = await client.delete(
        Uri.parse(dynamicUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as T;
        return data;
      } else {
        debugPrint("Error: ${response.statusCode}");
        throw Exception("Failed to delete data");
      }
    } on SocketException {
      debugPrint("Error: No internet connection");
      throw Exception("No internet connection");
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Failed to delete data");
    }
  }
}
