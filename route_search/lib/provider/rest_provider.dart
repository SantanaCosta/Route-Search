import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/station.dart';

class RestDataProvider extends ChangeNotifier {
  static RestDataProvider helper = RestDataProvider._createInstance();

  RestDataProvider._createInstance();
  final String baseUrl =
      "https://route-search-3976b-default-rtdb.firebaseio.com/";

  final Dio _dio = Dio();

  Future<List<Station>> fetchStations() async {
    try {
      final response = await _dio.get('$baseUrl' + '.json');
      //print(response.data);
      if (response.statusCode == 200) {
        // Verifica se o response.data não é nulo
        if (response.data != null) {
          final data = response.data;
          // Converte o data para uma lista de Map<String, dynamic>
          final stationsData = (data as Map).values.toList();
          // Converte cada Map para uma instância de Station usando o método fromMap
          final stations =
              stationsData.map((station) => Station.fromMap(station)).toList();
          return stations;
        } else {
          // Retorna uma lista vazia se o response.data for nulo
          return [];
        }
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<void> createStation(Station station) async {
    try {
      await _dio.post('$baseUrl' + ".json", data: station.toMap());
    } catch (error) {}
  }

  Future<void> updateStation(Station station) async {
    try {
      await _dio.patch('$baseUrl' + "/${station.name}.json",
          data: station.toMap());
    } catch (error) {}
  }

  Future<void> deleteStation(Station station) async {
    try {
      await _dio.delete('$baseUrl' + "/${station.name}.json");
    } catch (error) {}
  }
}
