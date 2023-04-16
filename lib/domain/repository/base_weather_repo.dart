import 'package:weatherapp/domain/entities/weather.dart';

abstract class BaseWeatherRepo {
  // one method only => and this layer important from 3 layers[data,presentation,domain]

  Future<Weather> getWeatherByCityName({
    required String cityName,
  });
}
