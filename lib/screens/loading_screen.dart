import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart'as http;

const apiKey =  "f525104ac1daf38fe8e75a329086f44b";

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
    getLocation();

  }
  void getLocation()  async
  {
    Location location= Location();
    await  location.getCurrentLocation();
    longitude=location.longitude;
    latitude=location.latitude;
  }
  void getData() async{
    http.Response response = await http.get(Uri.http
      ('api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey','mode'));
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
