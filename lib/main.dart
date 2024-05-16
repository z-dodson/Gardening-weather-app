import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
// ! Some global variables to run though the whole program

String temperatureUnits = "°C";//°F
String speedUnits = "km/h";//mph
String rainfallUnits = "mm";//inches
// NOTE: Not quite sure why we're storing in string, shouldn't we hve a converter function?? -ZD

// * Global unit settings

WindUnits GlobalWindUnits = WindUnits.mph;
TempertureUnits GlobalTempretureUnits = TempertureUnits.C;
OtherUnits GlobalOtherUnits = OtherUnits.C;

// * Global notification settings

bool GlobalAllowNotifications = true;
bool GlobalRegularRemienders = true;
bool GlobalSeriousNotifications = true;


// NOTE: Do we actually want these as globals, shouldn't they be paramerters to update function? - ZD
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
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Unit settings'),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Tempreture'), SegmentedButtonTempreture()]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('WindSpeed'), SegmentedButtonWind()]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Tempreture'), SegmentedButtonExample()])
              
            ],
            ),
              // Add more settings options here
          Text("Notification settings"),
          Column(
            children: [
              SwitchListTile(
                title: Text('Allow Notifications'),
                value: GlobalAllowNotifications,
                onChanged: (value) {
                  setState(() {
                    GlobalAllowNotifications = value;
                  });
                  // You can perform additional actions based on the toggle state
                },
              ),
              SwitchListTile(
                title: Text('Regular reminders'),
                value: GlobalRegularRemienders,
                onChanged: (value) {
                  setState(() {
                    GlobalRegularRemienders = value;

                  });
                  // You can perform additional actions based on the toggle state
                },
              ),
              SwitchListTile(
                title: Text('Serious warnings'),
                value: GlobalSeriousNotifications,
                onChanged: (value) {
                  setState(() {
                    GlobalSeriousNotifications = value;
                  });
                  // You can perform additional actions based on the toggle state
                },
              ),
              // Add more settings options here
            ],
          ),
          ],
        ),
      ),
    );
  }
}


class SegmentedButtonTempreture extends StatefulWidget {
  const SegmentedButtonTempreture({super.key});

  @override
  State<SegmentedButtonTempreture> createState() => _SegmentedButtonTempretureState();
}


enum TempertureUnits { C, F }

class _SegmentedButtonTempretureState extends State<SegmentedButtonTempreture> {
  TempertureUnits tempView = TempertureUnits.C;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TempertureUnits>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
      segments: const <ButtonSegment<TempertureUnits>>[
        ButtonSegment<TempertureUnits>(
            value: TempertureUnits.C,
            label: Text('C'),
        ),
        ButtonSegment<TempertureUnits>(
            value: TempertureUnits.F,
            label: Text('F'),
        ),
      ],
      selected: <TempertureUnits>{tempView},
      onSelectionChanged: (Set<TempertureUnits> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          tempView = newSelection.first;
          GlobalTempretureUnits = tempView;
        });
      },
    );
  }
}

class SegmentedButtonWind extends StatefulWidget {
  const SegmentedButtonWind({super.key});

  @override
  State<SegmentedButtonWind> createState() => _SegmentedButtonWindState();
}


enum WindUnits { mph, kmph, mps }

class _SegmentedButtonWindState extends State<SegmentedButtonWind> {
  WindUnits tempView = WindUnits.mph;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<WindUnits>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
      segments: const <ButtonSegment<WindUnits>>[
        ButtonSegment<WindUnits>(
            value: WindUnits.mph,
            label: Text('miles/hr'),
        ),
        ButtonSegment<WindUnits>(
            value: WindUnits.kmph,
            label: Text('km/hr'),
        ),
        ButtonSegment<WindUnits>(
            value: WindUnits.mps,
            label: Text('m/s'),
        ),
      ],
      selected: <WindUnits>{tempView},
      onSelectionChanged: (Set<WindUnits> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          tempView = newSelection.first;
          GlobalWindUnits = tempView;
        });
      },
    );
  }
}

class SegmentedButtonExample extends StatefulWidget {
  const SegmentedButtonExample({super.key});

  @override
  State<SegmentedButtonExample> createState() => _SegmentedButtonExampleState();
}


enum OtherUnits { C, F }

class _SegmentedButtonExampleState extends State<SegmentedButtonExample> {
  OtherUnits tempView = OtherUnits.C;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<OtherUnits>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
      segments: const <ButtonSegment<OtherUnits>>[
        ButtonSegment<OtherUnits>(
            value: OtherUnits.C,
            label: Text('C'),
        ),
        ButtonSegment<OtherUnits>(
            value: OtherUnits.F,
            label: Text('F'),
        ),
      ],
      selected: <OtherUnits>{tempView},
      onSelectionChanged: (Set<OtherUnits> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          tempView = newSelection.first;
          GlobalOtherUnits = tempView;
        });
      },
    );
  }
}
