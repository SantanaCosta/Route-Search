import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RestDataProvider {
  static RestDataProvider helper = RestDataProvider._createInstance();

  RestDataProvider._createInstance();
  final String baseUrl =
      "https://route-search-3976b-default-rtdb.firebaseio.com/";

  final Dio _dio = Dio();

  String sla = "";

  Future<void> createStation() async {
    try {
      await _dio.post('$baseUrl' + ".json", data: {'fields': sla});
    } catch (error) {}
  }

  Future<void> updateStation(station) async {
    try {
      await _dio.put('$baseUrl' + ".json", data: {'fields': sla});
    } catch (error) {}
  }

  Future<void> deleteStation(station) async {
    try {
      await _dio.delete('$baseUrl' + ".json", data: {'fields': sla});
    } catch (error) {}
  }
}
