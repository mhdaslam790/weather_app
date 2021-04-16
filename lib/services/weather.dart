import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey =  'f525104ac1daf38fe8e75a329086f44b';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5';
class WeatherModel {

  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;
  var temperature;
  String description;
  String weatherIcon;
  String main;
  String cityName;
  double windSpeed;

  List<WeatherModel> forecast;

  WeatherModel(
      {
        this.time,
        this.sunrise,
        this.sunset,
        this.humidity,
        this.description,
        this.weatherIcon,
        this.main,
        this.cityName,
        this.temperature,
        this.windSpeed,
        this.forecast});

  Future<dynamic> getLocationWeather() async
  {
    Location location= Location();
    await  location.getCurrentLocation();
    NetworkHelper networkHelper=NetworkHelper('$openWeatherMapURL/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData= await networkHelper.getData();
    getForcastData();
    return weatherData;
  }
  Future<List<WeatherModel>> getForcastData() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper=NetworkHelper('$openWeatherMapURL/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var forcastList = forcastJson(await  networkHelper.getData());
    return forcastList;
  }
   List<WeatherModel> forcastJson(Map<String, dynamic> json){
    var forcastData = List<WeatherModel>();
    for(var item in json['list']){
      forcastData.add(WeatherModel(
        time :  item['dt'],
        temperature : item['main']['temp'],
      weatherIcon: getWeatherIcon(item['weather'][0]['id']),
      ));
    }
    return forcastData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
