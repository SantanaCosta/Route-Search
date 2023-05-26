import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/station.dart';

class RestDataProvider {
  static RestDataProvider helper = RestDataProvider._createInstance();

  RestDataProvider._createInstance();
  final String baseUrl =
      "https://route-search-3976b-default-rtdb.firebaseio.com/";

  final Dio _dio = Dio();

  String sla = "";

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
    } catch (error) {}
  }

  Future<void> updateStation(Station station) async {
    try {
      await _dio.patch('$baseUrl' + ".json", data: {'fields': station.toMap()});
    } catch (error) {}
  }

  Future<void> deleteStation(Station station) async {
    try {
      await _dio.delete('$baseUrl' + '.json' + '$station');
    } catch (error) {}
  }
}
