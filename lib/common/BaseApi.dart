import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseApi {

  final String baseUrl = "http://127.0.0.1:8000/";

  Future<Response> fetch(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    print("ЗАПРОС GET: $url"); // Добавь это

    try {
      final response = await http.get(url);
      print("ОТВЕТ ОТ СЕРВЕРА (Код): ${response.statusCode}"); // И это

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Response(code: response.statusCode, body: data);
      } else {
        return Response(code: response.statusCode, body: null);
      }
    } catch (e) {
      print("ОШИБКА СЕТИ: $e");
      return Response(code: 1, body: null);
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> postData) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(postData),
      );

      // МЫ ДОЛЖНЫ ДЕКОДИРОВАТЬ BODY ДАЖЕ ЕСЛИ ОШИБКА 400
      dynamic responseBody;
      if (response.body.isNotEmpty) {
        responseBody = json.decode(response.body);
      }

      return Response(code: response.statusCode, body: responseBody);
    } catch (e) {
      print("BaseApi Error: $e");
      return Response(code: 1, body: null);
    }
  }

  Future<Response> patch(String endpoint, Map<String, dynamic> putData) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(putData),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Response(code: response.statusCode, body: null);
      } else {
        return Response(code: response.statusCode, body: null);
      }
    } catch (e) {
      return Response(code: 1, body: null);
    }
  }
  Future<Response> delete(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.delete(url);
      if (response.statusCode == 204) {
        return Response(code: response.statusCode, body: null);
      } else {
        return Response(code: response.statusCode, body: null);
      }
    } catch (e) {
      return Response(code: 1, body: null);
    }
  }

}

class Response {

  final int code;
  final dynamic body;

  Response({required this.code, required this.body});
}