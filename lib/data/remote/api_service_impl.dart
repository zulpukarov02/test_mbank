import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mbank_test/core/console_messages.dart';
import 'package:mbank_test/core/exception.dart';
import 'package:mbank_test/data/entities/mfr.dart';
import 'package:mbank_test/data/entities/model.dart';
import 'package:mbank_test/data/remote/api_service.dart';
import 'package:mbank_test/data/remote/interceptor/logging_interceptor.dart';

const baseUrl = 'https://vpic.nhtsa.dot.gov/api/vehicles';

class ApiServiceImpl implements ApiService {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: 10 * 1000,
      receiveTimeout: 20 * 1000,
      contentType: 'application/json; charset=utf-8',
    ),
  )..interceptors.addAll([
      LoggingInterceptor(),
    ]);

  @override
  Future<List<Mfr>> getMfrs(int page) async {
    try {
      final response =
          await _dio.get('$baseUrl/getallmanufacturers?format=json&page=$page');
      if (response.statusCode == 200) {
        final mfrs = response.data;
        return (mfrs['Results'] as List)
            .map((mfr) => Mfr.fromJson(mfr))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      ConsoleMessages.showErrorMessage(e);
      rethrow;
    }
  }
  @override
  Future<int> getMakeID(int mfrID) async {
    try {
      final response =
      await _dio.get('$baseUrl/GetMakeForManufacturer/$mfrID?format=json');
      if (response.statusCode == 200) {
        final makes = response.data;
        return (makes['Results'] as List)[0]['Make_ID'];
      } else {
        throw ServerException();
      }
    } catch (e) {
      ConsoleMessages.showErrorMessage(e);
      rethrow;
    }
  }
  @override
  Future<List<Model>> getModels(int makeID) async {
    try {
      final response =
          await _dio.get('$baseUrl/GetModelsForMakeId/$makeID?format=json');
      if (response.statusCode == 200) {
        final models = response.data;
        return (models['Results'] as List)
            .map((model) => Model.fromJson(model))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      ConsoleMessages.showErrorMessage(e);
      rethrow;
    }
  }
}
