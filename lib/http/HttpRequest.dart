import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final Dio dioHttpRequest = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8000/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ),
);

final flutterStorage = FlutterSecureStorage();

void setUpDioHttpRequest() {

  dioHttpRequest.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
}