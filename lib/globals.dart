// All the globals in one great and lovly file

// ! Some global variables to run though the whole program

String temperatureUnits = "°C";//°F
String speedUnits = "km/h";//mph
String rainfallUnits = "mm";//inches
// NOTE: Not quite sure why we're storing in string, shouldn't we hve a converter function?? -ZD

// * Global unit settings
enum TempertureUnits { C, F }
enum WindUnits { mph, kmph, mps }
enum RainfallUnits { mm, inch }
String getStringUnitsTemp(TempertureUnits thing){
  if (thing==TempertureUnits.C){
    return "°C";
  }else if(thing==TempertureUnits.F){
    return "°F";
  } return "";
}
String getStringUnitsWind(WindUnits thing){
  if (thing==WindUnits.mph){
    return "m/h";
  }else if(thing==WindUnits.kmph){
    return "km/h";
  }else if(thing==WindUnits.mps){
    return "m/s";
  } return "";
}
String getStringUnitsRain(RainfallUnits thing){
  if (thing==RainfallUnits.mm){
    return "mm";
  }else if(thing==RainfallUnits.inch){
    return "inch";
  } return "";
}

WindUnits GlobalWindUnits = WindUnits.mph;
TempertureUnits GlobalTempretureUnits = TempertureUnits.C;
RainfallUnits GlobalRainUnits = RainfallUnits.mm;

// * Global notification settings

bool GlobalAllowNotifications = true;
bool GlobalRegularRemienders = true;
bool GlobalSeriousNotifications = true;


// NOTE: Do we actually want these as globals, shouldn't they be paramerters to update function? - ZD
double currentWindSpeed = 1;
double currentTemperature = 1;
double currentChanceOfRain = 1;