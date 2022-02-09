///Class that will be used to save the weather which we get from the json
class ModelWeather{
  final temperature;
  final pressure;
  final humidity;
  final maximum;
  final minimum;

  //Needs to be a double
  double get getTemperature => temperature - 272.5;
  double get geMaximum => maximum - 272.5;
  double get getMinimum => minimum - 272.5;

  //Constructor
  ModelWeather(this.temperature, this.pressure, this.humidity, this.maximum, this.minimum);
  ///Converting from Map to ModelWeather type
  factory ModelWeather.fromJson(Map<String, dynamic> json) {
    return ModelWeather(
      json['temperature'],
      json['pressure'],
      json['humidity'],
      json['maximum'],
      json['minimum'],
    );
  }
}