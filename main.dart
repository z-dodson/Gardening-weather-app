import 'package:flutter/material.dart';

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

class WeatherHomePage extends StatelessWidget {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section with wind speed, temperature, chance of rainfall
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wind: 10 mph'),
                Text('Temperature: 75°F'),
                Text('Chance of Rain: 30%'),
              ],
            ),
          ),
          // Daily weather carousel
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                WeatherCard(day: "a", icon: const IconData(0),temperature: "a",),
                WeatherCard(day: "a", icon: const IconData(0),temperature: "a",),
                WeatherCard(day: "a", icon: const IconData(0),temperature: "a",),
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
      ),
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

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool useMetric = true; // Default to metric units

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Use Metric Units'),
            value: useMetric,
            onChanged: (value) {
              setState(() {
                useMetric = value;
              });
              // You can perform additional actions based on the toggle state
            },
          ),
          SwitchListTile(
            title: Text('Notifications'),
            value: useMetric,
            onChanged: (value) {
              setState(() {
                useMetric = value;
              });
              // You can perform additional actions based on the toggle state
            },
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}