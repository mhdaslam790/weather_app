import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const apiKey =  'f525104ac1daf38fe8e75a329086f44b';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double longitude;
  double latitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData()  async
  {
    Location location= Location();
    await  location.getCurrentLocation();
    longitude=location.longitude;
    latitude=location.latitude;
    NetworkHelper networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData= await networkHelper.getData();
    
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
          locationWeather: weatherData);
    }));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitChasingDots(
            color: Colors.grey,
            size: 100.0,
          ),
        ),
    );
  }
}
