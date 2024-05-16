import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart';

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
                children: [Text('Rainfall'), SegmentedButtonRainfall()])
              
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

class SegmentedButtonRainfall extends StatefulWidget {
  const SegmentedButtonRainfall({super.key});

  @override
  State<SegmentedButtonRainfall> createState() => _SegmentedButtonRainfallState();
}



class _SegmentedButtonRainfallState extends State<SegmentedButtonRainfall> {
  Rainfall tempView = Rainfall.mm;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Rainfall>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
      segments: const <ButtonSegment<Rainfall>>[
        ButtonSegment<Rainfall>(
            value: Rainfall.mm,
            label: Text('mm'),
        ),
        ButtonSegment<Rainfall>(
            value: Rainfall.inch,
            label: Text('inch'),
        ),
      ],
      selected: <Rainfall>{tempView},
      onSelectionChanged: (Set<Rainfall> newSelection) {
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
