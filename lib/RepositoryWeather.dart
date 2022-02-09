import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/ModelWeather.dart';

//Calling the api
class RepositoryWeather{
  Future<ModelWeather> grabWeather(String location) async{
    final result = await http.Client().get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=3da71e800856fb77e48ffabb094bcdd8'));

    //final url = 'https://api.openweathermap.org';
    //final uri = Uri.https(url, '/data/2.5/weather?q=$location&APPID=43ea6baaad7663dc17637e22ee6f78f2');
    //final result = await http.get(uri);

    ///Checking the response code
    if(result.statusCode != 200) {
      throw Exception();
    }

    //We return the parsed json
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
