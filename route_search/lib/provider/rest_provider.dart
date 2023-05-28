import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/connection.dart';
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
      if (response.statusCode == 200) {
        final data = response.data;
        final stations = (data['documents'] as List)
            .map((doc) => Station.fromMap(doc['fields']))
            .toList();
        return stations;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<void> createStation(Station station) async {
    try {
      await _dio.post('$baseUrl' + ".json", data: {'fields': station.toMap()});
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateStation(String stationId, Station station) async {
    try {
      await _dio.put('$baseUrl/$stationId' + ".json",
          data: {'fields': station.toMap()});
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteStation(String stationId) async {
    try {
      await _dio.delete('$baseUrl' + '$stationId' + '.json');
    } catch (error) {}
  }
}
