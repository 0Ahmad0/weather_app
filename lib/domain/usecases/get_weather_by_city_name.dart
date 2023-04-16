import 'package:weatherapp/domain/repository/base_weather_repo.dart';

import '../entities/weather.dart';

class GetWeatherByCityName {
  final BaseWeatherRepo weatherRepo;

  GetWeatherByCityName(this.weatherRepo);

  Future<Weather>call({required String cityName}) async {
    return await weatherRepo.getWeatherByCityName(cityName: cityName);
  }
}
