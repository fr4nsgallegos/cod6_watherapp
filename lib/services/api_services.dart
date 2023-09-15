import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/city.dart';

class ApiServices {
  Future<City?> getWeatherData(String cityName) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$cityName&aqi=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      City city = City.fromJson(data);
      return city;
      // print(data);
    }
    return null;
  }

  Future<City?> getWeatherLocation(double latitude, double longitude) async {
    Uri url = Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$latitude,$longitude&aqi=no");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      City city = City.fromJson(data);
      return city;
    }
    return null;
  }
}
