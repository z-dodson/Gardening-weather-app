import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';
import 'globals.dart'
void main() {
  runApp(MyWeatherApp());
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
  @override
  Widget build(BuildContext context) {
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
              Text('Wind: ' + currentWindSpeed.toString() + " " + speedUnits),
              Text('Temperature: ' + getTemperatureInCorrectUnits(currentTemperature).toString() + temperatureUnits),
              Text('Chance of Rain: ' + (currentChanceOfRain * 100).toString() + "%"),
            ],
          ),
        ),
        // Daily weather carousel
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              WeatherCard(day: "Temperature", icon: const IconData(0),temperature: "a",),
              WeatherCard(day: "Rain Chance", icon: const IconData(0),temperature: "a",),
              WeatherCard(day: "Wind speed", icon: const IconData(0),temperature: "a",),
              // Daily weather cards
              // Example: WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: '80°F'),
              // Add more cards for other days
            ],
          ),
        ),
        // Weekly weather carousel
        Container(
          height: 1,
          width: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Weekly weather cards
              // Example: WeatherCard(day: 'Monday', icon: Icons.wb_sunny, temperature: 'High: 80°F, Low: 60°F'),
              // Add more cards for other days
            ],
          ),
        ),
      ],
    );
  }
}

