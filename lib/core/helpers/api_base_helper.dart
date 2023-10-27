import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:energy_dashboard/core/resources/constants.dart';
import 'package:energy_dashboard/domain/entities/app_exception.dart';
import 'package:flutter/cupertino.dart';


class ApiBaseHelper{

  Future<Map<String, dynamic>> get(String url) async{
    // http client
    final Dio dio = Dio();

    Map<String, dynamic> responseJson = {};

    try{
      final response = await dio.get(
        Constants.kApiBaseUrl+url,
        options: Options(contentType: Headers.jsonContentType)
      );
      responseJson = _checkStatusCode(response);
    } on DioException catch(e){
      debugPrint('Dio exception: ${e.message}');
    } on Exception catch(e){
      debugPrint('ApiBaseHelper error: $e');
    }
    return responseJson;
  }

  dynamic _checkStatusCode(Response response){
    switch(response.statusCode){
      case 200:
        return json.decode(response.toString());
      case 300:
      case 301:
      case 302:
      case 303:
      case 304:
      case 305:
        throw RedirectionException(response.toString());
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.toString());
      case 404:
      case 405:
      case 406:
      case 408:
      case 409:
      case 410:
        throw BadRequestException(response.toString());
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 505:
      case 506:
        throw ServerException(response.toString());
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}