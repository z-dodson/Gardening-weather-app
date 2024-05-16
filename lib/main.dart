import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'settings.dart';
import 'globals.dart';

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

  void _update() {
    setState(() {
      
    });
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
              Text('Chance of Rain: ' + getStringUnitsRain(GlobalRainUnits) + "%"),
            ],
          ),
        ),
        // Daily weather carousel
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: "Temperature", icon: Icons.thermostat, temperature: "a",),
              WeatherCard(day: "Rain Chance", icon: Icons.grain, temperature: "a",),
              WeatherCard(day: "Wind speed", icon: Icons.speed, temperature: "a",),
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
              WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: 'High: 80°F, Low: 60°F'),
              WeatherCard(day: 'Tuesday', icon: Icons.cloud, temperature: 'High: 75°F, Low: 55°F'),
              WeatherCard(day: 'Wednesday', icon: Icons.wb_sunny, temperature: 'High: 82°F, Low: 62°F'),
              WeatherCard(day: 'Thursday', icon: Icons.cloud, temperature: 'High: 78°F, Low: 58°F'),
              WeatherCard(day: 'Friday', icon: Icons.wb_sunny, temperature: 'High: 79°F, Low: 61°F'),
              WeatherCard(day: 'Saturday', icon: Icons.cloud, temperature: 'High: 77°F, Low: 59°F'),
              WeatherCard(day: 'Sunday', icon: Icons.wb_sunny, temperature: 'High: 81°F, Low: 63°F'),
              // Weekly weather cards
              // Add more cards for other days
            ],
          ),
        ),Container(
          height: 150, // Adjust height as needed
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: 'High: 80°F, Low: 60°F'),
              WeatherCard(day: 'Tuesday', icon: Icons.cloud, temperature: 'High: 75°F, Low: 55°F'),
              WeatherCard(day: 'Wednesday', icon: Icons.wb_sunny, temperature: 'High: 82°F, Low: 62°F'),
              WeatherCard(day: 'Thursday', icon: Icons.cloud, temperature: 'High: 78°F, Low: 58°F'),
              WeatherCard(day: 'Friday', icon: Icons.wb_sunny, temperature: 'High: 79°F, Low: 61°F'),
              WeatherCard(day: 'Saturday', icon: Icons.cloud, temperature: 'High: 77°F, Low: 59°F'),
              WeatherCard(day: 'Sunday', icon: Icons.wb_sunny, temperature: 'High: 81°F, Low: 63°F'),
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

  WeatherCard({required this.day, required this.icon, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show bottom sheet with more info
      },
      child: Card(
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