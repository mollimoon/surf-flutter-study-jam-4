import 'dart:convert';

import 'api_constants.dart';
import 'package:http/http.dart' as http;

import 'get_prediction.dart';

class InfoRepository {
  // чтобы инкапсулировать логику получения данных из api
  Future<Prediction> getPrediction() async {
    final url = Uri.parse(ApiConstants.getPrediction); //парсим в uri-объект
    final response = await http.get(url); // результат выполн-я get-запроса по указанной url
    //в виде объекта response

    if (response.statusCode == 200) {
      final jsonString = response.body; // получение тела ответа
      final json = jsonDecode(jsonString); //преобраз-е body из String в список map-объектов (инфо из api)

      return Prediction.fromJson(json);

    } else {
      throw Exception('Failed to load');
    }
  }
}

