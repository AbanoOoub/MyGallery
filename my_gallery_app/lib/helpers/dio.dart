import 'package:dio/dio.dart';

import '../network/api_urls/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: NetworkEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
      followRedirects: false,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {"Accept": "application/json"},
      validateStatus: (_) => true,
    ));
  }

  static Future<Response> getData({required String endPoint, required String token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(endPoint);
  }

  static Future<Response> postData({
    required String endPoint,
    required FormData body,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
            'Authorization': 'Bearer $token',
          }
        : null;

    return dio.post(endPoint, queryParameters: query, data: body);
  }
}
