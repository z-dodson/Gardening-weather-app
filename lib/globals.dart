// All the globals in one great and lovly file

// ! Some global variables to run though the whole program

String temperatureUnits = "°C";//°F
String speedUnits = "km/h";//mph
String rainfallUnits = "mm";//inches
// NOTE: Not quite sure why we're storing in string, shouldn't we hve a converter function?? -ZD

// * Global unit settings
enum TempertureUnits { C, F }
enum WindUnits { mph, kmph, mps }
enum OtherUnits { C, F }

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