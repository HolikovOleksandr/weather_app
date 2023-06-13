import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<Weather> getWeatherData(var lat, var long) async {
    try {
      final queryParameters = {
        'key': '19d4c2b28b4143ec816191550231106',
        'q': '$lat,$long',
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
