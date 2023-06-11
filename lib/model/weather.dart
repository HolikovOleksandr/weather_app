class Weather {
  final double temperatureC;
  final double temperatureF;
  final double windKPH;
  final String condition;

  const Weather({
    this.windKPH = 0,
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.condition = 'Sunny',
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperatureC: json['current']['temp_c'],
      windKPH: json['current']['wind_kph'],
      temperatureF: json['current']['temp_f'],
      condition: json['current']['condition']['text'],
    );
  }
}
