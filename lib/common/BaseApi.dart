import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Добавьте этот пакет в pubspec.yaml

class BaseApi {
  final String baseUrl = "http://127.0.0.1:8000/";

  Future<Response> fetch(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.get(url);
      return Response(code: response.statusCode, body: _decode(response.body));
    } catch (e) {
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
      return Response(code: response.statusCode, body: _decode(response.body));
    } catch (e) {
      return Response(code: 1, body: null);
    }
  }

  Future<Response> patch(String endpoint, Map<String, dynamic> putData) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(putData),
      );
      return Response(code: response.statusCode, body: _decode(response.body));
    } catch (e) {
      return Response(code: 1, body: null);
    }
  }

  Future<Response> delete(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.delete(url);
      return Response(code: response.statusCode, body: null);
    } catch (e) {
      return Response(code: 1, body: null);
    }
  }

  // Универсальный метод для POST/PATCH с файлом
  Future<Response> postWithFile(String endpoint, Map<String, dynamic> data, File? imageFile, {bool isPatch = false}) async {
    final url = Uri.parse("$baseUrl$endpoint");
    var request = http.MultipartRequest(isPatch ? "PATCH" : "POST", url);

    if (imageFile != null) {
      String fileName = basename(imageFile.path);
      request.files.add(await http.MultipartFile.fromPath(
        'photo', // Ключ должен совпадать с полем в БД/Сериализаторе
        imageFile.path,
        filename: fileName,
        contentType: MediaType('image', fileName.split('.').last),
      ));
    }

    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("API Response: ${response.statusCode} - ${response.body}");
      return Response(code: response.statusCode, body: _decode(response.body));
    } catch (e) {
      print("API Error: $e");
      return Response(code: 1, body: null);
    }
  }

  dynamic _decode(String body) {
    if (body.isEmpty) return null;
    try { return json.decode(body); } catch (_) { return body; }
  }
}

class Response {
  final int code;
  final dynamic body;
  Response({required this.code, required this.body});
}