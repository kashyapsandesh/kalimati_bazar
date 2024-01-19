

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  Dio? _dio;
  final String baseUrl = "https://kalimatimarket.gov.np";
  ApiService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    initializedInterceptor();
  }

Future<Response> getDailyMarketPrice(String endPoint)async{
  Response? res;
   try {
      log(endPoint);
      res = await _dio!.get(endPoint);
      log("Response Status Code: ${res.statusCode}");

      // Check if response data is available and not null
      if (res.data != null) {
        log("Response Data: ${json.encode(res.data)}");
      } else {
        log("Empty Response Data");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      throw Exception(e.message);
    }
    return res;
}



//setting pretty dio logger;
  initializedInterceptor() {
    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }
}
