import 'package:dio/dio.dart';

class DioClient {
  final dio = Dio();

  DioClient._private() {
    dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 3)
      ..responseType = ResponseType.json
      ..baseUrl = "https://api.escuelajs.co/api/v1";
  }

  static final singletonConstructor = DioClient._private();

  factory DioClient() {
    return singletonConstructor;
  }

  Future<Response> get(
      {required String url, Map<String, dynamic>? query}) async {
    try {
      final response = dio.get(url, queryParameters: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> add(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(url, data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.patch(
        url,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(
        url,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
