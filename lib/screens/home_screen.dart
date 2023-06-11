// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';

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
    var formatter = DateFormat('EEEE, d MMMM yyyy');
    var currentDay = formatter.format(DateTime.now());

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: size.height * .7,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    colors: [Color(0xFF955CD1), Color(0xFF3FA2FA)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [.15, .95]),
              ),
              child: Column(
                children: [
                  const Text(
                    'Constantine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    currentDay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
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
