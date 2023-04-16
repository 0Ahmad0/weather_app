import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/data/data_source/remote_data_source.dart';
import 'package:weatherapp/data/repository/weather_repo.dart';
import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/domain/repository/base_weather_repo.dart';
import 'package:weatherapp/domain/usecases/get_weather_by_city_name.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  Weather? weather;
  String lottePath ='weather.json';
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset('assets/$lottePath',fit: BoxFit.fill,height: double.infinity,width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'cityName'
                  ),
                ),
                const SizedBox(height: 20.0,),
                FloatingActionButton(onPressed: ()async{
                  if(searchController.toString().trim().isNotEmpty){
                    showDialogSearch(context);
                    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
                    BaseWeatherRepo baseWeatherRepo = WeatherRepo(baseRemoteDataSource);
                     weather = await GetWeatherByCityName(baseWeatherRepo).call(cityName: searchController.text);
                    if(weather!=null){
                      if(weather!.main.contains('wind')) lottePath = 'wind.json';
                      if(weather!.main.contains('snow')) lottePath = 'snow.json';
                      if(weather!.main.contains('rain') ) lottePath = 'rain.json';
                      if(weather!.main.contains('clouds')) lottePath = 'clouds.json';
                      setState(() {

                      });
                      Navigator.pop(context);
                    }else{
                    }

                  }
                },child: Icon(Icons.search),),
                const SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(.3),blurRadius: 8),
                    ]
                  ),
                  child: Column(
                    children: [
                      Text(weather?.cityName ?? '',style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900
                      ),),
                      const SizedBox(height: 20.0,),
                      Text(weather?.main ?? '',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900
                      ),),
                      const SizedBox(height: 20.0,),
                      Text(weather?.description ?? '',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  showDialogSearch(BuildContext context){
    showDialog(context: context, builder: (_)=>Center(
      child: Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white
        ),
        child: CircularProgressIndicator(),
      ),
    ));
  }
}

