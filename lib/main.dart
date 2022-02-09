import 'package:flutter/material.dart';
import 'package:weatherapp/BlocWeather.dart';
import 'package:weatherapp/ModelWeather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/RepositoryWeather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Beather',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueGrey,
          body: BlocProvider (
            create: (BuildContext context) => BlocWeather(RepositoryWeather()),
            child: const MyHomePage(),

          ),
        )
    );
  }
}




class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<BlocWeather>(context);
    var cityController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[


        const Center(
            child: SizedBox(
              child: Icon(Icons.wb_sunny, size: 320.0,)
            )
        ),
        const SizedBox(height: 20.0,),


        //BlocBuilder takes in Bloc and state
        BlocBuilder<BlocWeather, StateWeather>(
          builder: (context, state){
            if(state is BlankWeather) {
              return Container(
                padding: const EdgeInsets.only(left: 32, right: 32,),
                child: Column( //Layout
                  children: <Widget>[
                    const Text("Beather Weather", style: TextStyle(fontSize: 42, fontWeight: FontWeight.w600, color: Colors.white),),
                    const Text("", style: TextStyle(fontSize: 42, fontWeight: FontWeight.w300, color: Colors.white),),
                    const SizedBox(height: 24,),
                    TextFormField( //Input field
                      controller: cityController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city, color: Colors.white,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.indigoAccent,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "Location Name",
                        hintStyle: TextStyle(color: Colors.white),

                      ),
                      style: const TextStyle(color: Colors.white),

                    ),

                    const SizedBox(height: 35,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton( //Button
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: (){
                          weatherBloc.add(LoadWeather(cityController.text));
                        },
                        color: Colors.indigoAccent,
                        child: const Text("Search location", style: TextStyle(color: Colors.white, fontSize: 20),),

                      ),
                    )

                  ],
                ),
              );
            } else if(state is LoadingWeather) {
              return const Center(child : CircularProgressIndicator()); ///If it's loading return loading indicator
            } else if(state is LoadedWeather) {
              return ShowResult(state.getWeather, cityController.text);
            } else {
              return const Text("ERROR...", style: TextStyle(color: Colors.white),);
            }
          },
        )

      ],
    );
  }
}
//Show the results view
class ShowResult extends StatelessWidget {
  final ModelWeather weather;
  final String location;

  const ShowResult(this.weather, this.location, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( //Look of the results
        padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(location,style: const TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),

            Text(weather.getTemperature.round().toString()+"C",style: const TextStyle(color: Colors.white70, fontSize: 50),),
            const Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(weather.getMinimum.round().toString()+"C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                    const Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(weather.geMaximum.round().toString()+"C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                    const Text("Max Temperature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),


            SizedBox(
              width: double.infinity,
              height: 60,
              child: FlatButton( //Button
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: (){
                  BlocProvider.of<BlocWeather>(context).add(ChangeWeather());
                },
                color: Colors.indigoAccent,
                child: const Text("Search location", style: TextStyle(color: Colors.white, fontSize: 20),),

              ),
            )
          ],
        )
    );
  }
}


//https://api.openweathermap.org/data/2.5/weather?q=Zadar&APPID=3da71e800856fb77e48ffabb094bcdd8
