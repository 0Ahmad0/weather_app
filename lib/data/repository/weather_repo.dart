import 'package:weatherapp/data/data_source/remote_data_source.dart';
import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/domain/repository/base_weather_repo.dart';

class WeatherRepo implements BaseWeatherRepo{
  final BaseRemoteDataSource baseRemoteDataSource;

  WeatherRepo(this.baseRemoteDataSource);
  @override
  Future<Weather> getWeatherByCityName({required String cityName}) async {
   return( await baseRemoteDataSource.getWeatherByCityName(cityName: cityName))!;
  }

}