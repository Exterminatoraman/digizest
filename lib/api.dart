import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchWeatherData(String location) async {
  final apiKey = "1ed6f3dae7msh479ac0dfb3f8231p1ac331jsneceda6511f81";
  final host = "weatherapi-com.p.rapidapi.com";
  final queryParameters = {
    'q': '$location',
  };

  final url = Uri.https(host, '/current.json', queryParameters);

  final headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': host,
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // Parse the JSON response here
    final jsonData = json.decode(response.body);
    print(jsonData);
    return jsonData;

  } else {
    throw Exception('Failed to load weather data');
  }
}
