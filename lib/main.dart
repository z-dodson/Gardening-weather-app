import 'package:flutter/material.dart';
import 'dart:async';
import 'settings.dart';
import 'globals.dart';
import 'api_service.dart';

void main() {
  runApp(MyWeatherApp());
  // We want a every update call to the API

}
void update(){

}

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherHomePage(),
      routes: {
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

String temperatureUnits = "°C";//°F
String speedUnits = "km/h";//mph
String rainfallUnits = "mm";//inches

double currentWindSpeed = 1;
double currentTemperature = 1;
double currentChanceOfRain = 1;

double getTemperatureInCorrectUnits(double val){
  if (temperatureUnits == "°C") return val;
  else if (temperatureUnits == "°F") return (val * 9 / 5) + 32;
  return -1;
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
    setState(() {});
  }

  void _update() {
    setState(() {
      
    });
  }

  Future<void> _fetchWeatherData() async {
    try {
      WeatherData weatherData = await apiService.fetchWeatherData();
      setState(() {
        // Update your global variables with the fetched data
        currentTemperature = weatherData.current.temperature2m;
        currentWindSpeed = weatherData.current.windSpeed10m;
        currentChanceOfRain = weatherData.current.precipitation; // Example usage
      });
    } catch (e) {
      print('Failed to fetch weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Object a = Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  
    return Scaffold(
      appBar: AppBar(
        title: Text('FloraForcast'),
        backgroundColor: Color.fromARGB(255, 172, 223, 135),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: _WeatherBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWeatherData,
        child: Icon(Icons.refresh)),
    );
  }
}

class _WeatherBody extends StatefulWidget {
  @override
  __WeatherBodyState createState() => __WeatherBodyState();
}

class __WeatherBodyState extends State<_WeatherBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top section with wind speed, temperature, chance of rainfall
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wind: ' + currentWindSpeed.toString() + " " + getStringUnitsWind(GlobalWindUnits)),
              Text('Temperature: ' + getTemperatureInCorrectUnits(currentTemperature).toString() + getStringUnitsTemp(GlobalTempretureUnits)),
              Text('Rainfall: ' + currentChanceOfRain.toString() + getStringUnitsRain(GlobalRainUnits)),
            ],
          ),
        ),
        // Daily weather carousel
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: "Temperature", icon: Icons.thermostat, temperature: "a", color: THEcolor,),
              WeatherCard(day: "Rain Chance", icon: Icons.grain, temperature: "a", color: THEcolor,),
              WeatherCard(day: "Wind speed", icon: Icons.speed, temperature: "a", color: THEcolor,),
              // Daily weather cards
              // Example: WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: '80°F'),
              // Add more cards for other days
            ],
          ),
        ),
        // Weekly weather carousel
        Container(
          height: 150, // Adjust height as needed
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: 'High: 80°F, Low: 60°F', color: THEcolor,),
              WeatherCard(day: 'Tuesday', icon: Icons.cloud, temperature: 'High: 75°F, Low: 55°F', color: THEcolor,),
              WeatherCard(day: 'Wednesday', icon: Icons.wb_sunny, temperature: 'High: 82°F, Low: 62°F', color: THEcolor,),
              WeatherCard(day: 'Thursday', icon: Icons.cloud, temperature: 'High: 78°F, Low: 58°F', color: THEcolor,),
              WeatherCard(day: 'Friday', icon: Icons.wb_sunny, temperature: 'High: 79°F, Low: 61°F', color: THEcolor,),
              WeatherCard(day: 'Saturday', icon: Icons.cloud, temperature: 'High: 77°F, Low: 59°F', color: THEcolor,),
              WeatherCard(day: 'Sunday', icon: Icons.wb_sunny, temperature: 'High: 81°F, Low: 63°F', color: THEcolor,),
              // Weekly weather cards
              // Add more cards for other days
            ],
          ),
        ),Container(
          height: 150, // Adjust height as needed
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: 'High: 80°F, Low: 60°F', color: THEcolor,),
              WeatherCard(day: 'Tuesday', icon: Icons.cloud, temperature: 'High: 75°F, Low: 55°F', color: THEcolor,),
              WeatherCard(day: 'Wednesday', icon: Icons.wb_sunny, temperature: 'High: 82°F, Low: 62°F', color: THEcolor,),
              WeatherCard(day: 'Thursday', icon: Icons.cloud, temperature: 'High: 78°F, Low: 58°F', color: THEcolor,),
              WeatherCard(day: 'Friday', icon: Icons.wb_sunny, temperature: 'High: 79°F, Low: 61°F', color: THEcolor,),
              WeatherCard(day: 'Saturday', icon: Icons.cloud, temperature: 'High: 77°F, Low: 59°F', color: THEcolor,),
              WeatherCard(day: 'Sunday', icon: Icons.wb_sunny, temperature: 'High: 81°F, Low: 63°F', color: THEcolor,),
              // Weekly weather cards
              // Add more cards for other days
            ],
          ),
        ),
      ],
    );
  }
}



// Widget for individual weather cards
class WeatherCard extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temperature;
  final Color color;

  WeatherCard({required this.day, required this.icon, required this.temperature, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show bottom sheet with more info
      },
      child: Card(
        color: color,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(day),
              Icon(icon),
              Text(temperature),
            ],
          ),
        ),
      ),
    );
  }
}
