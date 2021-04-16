import 'dart:ui';

import 'package:clima/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:intl/intl.dart';

enum menu{
  CityName,
  Settings,
}

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather,this.forecastWeather});
  final locationWeather;
  final List<WeatherModel> forecastWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> with TickerProviderStateMixin{
  WeatherModel weather=WeatherModel();
  int temperature;
  int minTemperature;
  int maxTemperature;
  var weatherIcon;
  String cityName;
  String weathermessage;
  int sunrise;
  int sunset;
  int humidity;
  double windSpeed;

   List<dynamic> forecastWidgetData;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather,widget.forecastWeather);
  }

  void updateUI(dynamic weatherData,List<dynamic> forecastData )
  {
    setState(() {
      if(weatherData == null)
        {
          temperature =0;
          weatherIcon = 'Error';
          weathermessage = ' Unable to get weather data';
          cityName = '';
        }
    var temp  = weatherData['main']['temp'];
      var minTemp = weatherData['main']['temp_min'];
      var maxTemp = weatherData['main']['temp_min'];
      minTemperature = minTemp.toInt();
      maxTemperature = maxTemp.toInt();
     temperature = temp.toInt();
     windSpeed = weatherData['wind']['speed'];
     sunrise =weatherData['sys']['sunrise'];
     sunset = weatherData['sys']['sunset'];
     humidity = weatherData['main']['humidity'];
     print(windSpeed);
      print(sunrise);
      print(sunset);
      print(humidity);


     weathermessage =weather.getMessage(temperature);
     var condition = weatherData['weather'][0]['id'];
     weatherIcon= weather.getWeatherIcon(condition);
    cityName= weatherData['name'];
    forecastWidgetData = forecastData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFFffffff),
          elevation: 0,
          title: Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color:  Color(0xFFB2B2B2),
                  fontSize: 14,
                ),
              ),

          // actions: <Widget>[
          //    PopupMenuButton(
          //       child:  Icon(Icons.more_vert,
          //       color: Color(0xFF171717),
          //       ),
          //       itemBuilder: (BuildContext context) => <PopupMenuEntry<menu>>[
          //         PopupMenuItem<menu>(
          //           value: menu.CityName,
          //             child: Text("change city"),
          //         ),
          //         PopupMenuItem<menu>(
          //           value: menu.Settings,
          //           child: Text("Settings"),
          //         ),
          //       ]
          //   ),
          //
          //
          // ],
        ),

      body: Material(
        child: Container(
          constraints: BoxConstraints.expand(),
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text(
                    cityName,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5,
                      fontSize: 25,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                Text(
                  weathermessage,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                    fontSize: 15,
                    color: Color(0xFF000000),
                  ),
                ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Text(
                    "$weatherIcon",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                      fontSize: 50,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "$temperature°",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      fontSize: 100,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ValueTile('max', null , '$maxTemperature°'),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                            child: Container(
                              width: 1,
                              height: 30,
                              color:
                             Colors.grey,
                            )),
                      ),
                      ValueTile('min', null, '${minTemperature}°'),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Container(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: this.forecastWidgetData.length,
                        separatorBuilder:  (context ,index) => Divider(
                          height: 100,
                          color:  Colors.white,
                        ),
                      padding: EdgeInsets.only(left: 10 , right: 10),
                      itemBuilder: (context , index){
                        final item = this.forecastWidgetData[index];
                        return Padding(
                            padding:  const EdgeInsets.only(left: 10 , right: 10),
                          child: Center(
                            child: ValueTile(
                              DateFormat('E,ha').format(DateTime.fromMillisecondsSinceEpoch(
                                  item.time *1000
                              )),item.weatherIcon,'${item.temperature}°')
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ValueTile('wind speed',null , '$windSpeed m/s'),
                      Padding(
                          padding: EdgeInsets.only(left:  15, right: 15),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey,
                        ),
                      ),
                      ValueTile('sunrise',null , DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(sunrise*1000))),
                      Padding(
                        padding: EdgeInsets.only(left:  15, right: 15),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey,
                        ),
                      ),
                      ValueTile('sunset',null , DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(sunset*1000))),
                      Padding(
                        padding: EdgeInsets.only(left:  15, right: 15),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey,
                        ),
                      ),
                      ValueTile('humidity',null , '$humidity%'),

                    ],
                  ),

                ],
              ),
            ),
        ),
      ),
    );
  }
}


