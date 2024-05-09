import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NoticesProvider extends ChangeNotifier {
  Dio? _dio;
  List<Map<String, dynamic>>? _notices;

  List<Map<String, dynamic>>? get notices => _notices;

  NoticesProvider() {
    _dio = Dio();
    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: true,
    ));
  }

  @override
  void dispose() {
    _dio?.interceptors.clear();
    _dio?.close(); // Close Dio instance to cancel ongoing requests
    super.dispose();
  }

  Future<void> fetchNotices() async {
    try {
      final response =
          await _dio!.get('https://kalimatibazar.vercel.app/api/scrape');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');

      if (response.statusCode == 200) {
        // Decode the JSON string to a List<Map<String, dynamic>>
        final List<dynamic> decodedData = json.decode(response.data);

        _notices = List<Map<String, dynamic>>.from(decodedData);
        notifyListeners();
      } else {
        throw Exception('Failed to load notices');
      }
    } catch (error) {
      print('Error fetching notices: $error');
    }
  }
}
