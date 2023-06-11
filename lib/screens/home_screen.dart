// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var weatherService = WeatherService();
  var weather = const Weather();

  String currentWeather = '';
  double tempC = 0;
  double tempF = 0;

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    weather = await weatherService.getWeatherData("Ukraine");
    setState(() {
      currentWeather = weather.condition;
      tempC = weather.temperatureC;
      tempF = weather.temperatureF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wheather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentWeather,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '${tempC.toString()} C',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '${tempF.toString()} F',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
