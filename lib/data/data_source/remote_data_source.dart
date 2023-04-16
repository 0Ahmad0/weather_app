import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weatherapp/core/utils/constants.dart';

import '/data/models/weather.dart';

abstract class BaseRemoteDataSource{
 Future<WeatherModel?> getWeatherByCityName({required String cityName});
}

class RemoteDataSource implements BaseRemoteDataSource{
  @override
  Future<WeatherModel?> getWeatherByCityName({required String cityName}) async {
    try{
      var response = await Dio().get('${AppConstants.baseUrl}/weather?q=$cityName&appid=${AppConstants.appID}');
      print(response.data);
      return WeatherModel.fromJson(response.data);
    }catch(e){
      return null;
    }
  }
}
