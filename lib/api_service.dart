import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class ApiService {
  final String baseUrl = 'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,precipitation,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,snowfall,cloud_cover,wind_speed_10m,soil_moisture_1_to_3cm&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max';

  String constructUrl() {
    return 'https://api.open-meteo.com/v1/forecast'
        '?latitude=52.52'
        '&longitude=13.41'
        '&current=temperature_2m,precipitation,wind_speed_10m'
        '&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,snowfall,cloud_cover,wind_speed_10m,soil_moisture_1_to_3cm'
        '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max'
        '&temperature_unit=${globals.getTemperatureUnit()}'
        '&wind_speed_unit=${globals.getWindUnit()}'
        '&precipitation_unit=${globals.getRainUnit()}';
  }

  Future<WeatherData> fetchWeatherData() async {
    final response = await http.get(Uri.parse(constructUrl()));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      WeatherData weatherData = WeatherData.fromJson(body);
      globals.currentTemperature = weatherData.current.temperature2m;
      globals.currentRain = weatherData.current.precipitation;
      globals.currentWindSpeed = weatherData.current.windSpeed10m;
      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

class WeatherData {
  final double latitude;
  final double longitude;
  final CurrentData current;
  final HourlyData hourly;
  final DailyData daily;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      current: CurrentData.fromJson(json['current']),
      hourly: HourlyData.fromJson(json['hourly']),
      daily: DailyData.fromJson(json['daily']),
    );
  }
}

class CurrentData {
  final double temperature2m;
  final double precipitation;
  final double windSpeed10m;

  CurrentData({
    required this.temperature2m,
    required this.precipitation,
    required this.windSpeed10m,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      temperature2m: json['temperature_2m'],
      precipitation: json['precipitation'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class HourlyData {
  final List<double> temperature2m;
  final List<double> relativeHumidity2m;
  final List<double> precipitationProbability;
  final List<double> precipitation;
  final List<double> snowfall;
  final List<double> cloudCover;
  final List<double> windSpeed10m;
  final List<double> soilMoisture1To3cm;

  HourlyData({
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitationProbability,
    required this.precipitation,
    required this.snowfall,
    required this.cloudCover,
    required this.windSpeed10m,
    required this.soilMoisture1To3cm,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      temperature2m: List<double>.from(json['temperature_2m']),
      relativeHumidity2m: List<double>.from(json['relative_humidity_2m']),
      precipitationProbability: List<double>.from(json['precipitation_probability']),
      precipitation: List<double>.from(json['precipitation']),
      snowfall: List<double>.from(json['snowfall']),
      cloudCover: List<double>.from(json['cloud_cover']),
      windSpeed10m: List<double>.from(json['wind_speed_10m']),
      soilMoisture1To3cm: List<double>.from(json['soil_moisture_1_to_3cm']),
    );
  }
}

class DailyData {
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<double> precipitationProbabilityMax;

  DailyData({
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.precipitationProbabilityMax,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      temperature2mMax: List<double>.from(json['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['temperature_2m_min']),
      precipitationProbabilityMax: List<double>.from(json['precipitation_probability_max']),
    );
  }
}