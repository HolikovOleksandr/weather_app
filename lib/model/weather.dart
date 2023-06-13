// ignore_for_file: prefer_typing_uninitialized_variables, unused_label

class Weather {
  var sityName;
  var icon;
  var condition;
  var temp;
  var wind;
  var humidity;
  var windDir;
  var gust;
  var uv;
  var pressure;
  var precipitation;

  Weather({
    this.sityName,
    this.icon,
    this.condition,
    this.temp,
    this.wind,
    this.humidity,
    this.windDir,
    this.gust,
    this.uv,
    this.pressure,
    this.precipitation,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      sityName: json['location']['name'],
      icon: json['current']['condition']['icon'],
      condition: json['current']['condition']['text'],
      temp: json['current']['temp_c'],
      wind: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      windDir: json['current']['wind_dir'],
      gust: json['current']['gust_kph'],
      uv: json['current']['uv'],
      pressure: json['current']['pressure_mb'],
      precipitation: json['current']['precip_mm'],
    );
  }
}
