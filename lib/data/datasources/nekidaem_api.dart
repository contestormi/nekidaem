import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nekidaem/data/models/card_model.dart';

abstract class NekidaemRemoteData {
  Future<String> getJWTToken(
      {required String username, required String password});

  Future<List<CardModel>> getAllCards(String token);
}

class NekidaemRemoteDataImpl implements NekidaemRemoteData {
  static const _apiUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1';
  final Dio _dio = Dio();

  @override
  Future<String> getJWTToken(
      {required String username, required String password}) async {
    Map<String, dynamic>? data = {
      'username': username,
      'password': password,
    };
    Map<String, dynamic>? headers = {
      'content-Type': 'application/json',
    };

    try {
      var response = await _dio.post(
        '$_apiUrl/users/login/',
        data: data,
        options: Options(headers: headers),
      );
      return await response.data['token'] as String;
    } on DioError catch (e) {
      throw Exception(e.response);
    }
  }

  @override
  Future<List<CardModel>> getAllCards(String token) async {
    Map<String, dynamic>? headers = {
      'Authorization': 'JWT $token',
    };

    try {
      var response = await _dio.get(
        '$_apiUrl/cards/',
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
      );
      var body = json.decode(response.data) as List<dynamic>;
      return body
          .map((card) => CardModel.fromJson(card as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      throw Exception(e.response);
    }
  }
}
