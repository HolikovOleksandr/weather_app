import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': '914b26eff8c04929a5c134248231106',
        'q': place,
      };

      final url = Uri.http(
        'api.weatherapi.com',
        '/v1/current.json',
        queryParameters,
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          'Can not get wheather information, ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
