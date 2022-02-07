import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/ModelWeather.dart';
import 'RepositoryWeather.dart';

///We are taking the event and generating the state
///Events
class EventWeather extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadWeather extends EventWeather {
  final _location;

  LoadWeather(this._location);
  //If the class is equetable we need to override props
  @override
  List<Object> get props => [_location];
}

class changeWeather extends EventWeather {

}

///States 1 - 4
class StateWeather extends Equatable{
  @override
  List<Object> get props => [];
}
///1
class BlankWeather extends StateWeather {

}
///2
class LoadingWeather extends StateWeather {

}
///3
class LoadedWeather extends StateWeather {
  final _weather;

  LoadedWeather(this._weather);

  ModelWeather get getWeather => _weather;
  //If the class is equetable we need to override props
  @override
  List<Object> get props => [_weather];

}
///4
class NotLoadedWeather extends StateWeather {

}

///Bloc --> Passing in the event and the state
class BlocWeather extends Bloc<EventWeather, StateWeather> {
  //BlocWeather(StateWeather initialState) : super(initialState);
  ///Instanciating the repo here
  RepositoryWeather repoWeat;

  BlocWeather(this.repoWeat) : super(BlankWeather());
  
  //BlocWeather(StateWeather initialState) : super(BlankWeather());
  ///We must use async while working with a Stream
  @override
  Stream<StateWeather> mapEventToState(EventWeather event) async* {
    if(event is LoadWeather) {
      yield LoadingWeather();
      //We need to await the response
      try{
        ModelWeather weather = await repoWeat.getWeather(event._location);
        yield LoadedWeather(weather);
      }catch(_){
        yield NotLoadedWeather();
      }
    }else if(event is changeWeather){
      yield BlankWeather();
    }

  }


}

