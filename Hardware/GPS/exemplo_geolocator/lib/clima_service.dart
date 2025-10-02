import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ClimaService {
  String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  String apiKey = "0952d15c4441841396e6bf493f067e51";

  Future<Map<String, dynamic>> getCityWeatherByPosition(Position position) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?lat=${position.latitude}&lon=${position.longitude}appid=$apiKey"));
    
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else{
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  } 
}