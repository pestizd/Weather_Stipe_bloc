import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/ModelWeather.dart';

class RepositoryWeather{
  Future<ModelWeather> getWeather(String location) async{
    final result = await http.Client().get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=43ea6baaad7663dc17637e22ee6f78f2'));

    //final url = 'https://api.openweathermap.org';
    //final uri = Uri.https(url, '/data/2.5/weather?q=$location&APPID=43ea6baaad7663dc17637e22ee6f78f2');
    //final result = await http.get(uri);
    if(result.statusCode != 200)
      throw Exception();


    return parsedJson(result.body);

  }
  ///Decoding responses into Json objects
  ModelWeather parsedJson(final response){
    final decode = json.decode(response);
    //Getting only most important info
    final mainWeather = decode["main"];
    //Returning with fromJson
    return ModelWeather.fromJson(mainWeather);
  }
}
