import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/get_location.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var weatherService = WeatherService();
  Weather? weather = Weather();

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    var location = await getPosition();

    weather = await weatherService.getWeatherData(
        location.latitude, location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var currentDay = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: size.height * .75,
                  width: size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFF38A2D6), Color(0xFF551138)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      stops: [.15, .95],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${weather?.sityName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentDay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Image.network(
                        'https:${weather?.icon}',
                        width: size.width * .50,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        '${weather?.condition}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${weather?.temp} °C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _weatherData(
                            size: size,
                            data: '${weather?.wind}',
                            icon: Icons.wind_power_outlined,
                            type: 'Wind (km/h)',
                            iconColor: Colors.green,
                          ),
                          _weatherData(
                            size: size,
                            data: '${weather?.windDir}',
                            icon: Icons.compare_arrows,
                            type: 'Direction',
                            iconColor: Colors.pink,
                          ),
                          _weatherData(
                            size: size,
                            data: '${weather?.humidity}',
                            icon: Icons.water_drop,
                            type: 'Humidity',
                            iconColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _moreDetailData(
                              type: 'Gust (kp/h)',
                              data: '${weather?.gust}',
                            ),
                            _moreDetailData(
                              type: 'Pressure (hpa)',
                              data: '${weather?.pressure}',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _moreDetailData(
                              type: 'UV',
                              data: '${weather?.uv}',
                            ),
                            _moreDetailData(
                              type: 'Precipitation(mm)',
                              data: '${weather?.precipitation}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _moreDetailData({
    required String type,
    required String data,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            type,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.7),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherData({
    required Size size,
    required IconData? icon,
    required String data,
    required String type,
    required Color iconColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: size.width * .1,
            color: iconColor,
          ),
          const SizedBox(height: 5),
          Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            type,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
